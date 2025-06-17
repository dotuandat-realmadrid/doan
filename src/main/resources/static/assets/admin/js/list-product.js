// Khai báo biến toàn cục
let currentPage = 1;
let currentSize = 10;
let sortBy = 'point';
let direction = 'DESC';
let selectedFiles = []; // Khai báo selectedFiles toàn cục

$(document).ready(function() {
	// Kiểm tra trạng thái đăng nhập
	checkLoginStatus();

	// Xử lý sự kiện đăng xuất
	$('#logout').on('click', function(e) {
		e.preventDefault();
		logout();
	});

	// Tải sản phẩm khi trang tải
	loadProducts(currentPage, currentSize, sortBy, direction);

	// Tải danh sách danh mục và nhà cung cấp
	loadCategories();
	loadSuppliers();

	// Tải danh mục và nhà cung cấp vào modal
	loadCategoriesForModal();
	loadSuppliersForModal();

	// Xử lý thay đổi số lượng sản phẩm trên mỗi trang
	$('.form-select.size-select').on('change', function() {
		currentSize = parseInt($(this).val()) || 10;
		loadProducts(1, currentSize, sortBy, direction);
	});

	// Xử lý sự kiện tìm kiếm
	$('form[name="search-filters"]').on('submit', function(e) {
		e.preventDefault();
		applyFilters();
	});

	// Xử lý nút xóa bộ lọc
	$('button[type="reset"]').on('click', function() {
		$('form[name="search-filters"]')[0].reset();
		loadProducts(1, currentSize, sortBy, direction);
	});

	// Xử lý checkbox "Chọn tất cả"
	$('#selectAll').on('change', function() {
		const isChecked = $(this).is(':checked');
		$('table tbody input[type="checkbox"]').prop('checked', isChecked);
		toggleDeleteButton();
	});

	// Xử lý checkbox riêng lẻ
	$('table tbody').on('change', 'input[type="checkbox"]', function() {
		toggleDeleteButton();
		const allChecked = $('table tbody input[type="checkbox"]').length ===
			$('table tbody input[type="checkbox"]:checked').length;
		$('#selectAll').prop('checked', allChecked);
	});

	// Xử lý nút xóa
	$('#deleteSelected').on('click', function() {
		if (confirm('Bạn có chắc chắn muốn xóa các sản phẩm đã chọn?')) {
			deleteSelectedProducts();
		}
	});

	// Xử lý form thêm sản phẩm
	$('#addProductForm').on('submit', function(e) {
		e.preventDefault();
		addNewProduct();
	});

	// Xử lý ảnh
	const uploadInput = $('#uploadImage');
	const uploadLabel = uploadInput.closest('.border');

	const imageContainer = $('<div>').addClass('d-flex flex-wrap align-items-start').css('gap', '0px');
	uploadLabel.parent().prepend(imageContainer);
	imageContainer.append(uploadLabel);

	uploadInput.on('change', function(e) {
		const files = Array.from(e.target.files);
		//console.log('Files selected:', files.map(f => f.name)); // Debug
		files.forEach(file => {
			if (file.type.startsWith('image/')) {
				selectedFiles.push(file);
				createImagePreview(file);
			}
		});
		uploadInput.val(''); // Reset input
	});

	function createImagePreview(file) {
		const reader = new FileReader();

		reader.onload = function(e) {
			const imagePreview = $('<div>').addClass('position-relative border rounded d-flex flex-column')
				.css({ width: '100px', height: '100px', overflow: 'hidden', marginLeft: '8px', marginRight: '8px', marginTop: '8px' });

			const img = $('<img>').attr('src', e.target.result).addClass('w-100 h-100')
				.css('object-fit', 'cover').attr('title', file.name);

			const overlay = $('<div>').addClass('position-absolute w-100 h-100 d-flex justify-content-center align-items-center')
				.css({ top: '0', left: '0', backgroundColor: 'rgba(0, 0, 0, 0.5)', opacity: '0', transition: 'opacity 0.2s ease', cursor: 'pointer' });

			const deleteIcon = $('<i>').addClass('bi bi-trash text-white').css('font-size', '14px');

			overlay.on('click', function(e) {
				e.stopPropagation();
				removeImage(imagePreview, file);
			});

			imagePreview.on('mouseenter', function() {
				overlay.css('opacity', '1');
			}).on('mouseleave', function() {
				overlay.css('opacity', '0');
			});

			overlay.append(deleteIcon);
			imagePreview.append(img, overlay);
			imageContainer.prepend(imagePreview);
		};

		reader.readAsDataURL(file);
	}

	function removeImage(imageElement, file) {
		selectedFiles = selectedFiles.filter(f => f !== file);
		imageElement.remove();
		//console.log('Remaining files:', selectedFiles.map(f => f.name)); // Debug
	}

	uploadLabel.css({ minWidth: '100px', flexShrink: '0' });

	const style = $('<style>').text(`
        .cursor-pointer { cursor: pointer !important; }
        .image-preview-container { display: flex; flex-wrap: wrap; gap: 0; }
        .image-preview-container .border:hover { border-color: #0d6efd !important; }
        .image-preview-container .position-relative { flex-shrink: 0; }
        .image-preview-overlay { transition: opacity 0.2s ease-in-out; }
        .image-preview-overlay:hover { opacity: 1 !important; }
    `);
	$('head').append(style);

	imageContainer.addClass('image-preview-container');
});

