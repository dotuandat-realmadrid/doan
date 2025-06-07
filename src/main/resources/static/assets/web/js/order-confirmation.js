/**
 * 
 */
$(document).ready(function() {
    const orderId = localStorage.getItem("orderId");
    const userId = localStorage.getItem("id");
    if (!orderId) {
        alert('Không tìm thấy thông tin đơn hàng. Vui lòng thử lại.');
        window.location.href = 'index.html';
        return;
    }
	
	// Kiểm tra trạng thái đăng nhập ***** All *****
	checkLoginStatus();

	// Xử lý sự kiện đăng xuất ***** All *****
	$('#logout').on('click', function(e) {
		e.preventDefault();
		logout();
	});

	// Gọi hàm khi mở offcanvas
	$('#offcanvasCart').on('show.bs.offcanvas', function() {
		const userId = localStorage.getItem("id");
		loadCart(userId);
	});

    // Gọi API để lấy chi tiết đơn hàng
    $.ajax({
        url: `http://localhost:8080/doan/orders/${orderId}`,
        method: 'GET',
        xhrFields: { withCredentials: true },
        success: function(response) {
            console.log('Order Details API response:', response);
            if (response && response.code === 1000 && response.result) {
                const order = response.result;

                // Cập nhật header
                $('.bg-dark span').text(`Đơn hàng #${order.id}`);
                $('.bg-primary p strong').text(order.username);

                // Cập nhật thông tin mua hàng
                $('.card:contains("Thông tin mua hàng") .card-body')
                    .find('.fw-bold').eq(0).text(order.fullName || 'Không có thông tin');
                $('.card:contains("Thông tin mua hàng") .card-body')
                    .find('.fw-bold').eq(1).text(order.username || 'Không có thông tin');
                $('.card:contains("Thông tin mua hàng") .card-body')
                    .find('.fw-bold').eq(2).text(order.phone || 'Không có thông tin');

                // Cập nhật phương thức thanh toán
                $('.card:contains("Phương thức thanh toán") .card-body .fw-bold')
                    .text(order.paymentMethod || 'Không có thông tin');

                // Cập nhật địa chỉ nhận hàng
                $('.card:contains("Địa chỉ nhận hàng") .card-body')
                    .find('.fw-bold').eq(0).text(order.fullName || 'Không có thông tin');
                $('.card:contains("Địa chỉ nhận hàng") .card-body')
                    .find('.fw-bold').eq(1).text(order.address || 'Không có thông tin');
                $('.card:contains("Địa chỉ nhận hàng") .card-body')
                    .find('.fw-bold').eq(2).text(order.phone || 'Không có thông tin');

                // Cập nhật tóm tắt đơn hàng
                const $productContainer = $('.card:contains("Tóm tắt đơn hàng") .card-body');
                const $productList = $productContainer.find('.product-list table tbody');
                const $templateRow = $productList.find('tr').first();
                const $totalRow = $productContainer.find('.row').last();
                $productList.find('tr').remove(); // Xóa sản phẩm mẫu

                let totalPrice = order.totalPrice || 0;
                order.details.forEach((item, index) => {
                    const $newRow = $templateRow.clone();
                    $newRow.find('td').eq(0).text(item.productName);
                    $newRow.find('td').eq(1).text(item.quantity);
                    $newRow.find('td').eq(2).text(`${(item.priceAtPurchase).toLocaleString()}đ`);
                    $productList.append($newRow);
                });

                // Cập nhật tổng tiền
                $totalRow.find('.text-danger').text(`${totalPrice.toLocaleString()}đ`);

                // Xóa orderId khỏi localStorage sau khi hiển thị
                localStorage.removeItem("orderId");
            } else {
                alert('Không thể tải thông tin đơn hàng. Vui lòng thử lại.');
                localStorage.removeItem("orderId");
                window.location.href = 'index.html';
            }
        },
        error: function(xhr) {
            console.error('Error loading order details:', xhr.responseText);
            let message = xhr.responseJSON?.message || 'Không thể tải thông tin đơn hàng.';
            if (xhr.status === 401) {
                localStorage.removeItem("id");
                localStorage.removeItem("orderId");
                if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                    window.location.href = 'login.html';
                    return;
                }
            }
            alert(message);
            window.location.href = 'index.html';
        }
    });

    // Gán sự kiện cho nút "Tiếp tục mua hàng"
    $('.btn.bg-primary').on('click', function() {
        window.location.href = 'index.html';
    });
});

// Hàm load giỏ hàng
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
		error: function() {
			alert("Không thể tải giỏ hàng.");
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
	localStorage.removeItem("id");
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