/**
 * 
 */
function getQueryParam(name) {
	const urlParams = new URLSearchParams(window.location.search);
	return urlParams.get(name);
}

$(document).ready(function() {
	const code = getQueryParam("code");
	// Lấy danh sách sản phẩm tìm kiểm ***** search *****
	const name = getQueryParam('name');
	const categoryCode = getQueryParam('categoryCode');
	const sortBy = getQueryParam('sortBy');
	const direction = getQueryParam('direction');
	if (name || categoryCode || sortBy) {
		const queryData = {
			page: 1,
			size: 12,
			sortBy: sortBy || 'point',
			direction: direction || 'DESC',
			searchField: 'name',
			searchValue: name || categoryCode
		};

		if (name) {
			queryData.name = name;
			$('.display-5.mb-3.name').text(`Tìm kiếm theo tên: ${name}`);
		} else if (categoryCode) {
			queryData.categoryCode = categoryCode;
			queryData.searchField = 'categoryCode';
			$('.display-5.mb-3.name').text(`Tìm kiếm theo danh mục: ${categoryCode}`);
		}

		loadProductsBy(queryData);
	}

	// Gọi hàm khi mở offcanvas
	$('#offcanvasCart').on('show.bs.offcanvas', function() {
		const userId = localStorage.getItem("id");
		loadCart(userId);
	});

	// Hàm tìm kiếm sản phẩm ***** All *****
	$('#search-form').submit(function(e) {
		e.preventDefault();
		const name = $('#search-input').val().trim();
		if (name !== '') {
			// Chuyển hướng sang trang search.html kèm theo query string
			window.location.href = `search.html?name=${encodeURIComponent(name)}`;
		}
	});

	// Kiểm tra trạng thái đăng nhập ***** All *****
	checkLoginStatus();

	// Xử lý sự kiện đăng xuất ***** All *****
	$('#logout').on('click', function(e) {
		e.preventDefault();
		logout();
	});

});