// Hàm hiển thị/ẩn nút xóa và cập nhật văn bản
function toggleDeleteButton() {
	const checkedCount = $('table tbody input[type="checkbox"]:checked').length;
	//console.log('Checked count:', checkedCount);
	$('#deleteSelected').toggle(checkedCount > 0);
	$('#deleteSelected').text(`Xóa ${checkedCount} sản phẩm`);
}

// Hàm xóa các sản phẩm đã chọn
function deleteSelectedProducts() {
	const selectedIds = [];
	$('table tbody input[type="checkbox"]:checked').each(function() {
		const row = $(this).closest('tr');
		const productId = row.data('product-id');
		if (productId) {
			selectedIds.push(productId);
		}
	});

	//console.log('Selected product IDs:', selectedIds);

	if (selectedIds.length === 0) {
		alert('Vui lòng chọn ít nhất một sản phẩm để xóa!');
		return;
	}

	$.ajax({
		url: `http://localhost:8080/doan/products/${selectedIds.join(',')}`,
		method: 'DELETE',
		success: function(response) {
			//console.log('Delete response:', response);
			if (response.message === "Deleted successfully") {
				alert('Xóa sản phẩm thành công!');
				// Reset tất cả checkbox
				$('#selectAll').prop('checked', false);
				$('table tbody input[type="checkbox"]').prop('checked', false);
				// Cập nhật nút xóa
				toggleDeleteButton();
				// Tải lại danh sách sản phẩm
				loadProducts(currentPage, currentSize, sortBy, direction);
			} else {
				alert('Lỗi: ' + (response.message || 'Xóa sản phẩm thất bại!'));
			}
		},
		error: function(xhr) {
			//console.error('Delete error:', xhr.responseText);
			const errorMsg = xhr.responseJSON?.message || xhr.responseText || 'Lỗi không xác định';
			alert(`Lỗi khi xóa sản phẩm: ${errorMsg}`);
		}
	});
}

// Hàm thêm sản phẩm mới
function addNewProduct() {
	const productData = {
		categoryCode: $('#categorySelect').val(),
		supplierCode: $('#supplierSelect').val(),
		code: $('#productCode').val().trim(),
		name: $('#productName').val().trim(),
		description: $('#productDescription').val().trim(),
		price: parseInt($('#productPrice').val()) || 0
	};

	//console.log('Product data:', productData);

	// Validate dữ liệu
	if (!productData.categoryCode) {
		alert('Vui lòng chọn danh mục!');
		return;
	}
	if (!productData.supplierCode) {
		alert('Vui lòng chọn nhà cung cấp!');
		return;
	}
	if (!productData.code) {
		alert('Vui lòng nhập mã sản phẩm!');
		return;
	}
	if (!productData.name) {
		alert('Vui lòng nhập tên sản phẩm!');
		return;
	}
	if (productData.price < 1000) {
		alert('Giá sản phẩm phải ít nhất 1000 VNĐ!');
		return;
	}

	// Gửi request thêm sản phẩm
	$.ajax({
		url: 'http://localhost:8080/doan/products',
		method: 'POST',
		contentType: 'application/json',
		data: JSON.stringify(productData),
		success: function(response) {
			//console.log('Add product response:', response);
			if (response.result) {
				const productId = response.result.id;
				// Tải lên ảnh nếu có
				uploadProductImages(productId);
			} else {
				alert('Lỗi: ' + (response.message || 'Thêm sản phẩm thất bại!'));
			}
		},
		error: function(xhr) {
			//console.error('Add product error:', xhr.responseText);
			const errorMsg = xhr.responseJSON?.message || xhr.responseText || 'Lỗi không xác định';
			alert(`Lỗi khi thêm sản phẩm: ${errorMsg}`);
		}
	});
}

