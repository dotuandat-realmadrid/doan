/**
 * 
 */
function getQueryParam(name) {
	const urlParams = new URLSearchParams(window.location.search);
	return urlParams.get(name);
}

$(document).ready(function() {
	const code = getQueryParam("code");
	const userId = localStorage.getItem("id");

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

	if (userId) {
		checkLoginStatus(); // Kiểm tra đăng nhập và điền email
		renderOrderTable(userId);
		loadCart(userId);
		loadAddresses(userId); // Tải danh sách địa chỉ
	} else {
		$('table.table-view-order tbody').html('<tr><td colspan="4" class="text-center text-muted">Vui lòng đăng nhập để xem đơn hàng.</td></tr>');
		$('.total-items').text('0');
		$('.total-quantities').text('0');
		$('.total-price').text('0đ');
		$('.address-selector').hide();
		$('#email').val('');
	}

	// Gắn sự kiện cho nút "Quay lại giỏ hàng"
	$('.btn-back-to-cart').on('click', function() {
		window.location.href = 'cart.html';
	});

	// Gắn sự kiện cho dropdown địa chỉ
	$('#addressList').on('click', '.dropdown-item', function() {
		const addressId = $(this).data('address-id');
		if (addressId === 'new') {
			// Chọn "Thêm địa chỉ mới" -> Xóa các trường input (trừ email)
			$('#fullName, #phone, #province, #district, #ward, #detail').val('');
			$('.selected-address-text').text('Thêm địa chỉ mới');
		} else {
			// Chọn địa chỉ có sẵn -> Điền thông tin vào input
			const address = $(this).data('address');
			$('#fullName').val(address.fullName);
			$('#phone').val(address.phone);
			$('#province').val(address.province);
			$('#district').val(address.district);
			$('#ward').val(address.ward);
			$('#detail').val(address.detail);
			$('.selected-address-text').text(`${address.fullName} | ${address.phone} | ${address.detail}, ${address.ward}, ${address.district}, ${address.province}`);
		}
		$('#addressDropdown').data('selected-address-id', addressId);
	});

	// Gắn sự kiện cho nút "Đặt hàng"
	$('.btn-place-order').on('click', function() {
		const userId = localStorage.getItem("id");
		if (!userId) {
			alert('Vui lòng đăng nhập để đặt hàng.');
			window.location.href = 'login.html';
			return;
		}

		const selectedAddressId = $('#addressDropdown').data('selected-address-id');
		const paymentMethod = $('input[name="paymentMethod"]:checked').val();
		const note = $('#note').val() || null;

		// Lấy thông tin địa chỉ từ form (không bao gồm email)
		const addressData = {
			userId: userId,
			fullName: $('#fullName').val(),
			phone: $('#phone').val(),
			province: $('#province').val(),
			district: $('#district').val(),
			ward: $('#ward').val(),
			detail: $('#detail').val(),
			createdBy: 'anonymousUser',
			modifiedBy: 'anonymousUser'
		};

		// Kiểm tra thông tin địa chỉ
		if (!addressData.fullName || !addressData.phone || !addressData.province || !addressData.district || !addressData.ward || !addressData.detail) {
			alert('Vui lòng điền đầy đủ thông tin địa chỉ giao hàng.');
			return;
		}

		// Lấy dữ liệu giỏ hàng để tạo đơn hàng
		$.ajax({
			url: `http://localhost:8080/doan/cart/${userId}`,
			method: 'GET',
			xhrFields: { withCredentials: true },
			success: function(response) {
				console.log('Cart API response:', response); // Debug dữ liệu giỏ hàng
				if (!response || !response.result || !Array.isArray(response.result.items) || response.result.items.length === 0) {
					alert('Giỏ hàng trống. Vui lòng thêm sản phẩm trước khi đặt hàng.');
					return;
				}

				const items = response.result.items;
				let totalPrice = 0;
				const details = items.map(item => {
					const price = item.discountPrice !== null ? item.discountPrice : item.price;
					const itemTotal = price * item.quantity;
					totalPrice += itemTotal;
					return {
						productId: item.productId,
						quantity: item.quantity,
						priceAtPurchase: price
					};
				});

				// Hàm đặt hàng
				const placeOrder = (addressId) => {
					const orderData = {
						userId: userId,
						orderType: 'ONLINE',
						totalPrice: totalPrice,
						paymentMethod: paymentMethod,
						note: note,
						addressId: addressId,
						details: details
					};

					$.ajax({
						url: 'http://localhost:8080/doan/orders',
						method: 'POST',
						contentType: 'application/json',
						xhrFields: { withCredentials: true },
						data: JSON.stringify(orderData),
						success: function(response) {
							console.log('Order API response:', response);
							if (response.code === 1000 && response.result && response.result.id) {
								alert('Đặt hàng thành công!');
								// Lưu orderId vào localStorage
								localStorage.setItem("orderId", response.result.id);
								// Xóa giỏ hàng
								$.ajax({
									url: `http://localhost:8080/doan/cart/${userId}`,
									method: 'DELETE',
									xhrFields: { withCredentials: true },
									success: function() {
										window.location.href = 'order-confirmation.html';
									},
									error: function(xhr) {
										console.error('Error clearing cart:', xhr.responseText);
										// Vẫn chuyển hướng ngay cả khi xóa giỏ hàng thất bại
										window.location.href = 'order-confirmation.html';
									}
								});
							} else {
								alert('Đặt hàng thất bại. Vui lòng thử lại.');
							}
						},
						error: function(xhr) {
							let message = xhr.responseJSON?.message || 'Không thể đặt hàng. Vui lòng thử lại.';
							if (xhr.status === 401) {
								localStorage.removeItem("id");
								localStorage.removeItem("orderId"); // Xóa orderId nếu có
								if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
									window.location.href = 'login.html';
								}
							}
							alert(message);
							console.error('Error placing order:', xhr.responseText);
						}
					});
				};

				// Nếu chọn địa chỉ mới
				if (selectedAddressId === 'new') {
					$.ajax({
						url: 'http://localhost:8080/doan/addresses',
						method: 'POST',
						contentType: 'application/json',
						xhrFields: { withCredentials: true },
						data: JSON.stringify(addressData),
						success: function(response) {
							console.log('Address API response:', response); // Debug phản hồi thêm địa chỉ
							if (response.code === 1000 && response.result && response.result.id) {
								const newAddressId = response.result.id;
								placeOrder(newAddressId);
							} else {
								alert('Không thể thêm địa chỉ mới. Vui lòng thử lại.');
							}
						},
						error: function(xhr) {
							alert('Không thể thêm địa chỉ mới. Vui lòng thử lại.');
							console.error('Error adding address:', xhr.responseText);
						}
					});
				} else {
					// Sử dụng địa chỉ có sẵn
					placeOrder(selectedAddressId);
				}
			},
			error: function(xhr) {
				alert('Không thể lấy thông tin giỏ hàng. Vui lòng thử lại.');
				console.error('Error loading cart:', xhr.responseText);
			}
		});
	});
});