// Hàm hiển thị sản phẩm khi tìm kiếm **search**
function loadProductsBy(data) {
	const searchFields = ['name', 'id', 'code', 'categoryCode', 'supplierCode', 'minPrice', 'maxPrice'];
	const currentFieldIndex = searchFields.indexOf(data.searchField);
	const searchValue = data.searchValue;
	const isNumeric = !isNaN(searchValue) && !isNaN(parseFloat(searchValue));

	$.ajax({
		url: 'http://localhost:8080/doan/products',
		type: 'GET',
		data: {
			page: data.page,
			size: data.size,
			sortBy: data.sortBy,
			direction: data.direction,
			name: data.name || null,
			id: data.id || null,
			code: data.code || null,
			categoryCode: data.categoryCode || null,
			supplierCode: data.supplierCode || null,
			minPrice: data.minPrice ? parseInt(data.minPrice) : null,
			maxPrice: data.maxPrice ? parseInt(data.maxPrice) : null
		},
		success: function(response) {
			// Kiểm tra phản hồi từ API
			if (!response || !response.result || !Array.isArray(response.result.data)) {
				console.error('Invalid API response:', response);
				$('.row.g-4').empty().append('<h1 class="w-100 text-center text-muted py-4">Không tìm thấy sản phẩm nào.</h1>');
				$('#pagination-container').hide();
				return;
			}

			const products = response.result.data;
			const totalPages = response.result.totalPage || 1;
			const currentPage = response.result.currentPage || 1;
			const container = $('.row.g-4');
			container.empty();

			if (products.length === 0 && currentFieldIndex < searchFields.length - 1) {
				// Tìm trường tiếp theo hợp lệ
				let nextFieldIndex = currentFieldIndex + 1;
				let nextField = searchFields[nextFieldIndex];

				// Bỏ qua minPrice/maxPrice nếu searchValue không phải số
				while (nextFieldIndex < searchFields.length &&
					((nextField === 'minPrice' || nextField === 'maxPrice') && !isNumeric)) {
					nextFieldIndex++;
					nextField = searchFields[nextFieldIndex];
				}

				if (nextFieldIndex >= searchFields.length) {
					console.log('No products found after all valid fields tried.');
					$('#pagination-container').hide();
					container.append('<h1 class="w-100 text-center text-muted py-4">Không tìm thấy sản phẩm nào.</h1>');
					return;
				}

				const newData = { ...data, [data.searchField]: null, searchField: nextField };

				// Gán giá trị tìm kiếm cho trường tiếp theo
				if (nextField === 'minPrice' || nextField === 'maxPrice') {
					newData[nextField] = parseFloat(searchValue);
				} else {
					newData[nextField] = searchValue;
				}

				// Cập nhật tiêu đề
				const fieldLabels = {
					name: 'tên',
					id: 'ID',
					code: 'mã sản phẩm',
					categoryCode: 'mã danh mục',
					supplierCode: 'mã nhà cung cấp',
					minPrice: 'giá tối thiểu',
					maxPrice: 'giá tối đa'
				};
				$('.display-5.mb-3.name').text(`Tìm kiếm theo ${fieldLabels[nextField]}: ${searchValue}`);
				loadProductsBy(newData);
			} else {
				if (products.length === 0) {
					console.log('Hiding pagination due to no products.');
					$('#pagination-container').hide();
					container.append('<h1 class="w-100 text-center text-muted py-4">Không tìm thấy sản phẩm nào.</h1>');
				} else {
					console.log('Showing products:', products.length);
					$('#pagination-container').show();

					products.forEach((product, index) => {
						const delay = (0.1 + index * 0.15).toFixed(2);
						const inventoryQuantity = product.inventoryQuantity || 0;
						const initialValue = inventoryQuantity > 0 ? 1 : 0;
						const html = `
                                <div class="col-xl-3 col-md-6 wow fadeInDown" data-wow-delay="${delay}s">
                                    <div class="product-item" data-product="${product.code}" data-product-id="${product.id}">
                                        <figure>
                                            <a href="product-detail.html?code=${encodeURIComponent(product.code)}" title="${product.name}">
                                                <img src="${product.images?.[0] || 'assets/web/img/product-thumb-7.png'}" alt="${product.name}" class="tab-image">
                                            </a>
                                        </figure>
                                        <div class="d-flex flex-column text-center">
                                            <h3 class="fs-6 fw-normal">${product.name}</h3>
                                            <div>
                                                <span class="rating">
                                                    ${generateStars(product.avgRating || 0)}
                                                </span>
                                                <span>(${product.reviewCount || 0})</span>
                                            </div>
                                            ${product.discountName ? `
                                            <div>
                                                <span class="badge border border-dark-subtle rounded-0 fw-normal px-1 fs-7 lh-1 text-muted">
                                                    ${product.discountName}
                                                </span>
                                            </div>` : ''}
                                            <div class="d-flex justify-content-center align-items-center gap-2">
                                                ${product.discountPrice == null ?
								`<span class="text-dark fw-semibold">$${(product.price / 1000).toFixed(2)}K</span>` :
								`<del>$${(product.price / 1000).toFixed(2)}K</del>
                                                     <span class="text-dark fw-semibold">$${(product.discountPrice / 1000).toFixed(2)}K</span>`
							}
                                            </div>
                                            <div class="button-area p-3 pt-0">
                                                <div class="row g-1 mt-2">
                                                    <div class="col-3">
                                                        <input type="number" name="quantity" 
                                                               class="form-control border-dark-subtle input-number quantity" 
                                                               value="${initialValue}" 
                                                               min="0" 
                                                               max="${inventoryQuantity}"
                                                               ${inventoryQuantity <= 0 ? 'readonly' : ''}>
                                                    </div>
                                                    <div class="col-7">
                                                        <a href="#" class="btn btn-primary rounded-1 p-2 fs-7 btn-cart ${inventoryQuantity <= 0 ? 'disabled' : ''}">
                                                            <svg width="18" height="18"><use xlink:href="#cart"></use></svg> Thêm vào giỏ
                                                        </a>
                                                    </div>
                                                    <div class="col-2">
                                                        <a href="#" class="btn btn-outline-dark rounded-1 p-2 fs-6">
                                                            <svg width="18" height="18"><use xlink:href="#heart"></use></svg>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>`;

						// Tạo jQuery element và gắn sự kiện
						const $element = $(html);
						attachAddToCartHandler($element);
						container.append($element);
					});

					renderPagination(currentPage, totalPages, data);
					handleQuantityInputs();
				}
			}
		},
		error: function(xhr, status, error) {
			console.error('API error:', status, error, xhr.responseText);
			$('.row.g-4').empty().append('<p class="w-100 text-center text-muted py-4">Lỗi khi tải sản phẩm. Vui lòng thử lại.</p>');
			$('#pagination-container').hide();
		}
	});
}