// Hàm tải lên ảnh sản phẩm
function uploadProductImages(productId) {
	const files = getSelectedImages();
	//console.log('Selected images:', files.map(f => f.name)); // Debug

	if (files.length === 0) {
		//console.log('No images to upload');
		alert('Thêm sản phẩm thành công!');
		$('#addProductModal').modal('hide');
		clearFormAndImages();
		loadProducts(currentPage, currentSize, sortBy, direction);
		return;
	}

	const formData = new FormData();
	files.forEach(file => {
		formData.append('files', file);
	});

	// Debug FormData
	for (let [key, value] of formData.entries()) {
		//console.log('FormData entry:', key, value.name);
	}

	$.ajax({
		url: `http://localhost:8080/doan/products/${productId}/images`,
		method: 'POST',
		data: formData,
		contentType: false,
		processData: false,
		success: function(response) {
			//console.log('Upload images response:', response);
			alert('Thêm sản phẩm và ảnh thành công!');
			$('#addProductModal').modal('hide');
			clearFormAndImages();
			loadProducts(currentPage, currentSize, sortBy, direction);
		},
		error: function(xhr) {
			//console.error('Upload images error:', xhr.responseText);
			const errorMsg = xhr.responseJSON?.message || xhr.responseText || 'Lỗi không xác định';
			alert(`Thêm sản phẩm thành công nhưng lỗi khi tải ảnh: ${errorMsg}`);
			$('#addProductModal').modal('hide');
			clearFormAndImages();
			loadProducts(currentPage, currentSize, sortBy, direction);
		}
	});
}

// Hàm xóa form và ảnh sau khi thêm
function clearFormAndImages() {
	$('#addProductForm')[0].reset();
	clearAllImages();
	$('#categorySelect').val('');
	$('#supplierSelect').val('');
}

// Hàm tải danh mục vào modal
function loadCategoriesForModal() {
	$.ajax({
		url: 'http://localhost:8080/doan/categories',
		method: 'GET',
		success: function(response) {
			if (response.code === 1000) {
				const categorySelect = $('#categorySelect');
				categorySelect.empty();
				categorySelect.append('<option value="">Chọn danh mục</option>');
				response.result.forEach(category => {
					categorySelect.append(`<option value="${category.code}">${category.name}</option>`);
				});
			} else {
				alert('Lỗi khi tải danh mục cho modal!');
			}
		},
		error: function() {
			alert('Lỗi kết nối khi tải danh mục cho modal!');
		}
	});
}

// Hàm tải nhà cung cấp vào modal
function loadSuppliersForModal() {
	$.ajax({
		url: 'http://localhost:8080/doan/suppliers',
		method: 'GET',
		success: function(response) {
			if (response.code === 1000) {
				const supplierSelect = $('#supplierSelect');
				supplierSelect.empty();
				supplierSelect.append('<option value="">Chọn nhà cung cấp</option>');
				response.result.forEach(supplier => {
					supplierSelect.append(`<option value="${supplier.code}">${supplier.name}</option>`);
				});
			} else {
				alert('Lỗi khi tải nhà cung cấp cho modal!');
			}
		},
		error: function() {
			alert('Lỗi kết nối khi tải nhà cung cấp cho modal!');
		}
	});
}