function renderOrderTable(userId) {
	$.ajax({
		url: `http://localhost:8080/doan/cart/${userId}`,
		method: 'GET',
		xhrFields: { withCredentials: true },
		success: function(response) {
			console.log('Cart API response:', response); // Debug dữ liệu giỏ hàng
			const $tbody = $('table.table-view-order tbody');
			const $totalItems = $('.total-items');
			const $totalQuantities = $('.total-quantities');
			const $totalPrice = $('.total-price');

			if (!response || !response.result || !Array.isArray(response.result.items)) {
				console.error('Invalid order response:', response);
				$tbody.html('<tr><td colspan="4" class="text-center text-muted">Không có sản phẩm nào trong đơn hàng.</td></tr>');
				$totalItems.text('0');
				$totalQuantities.text('0');
				$totalPrice.text('0đ');
				return;
			}

			const items = response.result.items;
			$tbody.empty();

			let totalPrice = 0;
			let totalQuantities = 0;
			let totalItems = items.length;

			items.forEach(item => {
				const imageUrl = item.images && item.images.length > 0 ? item.images[0] : 'assets/web/img/product-thumb-7.png';
				const price = item.discountPrice !== null ? item.discountPrice : item.price;
				const itemTotal = price * item.quantity;
				totalPrice += itemTotal;
				totalQuantities += item.quantity;

				const html = `
	                        <tr data-product-id="${item.productId}">
	                            <td>
	                                <div class="d-flex align-middle">
	                                    <div class="rounded-circle my-2 mx-2">
	                                        <img src="/doan/uploads/${imageUrl}" alt="${item.productName}" style="width: 40px; height: 40px; object-fit: cover;">
	                                    </div>
	                                    <div class="mt-1">
	                                        <span class="fw-bold small">${item.productName}</span> <br>
	                                        <span class="small">${item.productCode}</span>
	                                    </div>
	                                </div>
	                            </td>
	                            <td class="align-middle text-end fw-bold">${(price / 1000).toFixed(2)}K</td>
	                            <td class="align-middle text-center">${item.quantity}</td>
	                            <td class="align-middle text-end fw-bold text-danger">${(itemTotal / 1000).toFixed(2)}K</td>
	                        </tr>
	                    `;
				$tbody.append(html);
			});

			$totalItems.text(totalItems);
			$totalQuantities.text(totalQuantities);
			$totalPrice.text(`${totalPrice.toLocaleString()}đ`);
		},
		error: function(xhr) {
			if (xhr.status === 401) {
				if (confirm("Bạn cần đăng nhập để có thể xem đơn hàng. Bạn có muốn đăng nhập ngay không?")) {
					window.location.href = "login.html";
				}
			} else {
				console.error('Error loading order:', xhr.responseText);
				$('table.table-view-order tbody').html('<tr><td colspan="4" class="text-center text-muted">Không có sản phẩm nào trong đơn hàng.</td></tr>');
				$('.total-items').text('0');
				$('.total-quantities').text('0');
				$('.total-price').text('0đ');
			}
		}
	});
}