// Hàm phân trang ***** search *****
function renderPagination(currentPage, totalPages, originalData) {
	const paginationContainer = $('#pagination-container');
	paginationContainer.empty();

	const createPageItem = (page, text, active = false, disabled = false) => {
		return `<li class="page-item ${active ? 'active' : ''} ${disabled ? 'disabled' : ''}">
                        <a class="page-link" href="#" data-page="${page}">${text}</a>
                    </li>`;
	};

	paginationContainer.append(createPageItem(currentPage - 1, 'Previous', false, currentPage === 1));

	const visiblePages = 5;
	let start = Math.max(1, currentPage - Math.floor(visiblePages / 2));
	let end = Math.min(start + visiblePages - 1, totalPages);
	start = Math.max(1, end - visiblePages + 1);

	for (let i = start; i <= end; i++) {
		paginationContainer.append(createPageItem(i, i, i === currentPage));
	}

	paginationContainer.append(createPageItem(currentPage + 1, 'Next', false, currentPage === totalPages));

	paginationContainer.find('.page-link').click(function(e) {
		e.preventDefault();
		const page = parseInt($(this).data('page'));
		if (!isNaN(page) && page >= 1 && page <= totalPages) {
			const newData = { ...originalData, page };
			loadProductsBy(newData);
		}
	});
}

// Hàm xử lý sự kiện cho các input số lượng ***** All *****
function handleQuantityInputs() {
	$('.input-number').each(function() {
		const $input = $(this);
		const max = parseInt($input.attr('max')) || 0;
		const $productItem = $input.closest('.product-item');

		// Kiểm tra khi thay đổi giá trị
		$input.on('change input', function() {
			let value = parseInt($input.val()) || 0;

			if (value < 0) {
				$input.val(0);
			} else if (value > max) {
				$input.val(max);
			}
		});
	});
}

// Hàm tính sao đánh giá ***** All *****
function generateStars(rating) {
	let fullStars = Math.floor(rating);
	let halfStar = rating % 1 >= 0.5;
	let starsHtml = "";

	for (let i = 0; i < fullStars; i++) {
		starsHtml += `<svg width="18" height="18" class="text-warning"><use xlink:href="#star-full"></use></svg>`;
	}
	if (halfStar) {
		starsHtml += `<svg width="18" height="18" class="text-warning"><use xlink:href="#star-half"></use></svg>`;
	}

	// Thêm sao rỗng nếu cần
	const emptyStars = 5 - fullStars - (halfStar ? 1 : 0);
	for (let i = 0; i < emptyStars; i++) {
		starsHtml += `<svg width="18" height="18" class="text-warning"><use xlink:href="#star-empty"></use></svg>`;
	}

	return starsHtml;
}