// Hàm render danh sách sản phẩm
function renderProducts(data) {
	//console.log('Render products data:', data);
	let html = '';
	$('#totalProducts').text(0);

	if (data && data.data) {
		const totalItems = data.totalItems || data.totalElements || data.totalCount || data.data.length || 0;
		//console.log('Total items:', totalItems);
		$('#totalProducts').text(totalItems);

		data.data.forEach((item, index) => {
			const price = item.price || 0;
			const discountPrice = item.discountPrice || 0;
			const imageSrc = item.images && item.images.length > 0 ? item.images[0] : '';
			//console.log('Image source for product', item.code, ':', imageSrc); // Debug

			let priceHtml = '';
			if (item.discountName || discountPrice > 0) {
				priceHtml = `
                    <span style="text-decoration: line-through;">${price.toLocaleString()}đ</span><br>
                    <span class="text-danger">${discountPrice.toLocaleString()}đ</span>
                `;
			} else {
				priceHtml = `${price.toLocaleString()}đ`;
			}

			html += `
                <tr data-product-id="${item.id}">
                    <td class="align-middle"><input type="checkbox" class="product-checkbox"></td>
                    <th class="align-middle" scope="row">${(data.currentPage - 1) * data.pageSize + index + 1}</th>
                    <td>
                        <div class="d-flex align-items-center">
                            <img src="/doan/uploads/${imageSrc}" width="50" height="50" class="me-2">
                            <div class="d-block ms-2">
                                ${item.name || 'Không có tên'}<br>
                                <span class="text-muted">Mã: ${item.code || 'Không có mã'}</span><br>
                                <span class="badge bg-warning">${item.discountName || ''}</span>
                            </div>
                        </div>
                    </td>
                    <td class="align-middle">
                        <span class="badge bg-primary">${item.categoryCode || 'Không có danh mục'}</span><br>
                        <span class="badge bg-success">${item.supplierCode || 'Không có hãng'}</span>
                    </td>
                    <td class="align-middle text-center">${priceHtml}</td>
                    <td class="align-middle text-center">${item.soldQuantity || 0}</td>
                    <td class="align-middle text-center">${item.inventoryQuantity || 0}</td>
                    <td class="align-middle text-center">
                        <span class="text-warning">★★★★★</span><br>
                        <span>(${item.reviewCount || 0} đánh giá)</span>
                    </td>
                    <td class="align-middle text-center">
                        <a href="detail-product.html?code=${item.code}" class="view-product"><i class="bi bi-eye"></i></a>
                    </td>
                </tr>
            `;
		});
	} else {
		//console.warn('No valid data:', data);
		html = '<tr><td colspan="9" class="text-center">Không có dữ liệu sản phẩm</td></tr>';
	}
	$('table tbody').html(html);
}

// Hàm tải sản phẩm
function loadProducts(page, size, sortBy, direction) {
	const request = getFilterData();
	$.ajax({
		url: 'http://localhost:8080/doan/products',
		method: 'GET',
		data: {
			page: page,
			size: size,
			sortBy: sortBy,
			direction: direction,
			...request
		},
		success: function(response) {
			//console.log('Response from server:', response);
			if (response.code === 1000) {
				renderProducts(response.result);
				renderPagination(response.result.currentPage, response.result.totalPage);
			} else if (response.code === 1012) {
				if (confirm("Bạn cần đăng nhập để xem danh sách sản phẩm. Bạn có muốn đăng nhập ngay không?")) {
					window.location.href = "login.html";
				}
			} else {
				alert('Có lỗi xảy ra khi tải sản phẩm!');
			}
		},
		error: function(xhr) {
			alert('Lỗi: ' + xhr.responseText);
			//console.error('Error:', xhr.responseText);
		}
	});
}

// Hàm lấy dữ liệu bộ lọc
function getFilterData() {
	return {
		id: $('#id').val() || '',
		code: $('#code').val() || '',
		name: $('#name').val() || '',
		minPrice: $('.input-group input[placeholder="Giá từ"]').val() || '',
		maxPrice: $('.input-group input[placeholder="Giá đến"]').val() || '',
		categoryCode: $('#category').val() !== 'Tất cả danh mục' ? $('#category').val() : '',
		supplierCode: $('#supplier').val() !== 'Tất cả nhà cung cấp' ? $('#supplier').val() : '',
		sortBy: $('#sortBy').val() || 'point',
		direction: $('input[name="sortOrder"]:checked').val() === 'asc' ? 'ASC' : 'DESC'
	};
}

// Hàm áp dụng bộ lọc
function applyFilters() {
	currentPage = 1;
	sortBy = $('#sortBy').val() || 'point';
	direction = $('input[name="sortOrder"]:checked').val() === 'asc' ? 'ASC' : 'DESC';
	loadProducts(currentPage, currentSize, sortBy, direction);
}