function loadAddresses(userId) {
	$.ajax({
		url: `http://localhost:8080/doan/addresses?userId=${userId}`,
		method: 'GET',
		xhrFields: { withCredentials: true },
		success: function(response) {
			console.log('Addresses API response:', response); // Debug phản hồi API addresses
			const $addressList = $('#addressList');
			const $addressSelector = $('.address-selector');
			$addressList.empty();

			if (response && response.code === 1000 && Array.isArray(response.result) && response.result.length > 0) {
				$addressSelector.show(); // Hiển thị dropdown
				response.result.forEach(address => {
					const addressText = `${address.fullName} | ${address.phone} | ${address.detail}, ${address.ward}, ${address.district}, ${address.province}`;
					const html = `
	                            <li class="dropdown-item" data-address-id="${address.id}" data-address='${JSON.stringify(address)}'>
	                                <i class="bi bi-geo-alt me-2"></i>${addressText}
	                            </li>
	                        `;
					$addressList.append(html);
				});
				$addressList.append('<li><hr class="dropdown-divider"></li>');
				$addressList.append('<li class="dropdown-item" data-address-id="new"><i class="bi bi-plus me-2"></i>Thêm địa chỉ mới</li>');

				// Chọn địa chỉ đầu tiên mặc định
				const firstAddress = response.result[0];
				$('#fullName').val(firstAddress.fullName);
				$('#phone').val(firstAddress.phone);
				$('#province').val(firstAddress.province);
				$('#district').val(firstAddress.district);
				$('#ward').val(firstAddress.ward);
				$('#detail').val(firstAddress.detail);
				$('.selected-address-text').text(`${firstAddress.fullName} | ${firstAddress.phone} | ${firstAddress.detail}, ${firstAddress.ward}, ${firstAddress.district}, ${firstAddress.province}`);
				$('#addressDropdown').data('selected-address-id', firstAddress.id);
			} else {
				$addressSelector.hide(); // Ẩn dropdown nếu không có địa chỉ
				$('#addressDropdown').data('selected-address-id', 'new');
				$('.selected-address-text').text('Thêm địa chỉ mới');
			}
		},
		error: function(xhr) {
			console.error('Error loading addresses:', xhr.responseText);
			$('.address-selector').hide();
			$('#addressDropdown').data('selected-address-id', 'new');
			$('.selected-address-text').text('Thêm địa chỉ mới');
		}
	});
}

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