// Hàm xem danh sách giỏ hàng modal
function loadCart(userId) {
	$.ajax({
		url: `/doan/cart/${userId}`,
		method: 'GET',
		success: function(response) {
			console.log('Cart API response:', response);
			const cartItemsContainer = $('#cart-items');
			const cartCountBadge = $('#cart-count');
			const $viewCartButton = $('.btn-view-cart');
			const $checkoutButton = $('.btn-view-order');

			// Kiểm tra phản hồi API
			if (!response || !response.result || !Array.isArray(response.result.items)) {
				console.error('Giỏ hàng không hợp lệ:', response);
				cartItemsContainer.find('li:not(:last)').remove();
				cartItemsContainer.find('li:last strong').text('0 VNĐ');
				cartCountBadge.text('0');
				cartItemsContainer.prepend('<li class="list-group-item text-center text-muted">Chưa có sản phẩm nào</li>');
				$viewCartButton.hide();
				$checkoutButton.hide();
				return;
			}

			const items = response.result.items;
			let total = 0;

			// Xóa tất cả trừ dòng Total (dòng cuối)
			cartItemsContainer.find('li:not(:last)').remove();

			// Kiểm tra nếu không có sản phẩm
			if (items.length === 0) {
				cartItemsContainer.find('li:last strong').text('0 VNĐ');
				cartCountBadge.text('0');
				cartItemsContainer.prepend('<li class="list-group-item text-center text-muted">Chưa có sản phẩm nào</li>');
				$viewCartButton.hide();
				$checkoutButton.hide();
				return;
			}

			// Hiển thị các nút khi có sản phẩm
			$viewCartButton.show();
			$checkoutButton.show();

			items.forEach(item => {
				const name = item.productName;
				const price = item.discountPrice !== null ? item.discountPrice : item.price;
				const quantity = item.quantity;
				const productId = item.productId; // Giả sử API trả về productId
				const itemTotal = price * quantity;
				total += itemTotal;

				const cartItem = `
                    <li class="list-group-item d-flex justify-content-between lh-sm" data-product-id="${productId}">
                        <div style="width: 60%;">
                            <h6 class="my-0">${name}</h6>
                            <div class="quantity-input">
                                <button class="minus">−</button>
                                <input type="text" min="1" value="${quantity}" class="quantity">
                                <button class="plus">+</button>
                            </div>
                        </div>
                        <span class="text-body-secondary">${itemTotal.toLocaleString()} VNĐ</span>
                    </li>
                `;
				$(cartItem).insertBefore(cartItemsContainer.find('li:last'));
			});

			// Cập nhật tổng tiền
			cartItemsContainer.find('li:last strong').text(`${total.toLocaleString()} VNĐ`);

			// Cập nhật badge số lượng
			$('#cart-count').text(items.length);

			// Gán sự kiện cho các nút plus và minus
			$('.plus').off('click').on('click', function() {
				const $li = $(this).closest('li');
				const productId = $li.data('product-id');
				const $input = $li.find('.quantity');
				let currentQuantity = parseInt($input.val());
				const newQuantity = currentQuantity + 1;

				$.ajax({
					url: 'http://localhost:8080/doan/cart/items',
					method: 'POST',
					contentType: 'application/json',
					data: JSON.stringify({
						userId: userId,
						productId: productId,
						quantity: 1,
						updatedQuantity: 1
					}),
					success: function() {
						loadCart(userId); // Làm mới giỏ hàng
					},
					error: function() {
						alert('Không thể cập nhật số lượng.');
					}
				});
			});

			$('.minus').off('click').on('click', function() {
				const $li = $(this).closest('li');
				const productId = $li.data('product-id');
				const $input = $li.find('.quantity');
				let currentQuantity = parseInt($input.val());
				if (currentQuantity > 0) {
					$.ajax({
						url: 'http://localhost:8080/doan/cart/items',
						method: 'POST',
						contentType: 'application/json',
						data: JSON.stringify({
							userId: userId,
							productId: productId,
							quantity: 1,
							deletedQuantity: 1
						}),
						success: function() {
							loadCart(userId); // Làm mới giỏ hàng
						},
						error: function() {
							alert('Không thể cập nhật số lượng.');
						}
					});
				}
			});
		},
		error: function(xhr, status, error) {
			if (xhr.status === 401) {
				if (confirm("Bạn cần đăng nhập để xem giỏ hàng. Bạn có muốn đăng nhập ngay không?")) {
					window.location.href = "login.html";
				}
			} else {
				alert("Không thể tải giỏ hàng.");
				console.log(xhr.responseText, status, error);
			}

		}
	});
}