// Hàm render phân trang
function renderPagination(current, totalPages) {
	const pagination = $(".pagination");
	pagination.empty();

	const prevClass = current === 1 ? "disabled" : "";
	pagination.append(`
        <li class="page-item ${prevClass}">
            <a class="page-link" href="#" data-page="${current - 1}">Previous</a>
        </li>
    `);

	const addPageItem = (i, isActive = false) => {
		const activeClass = isActive ? "active" : "";
		pagination.append(`
            <li class="page-item ${activeClass}">
                <a class="page-link" href="#" data-page="${i}">${i}</a>
            </li>
        `);
	};

	const addEllipsis = () => {
		pagination.append(`
            <li class="page-item disabled">
                <a class="page-link" href="#">...</a>
            </li>
        `);
	};

	if (totalPages <= 6) {
		for (let i = 1; i <= totalPages; i++) {
			addPageItem(i, i === current);
		}
	} else {
		if (current <= 3) {
			for (let i = 1; i <= 3; i++) addPageItem(i, i === current);
			addEllipsis();
			for (let i = totalPages - 2; i <= totalPages; i++) addPageItem(i);
		} else if (current >= totalPages - 3) {
			if (current >= totalPages - 2) {
				for (let i = 1; i <= 3; i++) addPageItem(i);
				addEllipsis();
				for (let i = totalPages - 2; i <= totalPages; i++) addPageItem(i, i === current);
			} else {
				addPageItem(1);
				addEllipsis();
				for (let i = current - 1; i <= current + 1; i++) addPageItem(i, i === current);
				addEllipsis();
				addPageItem(totalPages);
			}
		} else {
			addPageItem(1);
			addEllipsis();
			for (let i = current - 1; i <= current + 1; i++) addPageItem(i, i === current);
			addEllipsis();
			addPageItem(totalPages);
		}
	}

	const nextClass = current === totalPages ? "disabled" : "";
	pagination.append(`
        <li class="page-item ${nextClass}">
            <a class="page-link" href="#" data-page="${current + 1}">Next</a>
        </li>
    `);

	$('.page-link').on('click', function(e) {
		e.preventDefault();
		const page = $(this).data('page');
		if (page && page >= 1 && page <= totalPages) {
			currentPage = page;
			loadProducts(currentPage, currentSize, sortBy, direction);
		}
	});
}

// Hàm tải danh sách danh mục
function loadCategories() {
	$.ajax({
		url: 'http://localhost:8080/doan/categories',
		method: 'GET',
		success: function(response) {
			if (response.code === 1000) {
				const categorySelect = $('#category');
				categorySelect.empty();
				categorySelect.append('<option value="">Tất cả danh mục</option>');
				response.result.forEach(category => {
					categorySelect.append(`<option value="${category.code}">${category.name}</option>`);
				});
			} else {
				alert('Lỗi khi tải danh mục!');
			}
		},
		error: function() {
			alert('Lỗi kết nối khi tải danh mục!');
		}
	});
}

// Hàm tải danh sách nhà cung cấp
function loadSuppliers() {
	$.ajax({
		url: 'http://localhost:8080/doan/suppliers',
		method: 'GET',
		success: function(response) {
			if (response.code === 1000) {
				const supplierSelect = $('#supplier');
				supplierSelect.empty();
				supplierSelect.append('<option value="">Tất cả nhà cung cấp</option>');
				response.result.forEach(supplier => {
					supplierSelect.append(`<option value="${supplier.code}">${supplier.name}</option>`);
				});
			} else {
				alert('Lỗi khi tải nhà cung cấp!');
			}
		},
		error: function() {
			alert('Lỗi kết nối khi tải nhà cung cấp!');
		}
	});
}

// Hàm kiểm tra trạng thái đăng nhập
function checkLoginStatus() {
	$.ajax({
		url: 'http://localhost:8080/doan/users/myInfo',
		type: 'GET',
		xhrFields: { withCredentials: true },
		success: function(response) {
			//console.log('myInfo API response:', response);
			const user = response.result;
			localStorage.setItem("id", user.id);
			$('#user-name').text(user.fullName || 'Unknown User');
			$("#full-name").text(user.fullName || 'Unknown User');
			$('#user-role').text(user.roles && user.roles.length > 0 ? user.roles.join(', ') : 'User');
		},
		error: function(xhr, status, error) {
			if (xhr.status === 401) {
				if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
					localStorage.removeItem("id");
					window.location.href = 'login.html';
					return;
				}
			} else {
				//console.error('Error checking login status:', status, error, xhr.responseText);
			}
		}
	});
}

// Hàm đăng xuất
function logout() {
	$.ajax({
		url: 'http://localhost:8080/doan/auth/logout',
		type: 'POST',
		contentType: 'application/json',
		data: null,
		xhrFields: { withCredentials: true },
		success: function(response) {
			localStorage.removeItem("id");
			//console.log('Logout successful:', response);
			document.cookie = 'token=; Max-Age=0; path=/;';
			window.location.href = 'login.html';
		},
		error: function(xhr, status, error) {
			//console.error('Logout error:', status, error, xhr.responseText);
			localStorage.removeItem("id");
			document.cookie = 'token=; Max-Age=0; path=/;';
			window.location.href = 'login.html';
		}
	});
}

