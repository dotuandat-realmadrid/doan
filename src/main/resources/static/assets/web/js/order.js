/**
 * 
 */
$(document).ready(function() {
	const userId = localStorage.getItem("id");

	if (userId) {
		renderOrderTable(userId);
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
				// console.log('Cart API response:', response); // Debug dữ liệu giỏ hàng
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

					// Thêm vào phần VNPay payment call
					if (paymentMethod === 'ATM' || paymentMethod === 'E_WALLET') {
					    const requestData = {
					        amount: totalPrice,
					        bankCode: '',
					        language: 'vn',
					        orderData: JSON.stringify(orderData)
					    };
					    
					    console.log('VNPay Request Data:', requestData); // Debug request data
					    console.log('OrderData Object:', orderData); // Debug order data
					    console.log('OrderData JSON:', JSON.stringify(orderData)); // Debug JSON string
					    
					    $.ajax({
					        url: 'http://localhost:8080/doan/payment/vnpay/pay',
					        method: 'POST',
					        data: requestData,
					        xhrFields: { withCredentials: true },
					        success: function(response) {
					            console.log('VNPay API response:', JSON.stringify(response, null, 2));
					            if (response.code === 1000 && response.result) {
					                window.location.href = response.result;
					            } else {
					                console.error('VNPay payment initiation failed:', response.message);
					                alert('Không thể khởi tạo thanh toán VNPay: ' + (response.message || 'Lỗi không xác định'));
					            }
					        },
					        error: function(xhr) {
					            console.error('Error initiating VNPay:');
					            console.error('Status:', xhr.status);
					            console.error('Response Text:', xhr.responseText);
					            console.error('Ready State:', xhr.readyState);
					            alert('Lỗi khi khởi tạo thanh toán VNPay. Vui lòng thử lại.');
					        }
					    });
					} else {
						saveOrder(userId, orderData);
					}
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
			// console.log('Addresses API response:', response); // Debug phản hồi API addresses
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

function saveOrder(userId, orderData) {
	$.ajax({
		url: 'http://localhost:8080/doan/orders',
		method: 'POST',
		contentType: 'application/json',
		xhrFields: { withCredentials: true },
		data: JSON.stringify(orderData),
		success: function(response) {
			if (response.code === 1000 && response.result && response.result.id) {
				alert('Đặt hàng thành công!');
				const orderId = response.result.id; // Lấy ID trả về

				// Xóa giỏ hàng
				$.ajax({
					url: `http://localhost:8080/doan/cart/${userId}`,
					method: 'DELETE',
					xhrFields: { withCredentials: true },
					success: function() {
						window.location.href = `order-confirmation.html?orderId=${orderId}`;
					},
					error: function(xhr) {
						console.error('Error clearing cart:', xhr.responseText);
						// Vẫn chuyển hướng ngay cả khi xóa giỏ hàng thất bại
						window.location.href = `order-confirmation.html?orderId=${orderId}`;
					}
				});
			} else {
				alert('Đặt hàng thất bại. Vui lòng thử lại.');
			}
		},
		error: function(xhr) {
			let message = xhr.responseJSON?.message || 'Không thể đặt hàng. Vui lòng thử lại.';
			if (xhr.status === 401) {
				if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
					window.location.href = 'login.html';
				}
			}
			alert(message);
			console.error('Error placing order:', xhr.responseText);
		}
	});
}