// Hàm thêm vào giỏ hàng
function attachAddToCartHandler($element) {
	$element.find('.btn-cart').on('click', function(e) {
		e.preventDefault(); // Ngăn hành vi mặc định của thẻ <a>

		const $productItem = $(this).closest('.product-item');
		const productId = $productItem.data('product-id');
		const quantity = parseInt($productItem.find('.quantity').val());
		const userId = localStorage.getItem("id");

		if (quantity <= 0) {
			alert('Vui lòng chọn số lượng hợp lệ.');
			return;
		}

		// Gửi request POST để thêm vào giỏ hàng
		$.ajax({
			url: 'http://localhost:8080/doan/cart/items',
			method: 'POST',
			contentType: 'application/json',
			xhrFields: {
				withCredentials: true // Gửi cookie cùng yêu cầu
			},
			data: JSON.stringify({
				userId: userId,
				productId: productId,
				quantity: quantity,
				updatedQuantity: quantity
			}),
			success: function() {
				alert('Thêm vào giỏ hàng thành công!');
				// Gọi lại hàm loadCart để cập nhật giỏ hàng
				loadCart(userId);
			},
			error: function(xhr, status, error) {
				if (xhr.status === 401) {
					if (confirm("Bạn cần đăng nhập để thêm vào giỏ hàng. Bạn có muốn đăng nhập ngay không?")) {
						window.location.href = "login.html";
					}
				} else {
					console.log(xhr.responseText, status, error);
				}
			}
		});
	});
}

// Hàm kiểm tra đăng nhập ***** All *****
function checkLoginStatus() {
	$.ajax({
		url: 'http://localhost:8080/doan/users/myInfo',
		type: 'GET',
		xhrFields: {
			withCredentials: true
		},
		success: function(response) {
			console.log('myInfo API response:', response); // Debug phản hồi API myInfo
			if (response && response.code === 1000 && response.result) {
				const user = response.result;
				localStorage.setItem("id", user.id);
				$('#email').val(user.username); // Điền email từ username
				$('#user-name').text(user.fullName || 'Unknown User');
				$('#user-role').text(user.roles && user.roles.length > 0 ? user.roles.join(', ') : 'User');

				// Kiểm tra vai trò ADMIN hoặc STAFF_INVENTORY
				if (user.roles && (user.roles.includes('ADMIN') || user.roles.includes('STAFF_INVENTORY'))) {
					$('#admin-link').show();
					$('#admin-menu').show();
				} else {
					$('#admin-link').hide();
					$('#admin-menu').hide();
				}

				// Hiển thị profile menu, ẩn login link
				$('#profile-menu').show();
				$('#login-link').hide();
			} else {
				showLoginLink();
			}
		},
		error: function(xhr, status, error) {
			console.error('Error checking login status:', status, error, xhr.responseText);
			showLoginLink();
		}
	});
}

// Hàm hiển thị đăng nhập hoặc chưa đăng nhập ***** All *****
function showLoginLink() {
	$('#profile-menu').hide();
	$('#login-link').show();
	$('#admin-link').hide();
	$('#admin-menu').hide();
}

// Hàm đăng xuất ***** All *****
function logout() {
	$.ajax({
		url: 'http://localhost:8080/doan/auth/logout',
		type: 'POST',
		contentType: 'application/json',
		data: null,
		xhrFields: {
			withCredentials: true // Gửi cookie cùng yêu cầu
		},
		success: function(response) {
			localStorage.removeItem("id");
			console.log('Logout successful:', response);
			// Xóa cookie token phía client
			document.cookie = 'token=; Max-Age=0; path=/;';
			window.location.href = 'index.html';
		},
		error: function(xhr, status, error) {
			console.error('Logout error:', status, error, xhr.responseText);
			// Xóa cookie và chuyển hướng để đảm bảo đăng xuất
			document.cookie = 'token=; Max-Age=0; path=/;';
			window.location.href = 'login.html';
		}
	});
}

// Chuyển trang cart - order
$('.btn-lg.btn-view-cart').on('click', function(e) {
	e.preventDefault();
	checkLoginStatus();
	const userId = localStorage.getItem("id");
	if (!userId) {
		alert("Bạn chưa đăng nhập!");
		if (confirm("Bạn cần đăng nhập để xem giỏ hàng. Bạn có muốn đăng nhập ngay không?")) {
			window.location.href = "login.html";
		}
		return;
	}
	window.location.href = "cart.html";
});

$('.btn-view-order').on('click', function(e) {
	e.preventDefault();
	checkLoginStatus();
	const userId = localStorage.getItem("id");
	if (!userId) {
		alert("Bạn chưa đăng nhập!");
		if (confirm("Bạn cần đăng nhập để đặt hàng. Bạn có muốn đăng nhập ngay không?")) {
			window.location.href = "login.html";
		}
		return;
	}
	window.location.href = "order.html";
});