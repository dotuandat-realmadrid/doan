$(document).ready(function() {

	let selectedProductId = null;
	let imagesToDelete = new Set(); // Lưu tên file ảnh muốn xóa
	let newImages = []; // Lưu file ảnh mới
	let images = []; // Danh sách ảnh từ server (tên file)
	let tempImageUrls = []; // Danh sách URL tạm thời
	let suppliers = []; // Danh sách nhà cung cấp
	let categories = []; // Danh sách danh mục
	let discounts = []; // Danh sách discount

	const uploadInput = $('#uploadImage');
	const uploadLabel = uploadInput.closest('.border');
	const imageContainer = uploadInput.closest('.image-preview-container');

	// Di chuyển uploadLabel vào cuối container
	imageContainer.append(uploadLabel);

	// Xử lý khi chọn ảnh mới
	uploadInput.on('change', function(e) {
		const files = Array.from(e.target.files);
		files.forEach(file => {
			if (file.type.startsWith('image/')) {
				newImages.push(file);
				createImagePreview(file, false);
			}
		});
		uploadInput.val(''); // Reset input
	});

	// Hàm tạo preview ảnh
	function createImagePreview(fileOrUrl, isServerImage = true) {
		const isFile = fileOrUrl instanceof File;
		const src = isFile ? URL.createObjectURL(fileOrUrl) : `http://localhost:8080/doan/uploads/${fileOrUrl}`;
		const name = isFile ? fileOrUrl.name : fileOrUrl || 'Server Image';
		const fileName = (isFile ? fileOrUrl.name : fileOrUrl).trim(); // Trim để loại bỏ khoảng trắng

		if (!fileName) {
			console.warn('fileName is empty, skipping preview creation');
			return;
		}

		const imagePreview = $('<div>').addClass('position-relative border rounded d-flex flex-column')
			.css({ width: '100px', height: '100px', overflow: 'hidden', marginLeft: '8px', marginRight: '8px', marginTop: '8px' });

		const img = $('<img>').attr('src', src).addClass('w-100 h-100')
			.css('object-fit', 'cover').attr('title', name);

		const overlay = $('<div>').addClass('position-absolute w-100 h-100 d-flex flex-row justify-content-center align-items-center image-preview-overlay')
			.css({ top: '0', left: '0', backgroundColor: 'rgba(0, 0, 0, 0.5)', opacity: '0', transition: 'opacity 0.2s ease', cursor: 'pointer' });

		// Icon mắt (xem ảnh)
		const viewIcon = $('<i>').addClass('bi bi-eye text-white me-2').css('font-size', '14px');
		viewIcon.on('click', function(e) {
			e.stopPropagation();
			window.open(src, '_blank'); // Mở ảnh trong tab mới
		});

		// Icon thùng rác (xóa ảnh)
		const deleteIcon = $('<i>').addClass('bi bi-trash text-white').css('font-size', '14px');
		deleteIcon.on('click', function(e) {
			e.stopPropagation();
			if (isServerImage && fileName) {
				imagesToDelete.add(fileName);
				images = images.filter(img => img !== fileName); // Xóa khỏi danh sách images
				console.log('Added to imagesToDelete:', fileName); // Debug
			} else {
				newImages = newImages.filter(f => f !== fileOrUrl);
				console.log('Removed from newImages:', fileName); // Debug
			}
			imagePreview.remove();
		});

		imagePreview.on('mouseenter', function() {
			overlay.css('opacity', '1');
		}).on('mouseleave', function() {
			overlay.css('opacity', '0');
		});

		overlay.append(viewIcon, deleteIcon);
		imagePreview.append(img, overlay);
		imageContainer.prepend(imagePreview);

		// Lưu URL tạm thời để thu hồi
		if (isFile) {
			tempImageUrls.push(src);
		}
	}

	// Hàm hiển thị ảnh từ server
	function displayImages() {
		imageContainer.find('.position-relative').remove(); // Xóa preview hiện tại
		images.forEach(image => {
			console.log('Displaying image:', image); // Debug
			createImagePreview(image, true);
		});
		// Hiển thị preview cho ảnh mới
		newImages.forEach(file => {
			createImagePreview(file, false);
		});
		imageContainer.append(uploadLabel); // Đảm bảo nút upload ở cuối
	}

	// Hàm lưu ảnh (xóa và thêm ảnh)
	$('#saveImagesBtn').on('click', function() {
		if (!selectedProductId) {
			alert('Vui lòng chọn sản phẩm!');
			return;
		}

		// Debug trạng thái trước khi gửi
		console.log('=== DEBUG SAVE IMAGES ===');
		console.log('Current images from server:', images);
		console.log('Images to delete:', Array.from(imagesToDelete));
		console.log('New images to add:', newImages.map(f => f.name));

		// Kiểm tra nếu không có thay đổi gì
		if (imagesToDelete.size === 0 && newImages.length === 0) {
			alert('Không có thay đổi để lưu!');
			return;
		}

		// Tính toán keepImages: Bao gồm tất cả ảnh từ server chưa bị xóa
		const keepImages = images.filter(image => {
			const trimmedImage = image ? image.trim() : '';
			const shouldKeep = !imagesToDelete.has(trimmedImage);
			console.log(`Image: "${trimmedImage}", In delete set: ${imagesToDelete.has(trimmedImage)}, Should keep: ${shouldKeep}`);
			return shouldKeep;
		});

		console.log('Final keepImages to send:', keepImages);
		console.log('KeepImages JSON:', JSON.stringify(keepImages));

		const formData = new FormData();

		// Gửi mỗi keepImage riêng lẻ để khớp với @RequestParam List<String>
		keepImages.forEach(image => {
			formData.append('keepImages', image);
		});

		// Thêm ảnh mới nếu có
		newImages.forEach((file, index) => {
			console.log(`Adding new image ${index}: ${file.name}`);
			formData.append('newImages', file);
		});

		// Debug FormData
		console.log('Sending FormData with:');
		console.log('- keepImages count:', keepImages.length);
		console.log('- newImages count:', newImages.length);

		if (confirm('Bạn có chắc muốn cập nhật hình ảnh cho sản phẩm này?')) {
			// Gửi request Ajax
			$.ajax({
				url: `http://localhost:8080/doan/products/${selectedProductId}/images`,
				method: 'PUT',
				data: formData,
				contentType: false,
				processData: false,
				success: function(response) {
					console.log('Server response:', response);
					console.log('Full server response:', JSON.stringify(response));
					if (response.code === 1000) {
						console.log('Images after update: No images in response'); // Debug
						alert('Cập nhật ảnh thành công!');
						imagesToDelete.clear();
						newImages = [];
						tempImageUrls.forEach(url => URL.revokeObjectURL(url));
						tempImageUrls = [];
						loadProductDetails();
					} else {
						alert('Lỗi khi cập nhật ảnh: ' + (response.message || 'Không có thông báo lỗi'));
					}
				},
				error: function(xhr) {
					console.error('Ajax error:', xhr);
					alert('Lỗi khi cập nhật ảnh: ' + (xhr.responseJSON?.message || 'Lỗi không xác định'));
				}
			});
		}
	});

	function loadOptions(callback) {
		// Tải danh mục
		$.ajax({
			url: 'http://localhost:8080/doan/categories',
			method: 'GET',
			success: function(response) {
				if (response.code === 1000 && response.result) {
					categories = response.result;
					let options = '<option value="">Danh mục</option>';
					categories.forEach(cat => {
						options += `<option value="${cat.code}">${cat.name}</option>`;
					});
					$('#categoryCode').html(options);
				}
			},
			error: function(xhr) {
				console.error('Lỗi khi tải danh mục: ', xhr.responseJSON?.message);
			}
		});

		// Tải nhà cung cấp
		$.ajax({
			url: 'http://localhost:8080/doan/categories',
			method: 'GET',
			success: function(response) {
				if (response.code === 1000 && response.result) {
					suppliers = response.result.flatMap(cat => cat.suppliers || []);
					let options = '<option value="">Nhà cung cấp</option>';
					suppliers.forEach(sup => {
						options += `<option value="${sup.code}">${sup.name}</option>`;
					});
					$('#supplierCode').html(options);
					if (callback) callback();
				}
			},
			error: function(xhr) {
				console.error('Lỗi khi tải nhà cung cấp: ', xhr.responseJSON?.message);
				if (callback) callback();
			}
		});

		// Tải mã giảm giá
		$.ajax({
			url: 'http://localhost:8080/doan/discounts',
			method: 'GET',
			success: function(response) {
				if (response.code === 1000 && response.result) {
					discounts = response.result;
					let options = '<option value="">Không áp dụng giảm giá</option>';
					discounts.forEach(disc => {
						options += `<option value="${disc.id}">${disc.name}</option>`;
					});
					$('#discountName').html(options);
				}
			},
			error: function(xhr) {
				console.error('Lỗi khi tải mã giảm giá: ', xhr.responseJSON?.message);
			}
		});
	}

	function loadProductDetails() {
		const urlParams = new URLSearchParams(window.location.search);
		const code = urlParams.get('code');
		if (!code) return;

		$.ajax({
			url: `http://localhost:8080/doan/products/${code}`,
			method: 'GET',
			success: function(response) {
				if (response.code === 1000 && response.result) {
					const product = response.result;
					selectedProductId = product.id;
					$('#productName').text(product.name);
					$('#id').val(product.id);
					$('#code').val(product.code);
					$('#name').val(product.name);
					$('#categoryCode').val(product.categoryCode || '');
					$('#supplierCode').val(product.supplierCode || '');
					$('#price').val(product.price ? product.price.toLocaleString('vi-VN') : '');
					$('#discountPrice').val(product.discountPrice ? product.discountPrice.toLocaleString('vi-VN') : '');
					$('.price').text(product.price ? product.price.toLocaleString('vi-VN') + ' VNĐ' : '');
					$('.discountPrice').text(product.discountPrice ? product.discountPrice.toLocaleString('vi-VN') + ' VNĐ' : '');

					// Tính discount amount
					const originalPrice = product.price || 0;
					const discountPrice = product.discountPrice || 0;
					const discountAmount = originalPrice - discountPrice;
					$('.discount').text(discountAmount > 0 ? discountAmount.toLocaleString('vi-VN') : '0 VNĐ');

					// Ẩn section nếu không có giá khuyến mãi
					if (!product.discountPrice || product.discountPrice >= product.price) {
						$('.mb-3.border.rounded.bg-light').hide();
					} else {
						$('.mb-3.border.rounded.bg-light').show();
					}

					// Ánh xạ discountName thành discountId
					const discount = discounts.find(disc => disc.name === product.discountName);
					$('#discountName').val(discount ? discount.id : '');

					$('#description').val(product.description);
					$('#inventoryQuantity').text(product.inventoryQuantity);
					$('#soldQuantity').text(product.soldQuantity);

					// Hiển thị sao đánh giá
					const avgRating = product.avgRating || 0;
					const starsHtml = createStarRating(avgRating);
					$('#ratingContainer').html(`
                        ${starsHtml}
                        <span class="ms-1 font_size">${avgRating.toFixed(1)}</span>
                        <span class="ms-1 text-muted font_size">(${product.reviewCount || 0} đánh giá)</span>
                    `);

					$('#createdDate').val(product.createdDate ? new Date(product.createdDate).toLocaleString() : '');
					$('#createdBy').val(product.createdBy || '');
					$('#modifiedDate').val(product.modifiedDate ? new Date(product.modifiedDate).toLocaleString() : '');
					$('#modifiedBy').val(product.modifiedBy || '');

					// Lấy và hiển thị ảnh
					console.log('=== DEBUG LOAD PRODUCT ===');
					console.log('Raw product.images:', product.images);

					// Xử lý images - có thể là array của objects hoặc array của strings
					if (product.images && Array.isArray(product.images)) {
						if (product.images.length > 0 && typeof product.images[0] === 'object') {
							// Nếu là array của objects (có imagePath property)
							images = product.images.map(img => img.imagePath || img.fileName || img.name || '').filter(path => path);
						} else {
							// Nếu là array của strings
							images = product.images.filter(img => img && typeof img === 'string');
						}
					} else {
						images = [];
					}

					console.log('Processed images array:', images);
					console.log('Images count:', images.length);

					imagesToDelete.clear();
					newImages = [];
					tempImageUrls.forEach(url => URL.revokeObjectURL(url));
					tempImageUrls = [];
					displayImages();
				} else {
					alert('Không tìm thấy sản phẩm!');
				}
			},
			error: function(xhr) {
				alert('Lỗi khi tải thông tin sản phẩm: ' + (xhr.responseJSON?.message || 'Lỗi không xác định'));
			}
		});
	}

	$('.btn-success.btn-sm').on('click', function() {
		if (!selectedProductId) return alert('Vui lòng chọn sản phẩm!');

		const name = $('#name').val().trim();
		const categoryCode = $('#categoryCode').val();
		const supplierCode = $('#supplierCode').val();
		const description = $('#description').val().trim();
		const priceInput = $('#price').val().replace(/[,.]/g, '');
		const price = parseInt(priceInput) || 0;
		const discountId = $('#discountName').val() || null;

		// Validation
		if (!name) {
			alert('Tên sản phẩm không được để trống!');
			return;
		}
		if (!categoryCode) {
			alert('Vui lòng chọn danh mục!');
			return;
		}
		if (!categories.some(cat => cat.code === categoryCode)) {
			alert('Mã danh mục không hợp lệ!');
			return;
		}
		if (!supplierCode) {
			alert('Vui lòng chọn nhà cung cấp!');
			return;
		}
		if (!suppliers.some(sup => sup.code === supplierCode)) {
			alert('Mã nhà cung cấp không hợp lệ!');
			return;
		}
		if (price < 1000) {
			alert('Giá sản phẩm phải lớn hơn hoặc bằng 1000!');
			return;
		}

		const updateRequest = {
			name,
			categoryCode,
			supplierCode,
			description,
			price,
			discountId
		};

		console.log('Update request:', updateRequest);

		if (confirm('Bạn có chắc muốn cập nhật thông tin của sản phẩm này không?')) {
			$.ajax({
				url: `http://localhost:8080/doan/products/${selectedProductId}`,
				method: 'PUT',
				contentType: 'application/json',
				data: JSON.stringify(updateRequest),
				success: function(response) {
					if (response.code === 1000 && response.result) {
						alert('Cập nhật sản phẩm thành công!');
						loadProductDetails();
					} else {
						alert('Lỗi khi cập nhật: ' + (response.message || 'Không có thông báo lỗi'));
					}
				},
				error: function(xhr) {
					alert('Lỗi khi cập nhật: ' + (xhr.responseJSON?.message || 'Lỗi không xác định'));
				}
			});
		}
	});

	$('.btn-outline-danger.btn-sm').on('click', function() {
		if (!selectedProductId) return alert('Vui lòng chọn sản phẩm!');

		if (confirm('Bạn có chắc muốn xóa sản phẩm này không?')) {
			$.ajax({
				url: `http://localhost:8080/doan/products/${selectedProductId}`,
				method: 'DELETE',
				success: function(response) {
					if (response.code === 1000) {
						alert('Xóa sản phẩm thành công!');
						window.location.href = 'list-product.html';
					} else {
						alert('Lỗi khi xóa: ' + (response.message || 'Không có thông báo lỗi'));
					}
				},
				error: function(xhr) {
					alert('Lỗi khi xóa: ' + (xhr.responseJSON?.message || 'Lỗi không xác định'));
				}
			});
		}
	});

	$('#inventoryReceiptHistory').hide();

	// Xử lý nút "Xem lịch sử nhập kho"
	$('.btn-outline-primary.btn-sm').on('click', function() {
		if (!selectedProductId) {
			alert('Vui lòng chọn sản phẩm!');
			return;
		}

		// Ẩn các phần tử khác
		$('#viewProduct').hide();
		$('#profitPanel').hide();

		// Hiển thị và tải dữ liệu lịch sử nhập kho
		$('#inventoryReceiptHistory').show();
		loadInventoryReceiptHistory(selectedProductId);
	});

	let currentPage = 1; // Di chuyển ra ngoài để giữ trạng thái
	const pageSize = 5;
	let totalPages = 1; // Khởi tạo giá trị mặc định

	// Hàm tải và hiển thị lịch sử nhập kho
	function loadInventoryReceiptHistory(productId) {
		function renderTable(data, totalElements, totalPagesParam) {
			totalPages = totalPagesParam;
			const tbody = $('#inventoryReceiptHistory .table tbody');
			tbody.empty();

			$('#inventoryReceiptHistory strong').text(`Tổng: ${totalElements} phiếu nhập`);

			data.forEach((item, index) => {
				const createdDate = new Date(item.createdDate).toLocaleString('vi-VN', {
					day: '2-digit', month: '2-digit', year: 'numeric',
					hour: '2-digit', minute: '2-digit'
				});
				const modifiedDate = new Date(item.modifiedDate).toLocaleString('vi-VN', {
					day: '2-digit', month: '2-digit', year: 'numeric',
					hour: '2-digit', minute: '2-digit'
				});
				const price = item.price.toLocaleString('vi-VN') + 'đ';
				let statusText = '';
				let statusClass = '';

				if (item.status === 'COMPLETED') {
					statusText = 'Hoàn thành';
					statusClass = 'btn-success';
				} else if (item.status === 'PENDING') {
					statusText = 'Pending - Chờ xử lý';
					statusClass = 'btn-warning';
				} else {
					statusText = 'Đã hủy';
					statusClass = 'btn-danger';
				}

				const row = $(`
	                    <tr>
	                        <th class="align-middle text-center" scope="row">${(currentPage - 1) * pageSize + index + 1}</th>
	                        <td class="align-middle">${item.receiptId}</td>
	                        <td class="align-middle text-center">${item.quantity}</td>
	                        <td class="align-middle">${price}</td>
	                        <td class="align-middle">
								<button class="btn ${statusClass} btn-sm h-25 font_size text-white" disabled>${statusText}</button>
							</td>
	                        <td class="align-middle">
	                            <div><i class="bi bi-calendar"></i> Tạo: ${createdDate}</div>
	                            <div><i class="bi bi-calendar"></i> Sửa: ${modifiedDate}</div>
	                        </td>
	                        <td class="align-middle">
	                            <div><i class="bi bi-person"></i> Tạo: ${item.createdBy}</div>
	                            <div><i class="bi bi-person"></i> Sửa: ${item.modifiedBy}</div>
	                        </td>
	                        <td class="text-center align-middle">
	                            <a href="detail-inventory-receipt.html?id=${item.receiptId}"><i class="bi bi-eye"></i></a>
	                        </td>
	                    </tr>
	                `);
				tbody.append(row);
			});

			renderPagination(currentPage, totalPages);
		}

		function renderPagination(current, totalPagesParam) {
			const pagination = $('#inventoryReceiptHistory .pagination');
			pagination.empty();

			const prevClass = current === 1 ? "disabled" : "";
			pagination.append(`
	                <li class="page-item ${prevClass}">
	                    <a class="page-link" href="#" data-page="${current - 1}">«</a>
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

			if (totalPagesParam <= 6) {
				for (let i = 1; i <= totalPagesParam; i++) {
					addPageItem(i, i === current);
				}
			} else {
				if (current <= 3) {
					for (let i = 1; i <= 3; i++) addPageItem(i, i === current);
					pagination.append('<li class="page-item disabled"><a class="page-link" href="#">...</a></li>');
					for (let i = totalPagesParam - 2; i <= totalPagesParam; i++) addPageItem(i);
				} else if (current >= totalPagesParam - 2) {
					for (let i = 1; i <= 3; i++) addPageItem(i);
					pagination.append('<li class="page-item disabled"><a class="page-link" href="#">...</a></li>');
					for (let i = totalPagesParam - 2; i <= totalPagesParam; i++) addPageItem(i, i === current);
				} else {
					addPageItem(1);
					pagination.append('<li class="page-item disabled"><a class="page-link" href="#">...</a></li>');
					for (let i = current - 1; i <= current + 1; i++) addPageItem(i, i === current);
					pagination.append('<li class="page-item disabled"><a class="page-link" href="#">...</a></li>');
					addPageItem(totalPagesParam);
				}
			}

			const nextClass = current === totalPagesParam || totalPagesParam === 0 ? "disabled" : "";
			pagination.append(`
	                <li class="page-item ${nextClass}">
	                    <a class="page-link" href="#" data-page="${current + 1}">»</a>
	                </li>
	            `);
		}

		$.ajax({
			url: `http://localhost:8080/doan/inventory-receipt-details?productId=${productId}&page=${currentPage}&size=${pageSize}`,
			method: 'GET',
			success: function(response) {
				if (response.code === 1000 && response.result) {
					const data = response.result.data || [];
					const totalElements = response.result.totalElements || 0;
					const totalPages = response.result.totalPage || 1;
					renderTable(data, totalElements, totalPages);
				} else {
					$('#inventoryReceiptHistory .table tbody').html('<tr><td colspan="8" class="text-center">Không có dữ liệu</td></tr>');
					$('#inventoryReceiptHistory .pagination').empty();
					$('#inventoryReceiptHistory strong').text('Tổng: 0 phiếu nhập');
				}
			},
			error: function(xhr) {
				console.error('Lỗi khi tải lịch sử nhập kho:', xhr.responseJSON?.message);
				$('#inventoryReceiptHistory .table tbody').html('<tr><td colspan="8" class="text-center">Lỗi tải dữ liệu</td></tr>');
				$('#inventoryReceiptHistory .pagination').empty();
				$('#inventoryReceiptHistory strong').text('Tổng: 0 phiếu nhập');
			}
		});

		$('#inventoryReceiptHistory').off('click', '.page-link').on('click', '.page-link', function(e) {
			e.preventDefault();
			const page = $(this).data('page');
			if (page && page >= 1 && page <= totalPages && page !== currentPage) {
				currentPage = page;
				loadInventoryReceiptHistory(productId);
			}
		});
	}

	// Tải options và chi tiết sản phẩm
	loadOptions(function() {
		loadProductDetails();
	});

	$('#profitPanel').hide();
	// Cập nhật giao diện lợi nhuận khi nhấn nút
	$('.btnToggleProfit').on('click', function(e) {
		$('#profitPanel').show();
		const urlParams = new URLSearchParams(window.location.search);
		const code = urlParams.get('code');
		if (code) {
			updateProfitPanel(code);
		}
	});

	$('.btn.btn-secondary').on('click', function(e) {
		e.preventDefault();
		location.reload();
	});

	$('.btn-outline-secondary.btn-sm').on('click', function(e) {
		e.preventDefault();
		window.location.href = 'list-product.html';
	});

	// Hàm tính và hiển thị lợi nhuận
	function updateProfitPanel(productCode) {
		$.ajax({
			url: `http://localhost:8080/doan/reports/products/${productCode}`,
			method: 'GET',
			success: function(response) {
				if (response.code === 1000 && response.result) {
					const data = response.result;
					const totalInventoryQuantity = data.totalInventoryQuantity || 0;
					const totalRevenuePrice = data.totalRevenuePrice || 0;
					const totalSoldQuantity = data.totalSoldQuantity || 0;
					const totalRevenue = data.totalRevenue || 0;
					const profit = totalRevenue - totalRevenuePrice;
					const profitPercentage = totalRevenuePrice > 0 ? ((profit / totalRevenuePrice) * 100).toFixed(2) : 0;

					$('#profitPanel .col-sm-6').eq(0).find('.fw-bold').text(totalInventoryQuantity);
					$('#profitPanel .col-sm-6').eq(1).find('.fw-bold').text(totalRevenuePrice.toLocaleString('vi-VN') + ' đ');
					$('#profitPanel .col-sm-6').eq(2).find('.fw-bold').text(totalSoldQuantity + '/' + totalInventoryQuantity);
					$('#profitPanel .col-sm-6').eq(3).find('.fw-bold').text(totalRevenue.toLocaleString('vi-VN') + ' đ');

					const profitContainer = $('#profitPanel .col-sm-12');
					const profitElement = profitContainer.find('.fw-bold');
					profitElement.text(profit.toLocaleString('vi-VN') + ' đ');

					const profitSpan = profitContainer.find('span').eq(0);
					if (profit < 0) {
						profitContainer.removeClass('bg-success').addClass('bg-danger');
						profitSpan.removeClass('text-success').addClass('text-danger');
						profitSpan.text(`↓ -${Math.abs(profit).toLocaleString('vi-VN')}đ (${Math.abs(profitPercentage)}%)`);
					} else {
						profitContainer.removeClass('bg-danger-light').addClass('bg-success-light');
						profitSpan.removeClass('text-danger').addClass('text-success');
						profitSpan.text(`↑ ${profit.toLocaleString('vi-VN')}đ (${profitPercentage}%)`);
					}
				}
			},
			error: function(xhr) {
				alert('Lỗi khi tải dữ liệu lợi nhuận: ' + (xhr.responseJSON?.message || 'Lỗi không xác định'));
			}
		});
	}
});

// Hàm tạo hiển thị sao đánh giá
function createStarRating(rating) {
	const maxStars = 5;
	const fullStars = Math.floor(rating);
	const hasHalfStar = rating % 1 >= 0.5;
	const emptyStars = maxStars - fullStars - (hasHalfStar ? 1 : 0);

	let starsHtml = '';
	for (let i = 0; i < fullStars; i++) {
		starsHtml += '<i class="bi bi-star-fill text-warning"></i>';
	}
	if (hasHalfStar) {
		starsHtml += '<i class="bi bi-star-half text-warning"></i>';
	}
	for (let i = 0; i < emptyStars; i++) {
		starsHtml += '<i class="bi bi-star text-dark"></i>';
	}
	return starsHtml;
}