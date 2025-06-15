/**
 *
 */
function getQueryParam(name) {
	const urlParams = new URLSearchParams(window.location.search);
	return urlParams.get(name);
}

$(document).ready(function() {
	const code = getQueryParam("code");
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

	const userId = localStorage.getItem("id");
	if (userId) {
		renderCartTable(userId);
		loadCart(userId); // Đồng bộ offcanvas và #cart-count
	} else {
		$('table.table tbody').html('<tr><td colspan="5" class="text-center text-muted">Vui lòng đăng nhập để xem giỏ hàng.</td></tr>');
		$('.d-flex.align-items-center.justify-content-between .small span').text('0');
		$('.d-flex.my-4.ms-3 .fw-bold.text-danger').text('0đ');
	}

	// Gắn sự kiện cho nút "Xóa giỏ hàng" - Sử dụng event delegation
	$(document).on('click', '.btn.btn-outline-danger.btn-sm.rounded-4', function(e) {
		e.preventDefault();
		const userId = localStorage.getItem("id");
		if (!userId) {
			alert('Vui lòng đăng nhập để thực hiện thao tác này.');
			window.location.href = 'login.html';
			return;
		}
		if (confirm('Bạn có chắc muốn xóa toàn bộ giỏ hàng?')) {
			deleteEntireCart(userId);
		}
	});

	// Sử dụng event delegation cho nút xóa từng sản phẩm
	$(document).on('click', '.btn-delete-cart-item', function(e) {
		e.preventDefault();
		const userId = localStorage.getItem("id");
		const productId = $(this).data('product-id');

		if (!userId) {
			alert('Vui lòng đăng nhập để thực hiện thao tác này.');
			window.location.href = 'login.html';
			return;
		}

		if (confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?')) {
			deleteCartItem(userId, productId);
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

// Hàm xem danh sách giỏ hàng modal
function loadCart(userId) {
	$.ajax({
		url: `http://localhost:8080/doan/cart/${userId}`, // Thống nhất URL
		method: 'GET',
		xhrFields: {
			withCredentials: true
		},
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
				const productId = item.productId;
				const itemTotal = price * quantity;
				total += itemTotal;

				const cartItem = `
                    <li class="list-group-item d-flex justify-content-between lh-sm" data-product-id="${productId}">
                        <div style="width: 60%;">
                            <h6 class="my-0">${name}</h6>
                            <div class="quantity-input">
                                <button class="minus" data-product-id="${productId}">−</button>
                                <input type="text" min="1" value="${quantity}" class="quantity">
                                <button class="plus" data-product-id="${productId}">+</button>
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
		},
		error: function(xhr, status, error) {
			console.error('Error loading cart:', xhr, status, error);
			if (xhr.status === 401) {
				if (confirm("Bạn cần đăng nhập để xem giỏ hàng. Bạn có muốn đăng nhập ngay không?")) {
					window.location.href = "login.html";
				}
			} else {
				alert("Không thể tải giỏ hàng.");
			}
		}
	});
}

// Sử dụng event delegation cho các nút plus và minus
$(document).on('click', '.plus', function() {
	const userId = localStorage.getItem("id");
	const productId = $(this).data('product-id');

	if (!userId) {
		alert('Vui lòng đăng nhập để thực hiện thao tác này.');
		return;
	}

	$.ajax({
		url: 'http://localhost:8080/doan/cart/items',
		method: 'POST',
		contentType: 'application/json',
		xhrFields: {
			withCredentials: true
		},
		data: JSON.stringify({
			userId: userId,
			productId: productId,
			quantity: 1,
			updatedQuantity: 1
		}),
		success: function() {
			loadCart(userId);
			renderCartTable(userId);
		},
		error: function(xhr) {
			console.error('Error updating quantity:', xhr);
			alert('Không thể cập nhật số lượng.');
		}
	});
});

$(document).on('click', '.minus', function() {
	const userId = localStorage.getItem("id");
	const productId = $(this).data('product-id');
	const $li = $(this).closest('li');
	const currentQuantity = parseInt($li.find('.quantity').val());

	if (!userId) {
		alert('Vui lòng đăng nhập để thực hiện thao tác này.');
		return;
	}

	if (currentQuantity > 0) {
		$.ajax({
			url: 'http://localhost:8080/doan/cart/items',
			method: 'POST',
			contentType: 'application/json',
			xhrFields: {
				withCredentials: true
			},
			data: JSON.stringify({
				userId: userId,
				productId: productId,
				quantity: 1,
				deletedQuantity: 1
			}),
			success: function() {
				loadCart(userId);
				renderCartTable(userId);
			},
			error: function(xhr) {
				console.error('Error updating quantity:', xhr);
				alert('Không thể cập nhật số lượng.');
			}
		});
	}
});

// Hiển thị danh sách sản phẩm trong giỏ hàng
function renderCartTable(userId) {
	$.ajax({
		url: `http://localhost:8080/doan/cart/${userId}`,
		method: 'GET',
		xhrFields: {
			withCredentials: true
		},
		success: function(response) {
			const $tbody = $('table.table-view-cart tbody');
			const $totalItems = $('.total-items');
			const $totalPrice = $('.d-flex.my-4.ms-3 .fw-bold.text-danger');
			const $buttonDelete = $('.btn.btn-outline-danger.btn-sm.rounded-4');

			if (!response || !response.result || !Array.isArray(response.result.items)) {
				console.error('Invalid cart response:', response);
				$tbody.html('<tr><td colspan="5" class="text-center text-muted">Không có sản phẩm nào trong giỏ hàng.</td></tr>');
				$totalItems.text('0');
				$totalPrice.text('0đ');
				$buttonDelete.hide();
				return;
			}

			const items = response.result.items;
			$tbody.empty();

			let totalPrice = 0;
			let totalItems = items.length;

			items.forEach(item => {
				const imageUrl = item.images && item.images.length > 0 ? item.images[0] : 'assets/web/img/product-thumb-7.png';
				const price = item.discountPrice !== null ? item.discountPrice : item.price;
				const itemTotal = price * item.quantity;
				totalPrice += itemTotal;

				const html = `
                        <tr data-product-id="${item.productId}">
                            <td>
                                <div class="d-flex align-middle">
                                    <div class="rounded-circle my-2 mx-2">
                                        <img src="${imageUrl}" alt="${item.productName}" style="width: 40px; height: 40px; object-fit: cover;">
                                    </div>
                                    <div class="mt-1">
                                        <span class="fw-bold small">${item.productName}</span> <br>
                                        <span class="small">${item.productCode || ''}</span>
                                    </div>
                                </div>
                            </td>
                            <td class="align-middle text-end fw-bold">${(price / 1000).toFixed(2)}K</td>
                            <td class="align-middle text-center">${item.quantity}</td>
                            <td class="align-middle text-end fw-bold text-danger">${(itemTotal / 1000).toFixed(2)}K</td>
                            <td class="align-middle text-center">
                                <button class="btn btn-danger btn-sm rounded-circle btn-delete-cart-item" data-product-id="${item.productId}">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                        </tr>
                    `;
				$tbody.append(html);
			});

			// Cập nhật tổng số sản phẩm và tổng tiền
			$totalItems.text(`${totalItems}`);
			$totalPrice.text(`${(totalPrice).toLocaleString()}đ`);
			$buttonDelete.show();

			// Không cần gắn sự kiện ở đây nữa vì đã sử dụng event delegation
		},
		error: function(xhr, status, error) {
			console.error('Error loading cart:', xhr, status, error);
			if (xhr.status === 401) {
				if (confirm("Bạn cần đăng nhập để có thể xem giỏ hàng. Bạn có muốn đăng nhập ngay không?")) {
					window.location.href = "login.html";
				}
			} else {
				$('table.table tbody').html('<tr><td colspan="5" class="text-center text-muted">Không có sản phẩm nào trong giỏ hàng.</td></tr>');
				$('.d-flex.align-items-center.justify-content-between .small span').text('0');
				$('.d-flex.my-4.ms-3 .fw-bold.text-danger').text('0đ');
			}
		}
	});
}

// Xóa sản phẩm trong giỏ hàng
function deleteCartItem(userId, productId) {
	// Debug log
	console.log('Attempting to delete item:', { userId, productId });

	$.ajax({
		url: `http://localhost:8080/doan/cart/${userId}/items/${productId}`,
		method: 'DELETE',
		contentType: 'application/json',
		xhrFields: {
			withCredentials: true
		},
		success: function(response) {
			console.log('Delete success:', response);
			alert('Bạn đã xóa sản phẩm khỏi giỏ hàng thành công!');
			renderCartTable(userId);
			loadCart(userId);
		},
		error: function(xhr, status, error) {
			console.error('Delete error:', xhr, status, error);
			console.error('Response text:', xhr.responseText);

			let message = 'Không thể xóa sản phẩm.';
			try {
				const errorResponse = JSON.parse(xhr.responseText);
				message = errorResponse.message || message;
			} catch (e) {
				// Không thể parse JSON, sử dụng message mặc định
			}

			if (xhr.status === 401) {
				localStorage.removeItem("id");
				if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
					window.location.href = 'login.html';
				}
			} else {
				alert(message);
			}
		}
	});
}

// Xóa giỏ hàng
function deleteEntireCart(userId) {
	$.ajax({
		url: `http://localhost:8080/doan/cart/${userId}`,
		method: 'DELETE',
		xhrFields: {
			withCredentials: true
		},
		success: function(response) {
			alert('Bạn đã xóa toàn bộ giỏ hàng thành công!');
			renderCartTable(userId);
			loadCart(userId);
		},
		error: function(xhr) {
			let message = xhr.responseJSON?.message || 'Không thể xóa giỏ hàng.';
			if (xhr.status === 401) {
				localStorage.removeItem("id");
				if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
					window.location.href = 'login.html';
				}
			}
			alert(message);
			console.log(xhr.responseText);
		}
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
			console.log('myInfo API response:', response);
			if (response && response.code === 1000 && response.result) {
				const user = response.result;
				localStorage.setItem("id", user.id);
				$('#email').val(user.username);
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
				$('#email').val('');
				$('table.table-view-order tbody').html('<tr><td colspan="4" class="text-center text-muted">Vui lòng đăng nhập để xem đơn hàng.</td></tr>');
				$('.total-items').text('0');
				$('.total-quantities').text('0');
				$('.total-price').text('0đ');
			}
		},
		error: function(xhr, status, error) {
			console.error('Error checking login status:', status, error, xhr.responseText);
			showLoginLink();
			$('#email').val('');
			$('table.table-view-order tbody').html('<tr><td colspan="4" class="text-center text-muted">Vui lòng đăng nhập để xem đơn hàng.</td></tr>');
			$('.total-items').text('0');
			$('.total-quantities').text('0');
			$('.total-price').text('0đ');
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
			withCredentials: true
		},
		success: function(response) {
			localStorage.removeItem("id");
			console.log('Logout successful:', response);
			document.cookie = 'token=; Max-Age=0; path=/;';
			window.location.href = 'index.html';
		},
		error: function(xhr, status, error) {
			console.error('Logout error:', status, error, xhr.responseText);
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