function getSelectedImages() {
	return selectedFiles; // Trả về selectedFiles trực tiếp
}

function clearAllImages() {
	const imageContainer = $('.image-preview-container');
	const uploadLabel = $('#uploadImage').closest('.border');

	imageContainer.find('.position-relative').not(uploadLabel).remove();
	$('#uploadImage').val('');
	selectedFiles = []; // Reset selectedFiles
	//console.log('Cleared all images'); // Debug
}

// **************************************************** Modal Import ***************************************************************
// Xử lý modal Import QR
document.addEventListener('DOMContentLoaded', () => {
	const modal = document.getElementById('importQRModal');
	if (!modal) {
		//console.error('Không tìm thấy modal importQRModal');
		return;
	}

	modal.addEventListener('shown.bs.modal', () => {
		//console.log('Modal đã hiển thị');

		if (typeof Html5Qrcode === 'undefined') {
			document.getElementById('qr-reader-result').innerText = 'Lỗi: Không thể tải thư viện quét QR. Vui lòng kiểm tra kết nối mạng.';
			//console.error('Html5Qrcode not defined');
			return;
		}

		const html5QrCode = new Html5Qrcode('qr-reader');
		const qrReaderResult = document.getElementById('qr-reader-result');
		const submitBtn = document.getElementById('submitBtn'); // Nút "Thêm mới"
		const updateBtn = document.querySelector('button[onclick*="update"]'); // Nút "Cập nhật"
		const qrFileInput = document.getElementById('qrFileUpload');
		const qrFileInfoContainer = document.getElementById('qrFileInfoContainer');
		const qrFileNameText = document.getElementById('qrFileNameText');
		const qrRemoveFileBtn = document.getElementById('qrRemoveFileBtn');
		const qrFileIcon = document.querySelector('#qrFileInfoContainer .bi-image');

		if (!qrReaderResult || !submitBtn || !updateBtn || !qrFileInput || !qrFileInfoContainer || !qrFileNameText || !qrRemoveFileBtn || !qrFileIcon) {
			//console.error('Không tìm thấy các phần tử cần thiết trong modal importQRModal');
			return;
		}

		function showQRFileInfo(fileName) {
			qrFileNameText.textContent = fileName;
			qrFileInfoContainer.hidden = false;
			qrFileIcon.hidden = false;
			qrRemoveFileBtn.hidden = false;
		}

		function updateSubmitButtons() {
			const hasFile = qrFileInput.files.length > 0;
			const hasQRContent = document.getElementById('qrContent').value.trim() !== '';
			submitBtn.disabled = !hasFile && !hasQRContent;
			updateBtn.disabled = !hasFile && !hasQRContent;
		}

		document.getElementById('qrContent').addEventListener('change', updateSubmitButtons);
		qrFileInput.addEventListener('change', () => {
			const file = qrFileInput.files[0];
			if (file) {
				showQRFileInfo(file.name);
			}
			updateSubmitButtons();
		});

		const qrDropArea = document.getElementById('qrDropArea');
		qrDropArea.addEventListener('click', () => qrFileInput.click());

		qrDropArea.addEventListener('dragover', (e) => {
			e.preventDefault();
			qrDropArea.classList.add('border-primary', 'bg-light');
		});

		qrDropArea.addEventListener('dragleave', () => {
			qrDropArea.classList.remove('border-primary', 'bg-light');
		});

		qrDropArea.addEventListener('drop', (e) => {
			e.preventDefault();
			qrDropArea.classList.remove('border-primary', 'bg-light');

			const files = e.dataTransfer.files;
			if (files.length > 0) {
				qrFileInput.files = files;
				showQRFileInfo(files[0].name);
				updateSubmitButtons();
			}
		});

		qrRemoveFileBtn.addEventListener('click', () => {
			qrFileInput.value = '';
			qrFileNameText.textContent = '';
			qrFileInfoContainer.hidden = true;
			qrFileIcon.hidden = true;
			qrRemoveFileBtn.hidden = true;
			updateSubmitButtons();
		});

		let isScanning = false;
		Html5Qrcode.getCameras().then(devices => {
			//console.log('Danh sách camera:', devices);
			if (devices && devices.length) {
				const defaultCameraId = devices[0].id;

				html5QrCode.start(
					defaultCameraId,
					{
						fps: 30,
						qrbox: { width: 300, height: 300 },
						aspectRatio: 1.0,
						experimentalFeatures: {
							useBarCodeDetectorIfSupported: true
						}
					},
					(decodedText) => {
						document.getElementById('qrContent').value = decodedText;
						document.getElementById('qrContent').dispatchEvent(new Event('change'));
						qrReaderResult.innerText = 'Đã quét thành công';
						//console.log('Đã quét thành công');
					},
					(errorMessage) => {
						//console.error('Lỗi quét:', errorMessage);
					}
				).then(() => {
					isScanning = true;
					qrReaderResult.innerText = 'Camera đã bật. Đưa mã QR vào khung để quét.';
					//console.log('Camera đã bật');
				}).catch(err => {
					qrReaderResult.innerText = 'Không thể khởi động camera: ' + err;
					//console.error('Lỗi khởi động camera:', err);
				});
			} else {
				qrReaderResult.innerText = 'Không tìm thấy camera trên thiết bị.';
				//console.error('Không tìm thấy camera');
			}
		}).catch(err => {
			qrReaderResult.innerText = 'Lỗi khi lấy danh sách camera: ' + err;
			//console.error('Lỗi lấy danh sách camera:', err);
		});

		modal.addEventListener('hidden.bs.modal', () => {
			if (isScanning) {
				html5QrCode.stop().then(() => {
					isScanning = false;
					//console.log('Camera đã tắt khi đóng modal');
				}).catch(err => {
					//console.error('Lỗi tắt camera khi đóng modal:', err);
				});
			}
		});
	});
});

