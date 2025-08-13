/**
 *
 */
function getQueryParam(name) {
	const urlParams = new URLSearchParams(window.location.search);
	return urlParams.get(name);
}

$(document).ready(function() {

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
								<img src="/doan/uploads/${imageUrl}" alt="${item.productName}" style="width: 40px; height: 40px; object-fit: cover;">
							</div>
							<div class="mt-1">
								<span class="fw-bold small">${item.productName}</span> <br>
								<span class="small">${item.productCode || ''}</span>
							</div>
						</div>
					</td>
					<td class="align-middle text-end fw-bold">${(price / 1000).toFixed(2)}K</td>
					<td class="align-middle text-center">
						<input type="number" min="1" value="${item.quantity}" class="quantity text-center"
							   data-original-value="${item.quantity}" data-product-id="${item.productId}" style="width: 60px;">
					</td>
					<td class="align-middle text-end fw-bold text-danger">${(itemTotal / 1000).toFixed(2)}K</td>
					<td class="align-middle text-center">
						<button class="btn btn-outline-danger rounded-circle btn-sm btn-delete-cart-item" data-product-id="${item.productId}">
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

			// Gọi hàm để gắn sự kiện cập nhật số lượng
			bindCartUpdateEvents(userId);
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

// Hàm cập nhật số lượng sản phẩm trong database
function updateCartQuantity(userId, productId, newQuantity, originalQuantity) {
	console.log('Updating cart quantity:', { userId, productId, newQuantity, originalQuantity });

	// Kiểm tra productId có hợp lệ không
	if (!productId || productId === 'undefined' || productId === 'null') {
		console.error('ProductId không hợp lệ:', productId);
		alert('Lỗi: Không tìm thấy thông tin sản phẩm');
		renderCartTable(userId);
		return;
	}

	const difference = newQuantity - originalQuantity;

	if (difference === 0) return; // Không có thay đổi

	const requestData = {
		userId: userId,
		productId: productId.toString(),
		quantity: Math.abs(difference)
	};

	if (difference > 0) {
		// Tăng số lượng
		requestData.updatedQuantity = Math.abs(difference);
	} else {
		// Giảm số lượng
		requestData.deletedQuantity = Math.abs(difference);
	}

	console.log('Request data:', requestData);

	// Hiển thị loading state
	const $quantityInput = $(`.quantity[data-product-id="${productId}"]`);
	const originalValue = $quantityInput.val();
	$quantityInput.prop('disabled', true);

	$.ajax({
		url: 'http://localhost:8080/doan/cart/items',
		method: 'POST',
		contentType: 'application/json',
		xhrFields: {
			withCredentials: true
		},
		data: JSON.stringify(requestData),
		success: function(response) {
			console.log('Update cart success:', response);
			renderCartTable(userId);
		},
		error: function(xhr, status, error) {
			console.error('Error updating cart quantity:', xhr);
			console.error('Response text:', xhr.responseText);

			// Khôi phục giá trị cũ
			$quantityInput.val(originalValue).prop('disabled', false);

			let errorMessage = 'Không thể cập nhật số lượng';
			if (xhr.responseJSON && xhr.responseJSON.message) {
				errorMessage += ': ' + xhr.responseJSON.message;
			} else if (xhr.status === 400) {
				errorMessage += ': Dữ liệu không hợp lệ';
			} else if (xhr.status === 401) {
				errorMessage = 'Phiên đăng nhập đã hết hạn';
				setTimeout(() => {
					window.location.href = "login.html";
				}, 1500);
			} else if (xhr.status === 404) {
				errorMessage += ': Không tìm thấy sản phẩm';
			}

			alert(errorMessage);
		}
	});
}

// Hàm gắn sự kiện cập nhật số lượng cho bảng giỏ hàng
function bindCartUpdateEvents(userId) {
	// Sự kiện cho input khi nhập từ bàn phím hoặc sử dụng nút lên/xuống
	$(document).off('input change blur keypress', '.quantity').on('input change blur keypress', '.quantity', function(e) {
		const $input = $(this);
		const productId = $input.data('product-id');
		const inputValue = $input.val().trim();

		console.log('Input event:', e.type, 'productId:', productId, 'inputValue:', inputValue);

		// Kiểm tra productId
		if (!productId) {
			console.error('Không tìm thấy productId cho input');
			return;
		}

		const newQuantity = parseInt(inputValue) || 1;
		const originalQuantity = parseInt($input.data('original-value')) || 1;

		// Đảm bảo số lượng tối thiểu là 1
		if (newQuantity < 1) {
			$input.val(1);
			if (originalQuantity !== 1) {
				updateCartQuantity(userId, productId, 1, originalQuantity);
			}
			return;
		}

		// Xử lý khi nhấn Enter
		if (e.type === 'keypress' && e.which === 13) {
			$input.blur(); // Kích hoạt sự kiện blur
			return;
		}

		// Xử lý khi mất focus hoặc thay đổi giá trị
		if (e.type === 'blur' || e.type === 'change') {
			const finalQuantity = parseInt($input.val()) || 1;
			if (finalQuantity !== originalQuantity) {
				updateCartQuantity(userId, productId, finalQuantity, originalQuantity);
			}
		}
	});

	// Gán sự kiện focus để lưu giá trị ban đầu
	$(document).off('focus', '.quantity').on('focus', '.quantity', function() {
		const $input = $(this);
		$input.data('original-value', $input.val());
		console.log('Input focused, original value set to:', $input.val());
	});

	// Gán sự kiện focus để lưu giá trị ban đầu
	$(document).off('focus', '.quantity').on('focus', '.quantity', function() {
		const $input = $(this);
		$input.data('original-value', $input.val());
		console.log('Input focused, original value set to:', $input.val());
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