// Xử lý modal importExcelModal
document.addEventListener('DOMContentLoaded', () => {

	const dropArea = document.getElementById('dropArea');
	const excelInput = document.getElementById('excelFile');
	const fileInfoContainer = document.getElementById('fileInfoContainer');
	const fileNameText = document.getElementById('fileNameText');
	const removeFileBtn = document.getElementById('removeFileBtn');
	const fileIcon = document.getElementById('fileIcon');

	if (!dropArea || !excelInput || !fileInfoContainer || !fileNameText || !removeFileBtn || !fileIcon) {
		//console.error('Không tìm thấy các phần tử cần thiết trong modal importExcelModal');
		return;
	}

	function showFileInfo(fileName) {
		fileNameText.textContent = fileName;
		fileInfoContainer.hidden = false;
		fileIcon.hidden = false;
		removeFileBtn.hidden = false;
	}

	dropArea.addEventListener('click', () => excelInput.click());

	excelInput.addEventListener('change', () => {
		const file = excelInput.files[0];
		if (file) {
			showFileInfo(file.name);
		}
	});

	dropArea.addEventListener('dragover', (e) => {
		e.preventDefault();
		dropArea.classList.add('border-primary', 'bg-light');
	});

	dropArea.addEventListener('dragleave', () => {
		dropArea.classList.remove('border-primary', 'bg-light');
	});

	dropArea.addEventListener('drop', (e) => {
		e.preventDefault();
		dropArea.classList.remove('border-primary', 'bg-light');

		const files = e.dataTransfer.files;
		if (files.length > 0) {
			excelInput.files = files;
			showFileInfo(files[0].name);
		}
	});

	removeFileBtn.addEventListener('click', () => {
		excelInput.value = '';
		fileNameText.textContent = '';
		fileInfoContainer.hidden = true;
		fileIcon.hidden = true;
		removeFileBtn.hidden = true;
	});

	// Bổ sung xử lý AJAX cho nút "Thêm mới" và "Cập nhật"
	const submitExcelCreate = document.getElementById('submitExcelCreate');
	const submitExcelUpdate = document.getElementById('submitExcelUpdate');
	const modalMessage = document.getElementById('modalMessage');

	// Hàm hiển thị thông báo trong modal, tự động ẩn sau 60 giây
	function showModalMessage(message, type = 'danger') {
		modalMessage.classList.remove('d-none', 'alert-danger', 'alert-success');
		modalMessage.classList.add(`alert-${type}`);
		modalMessage.textContent = message;

		// Tự động ẩn thông báo sau 60 giây
		setTimeout(() => {
			modalMessage.classList.add('d-none');
			modalMessage.textContent = '';
			modalMessage.classList.remove(`alert-${type}`);
		}, 60000); // 60 giây = 60000 ms
	}

	// Hàm gửi file Excel qua AJAX
	function sendExcelFile(action) {
		const file = excelInput.files[0];
		if (!file) {
			showModalMessage('Vui lòng chọn file Excel trước khi thực hiện!');
			return;
		}

		const formData = new FormData();
		formData.append('file', file);

		// Debug FormData
		for (let [key, value] of formData.entries()) {
			//console.log('FormData entry:', key, value.name);
		}

		const method = action === 'create' ? 'POST' : 'PUT';
		const url = action === 'create'
			? 'http://localhost:8080/doan/products/import-excel'
			: 'http://localhost:8080/doan/products/import-excel';

		$.ajax({
			url: url,
			method: method,
			data: formData,
			contentType: false,
			processData: false,
			success: function(response) {
				//console.log(`${action} response:`, response);
				if (response.code === 1000) {
					showModalMessage(`Đã ${action === 'create' ? 'thêm mới' : 'cập nhật'} sản phẩm thành công!`, 'success');
					// Reset file input và thông tin file
					excelInput.value = '';
					fileNameText.textContent = '';
					fileInfoContainer.hidden = true;
					fileIcon.hidden = true;
					removeFileBtn.hidden = true;
					// Tải lại danh sách sản phẩm
					setTimeout(() => {
						$('#importExcelModal').modal('hide');
						loadProducts(currentPage, currentSize, sortBy, direction);
					}, 1500);
				} else {
					showModalMessage(`Lỗi: ${response.message || 'Thực hiện thất bại!'}`);
				}
			},
			error: function(xhr) {
				//console.error(`${action} error:`, xhr.responseText);
				const errorMsg = xhr.responseJSON?.message || xhr.responseText || 'Lỗi không xác định';
				showModalMessage(`Lỗi khi ${action === 'create' ? 'thêm mới' : 'cập nhật'} sản phẩm: ${errorMsg}`);
			}
		});
	}

	// Xử lý nút "Thêm mới"
	submitExcelCreate.addEventListener('click', () => {
		sendExcelFile('create');
	});

	// Xử lý nút "Cập nhật"
	submitExcelUpdate.addEventListener('click', () => {
		sendExcelFile('update');
	});
});

// Xử lý modal importPDFModal
document.addEventListener('DOMContentLoaded', () => {

	const pdfDropArea = document.getElementById('pdfDropArea');
	const pdfInput = document.getElementById('pdfFile');
	const pdfFileInfoContainer = document.getElementById('pdfFileInfoContainer');
	const pdfFileNameText = document.getElementById('pdfFileNameText');
	const pdfRemoveFileBtn = document.getElementById('pdfRemoveFileBtn');
	const pdfFileIcon = document.getElementById('pdfFileIcon');

	if (!pdfDropArea || !pdfInput || !pdfFileInfoContainer || !pdfFileNameText || !pdfRemoveFileBtn || !pdfFileIcon) {
		//console.error('Không tìm thấy các phần tử cần thiết trong modal importPDFModal');
		return;
	}

	function showPDFFileInfo(fileName) {
		pdfFileNameText.textContent = fileName;
		pdfFileInfoContainer.hidden = false;
		pdfFileIcon.hidden = false;
		pdfRemoveFileBtn.hidden = false;
	}

	pdfDropArea.addEventListener('click', () => pdfInput.click());

	pdfInput.addEventListener('change', () => {
		const file = pdfInput.files[0];
		if (file) {
			showPDFFileInfo(file.name);
		}
	});

	pdfDropArea.addEventListener('dragover', (e) => {
		e.preventDefault();
		pdfDropArea.classList.add('border-primary', 'bg-light');
	});

	pdfDropArea.addEventListener('dragleave', () => {
		pdfDropArea.classList.remove('border-primary', 'bg-light');
	});

	pdfDropArea.addEventListener('drop', (e) => {
		e.preventDefault();
		pdfDropArea.classList.remove('border-primary', 'bg-light');

		const files = e.dataTransfer.files;
		if (files.length > 0) {
			pdfInput.files = files;
			showPDFFileInfo(files[0].name);
		}
	});

	pdfRemoveFileBtn.addEventListener('click', () => {
		pdfInput.value = '';
		pdfFileNameText.textContent = '';
		pdfFileInfoContainer.hidden = true;
		pdfFileIcon.hidden = true;
		pdfRemoveFileBtn.hidden = true;
	});
});

// Xử lý modal importAIModal
document.addEventListener('DOMContentLoaded', () => {
	const aiForm = document.querySelector('#importAIModal form');
	if (aiForm) {
		aiForm.addEventListener('submit', (e) => {
			const quantity = document.getElementById('quantity').value;
			if (quantity < 1 || quantity > 100) {
				e.preventDefault();
				alert('Vui lòng nhập số lượng từ 1 đến 100.');
			}
		});
	}
});