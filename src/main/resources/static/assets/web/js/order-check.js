function getQueryParam(name) {
	const urlParams = new URLSearchParams(window.location.search);
	return urlParams.get(name);
}

$(document).ready(function() {
	const code = getQueryParam("code");
	const userId = localStorage.getItem("id");

	// Mảng để lưu trữ dữ liệu đơn hàng theo trạng thái
	let orderData = {
		PENDING: { count: 0, data: [] },
		CANCELLED: { count: 0, data: [] },
		CONFIRMED: { count: 0, data: [] },
		SHIPPING: { count: 0, data: [] },
		COMPLETED: { count: 0, data: [] },
		FAILED: { count: 0, data: [] }
	};

	// Hàm gọi API và cập nhật dữ liệu
	function fetchOrders(status, page = 1) {
		$.ajax({
			url: `http://localhost:8080/doan/orders/user/${userId}/status/${status}`,
			method: 'GET',
			xhrFields: { withCredentials: true },
			data: { page: page, size: 5 },
			success: function(response) {
				console.log(`API response for ${status}:`, response);
				if (response && response.code === 1000 && response.result) {
					const { data, totalElements, totalPage, pageSize, currentPage } = response.result;
					orderData[status].count = totalElements;
					orderData[status].data = data;

					// Render danh sách đơn hàng
					renderOrderList(status, data);

					// Cập nhật phân trang
					setupPagination(status, totalPage, currentPage, pageSize);
				} else {
					alert(`Không thể tải danh sách đơn hàng trạng thái ${status}.`);
				}
			},
			error: function(xhr) {
				if (xhr.status === 401) {
					if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
						localStorage.removeItem("id");
						window.location.href = 'login.html';
					}
				} else {
					console.error(`Error loading ${status} orders:`, xhr.responseText);
					let message = xhr.responseJSON?.message || 'Lỗi khi tải dữ liệu.';
					alert(message);
				}
			}
		});
	}

	// Hàm render danh sách đơn hàng
	function renderOrderList(status, orders) {
		const $tabPane = $(`#${status.toLowerCase()}`);
		const $container = $tabPane.find('.bg-white.rounded-3.shadow-sm.p-4');
		$container.find('.border.rounded-3.p-3.mb-3:not(.template)').remove();

		if (orders.length === 0) {
			$container.html(`
                <div class="text-center text-muted py-5">
                    <i class="fas fa-inbox fa-3x mb-3"></i>
                    <p>Không có đơn hàng ${status.toLowerCase().replace(/^\w/, c => c.toUpperCase())}</p>
                </div>
            `);
		} else {
			orders.forEach(order => {
				const $template = $container.find('.template').clone().removeClass('template d-none').addClass('border.rounded-3.p-3.mb-3');
				$template.find('.status').text(order.status);
				$template.find('.order-id').text(`#${order.id}`);
				$template.find('.customer-name').text(order.fullName);
				$template.find('.customer-phone').text(order.phone);
				$template.find('.item-count').text(`x${order.details.length}`);

				// Render tất cả sản phẩm với thanh cuộn
				const $productContainer = $template.find('.product-container');
				$productContainer.empty();
				order.details.forEach((item, index) => {
					const $productItem = $(`
                        <div class="d-flex align-items-center cursor-pointer mb-2 ${index > 0 ? 'mt-2' : ''}">
                            <img src="/doan/uploads/${item.images[0] || 'https://via.placeholder.com/60x60'}" alt="${item.productName}" class="rounded me-3" style="width: 40px; height: 40px;">
                            <div>
                                <h6 class="mb-1">${item.productName}</h6>
                                <p class="mb-0 text-muted small">Mã: ${item.productCode || 'N/A'}</p>
                                <p class="mb-0 text-start fw-bold text-danger">${item.priceAtPurchase.toLocaleString()}đ</p>
                            </div>
                        </div>
                    `);
					$productContainer.append($productItem);
				});

				$template.on('click', () => showOrderDetail(order));
				$container.append($template);
			});

			// Cập nhật tổng số
			$tabPane.find('.text-muted').first().text(`Tổng số: ${orders.length} đơn hàng`);
		}
	}

	// Hàm hiển thị chi tiết đơn hàng trong modal
	function showOrderDetail(order) {
		$('#orderDetailModalLabel').text(`Chi tiết đơn hàng #${order.id}`);
		const $badge = $('#orderDetailModal .badge');
		$badge.text(order.status);

		// Xóa các lớp màu cũ và thêm lớp màu mới dựa trên trạng thái
		$badge.removeClass('bg-primary bg-danger bg-success bg-warning bg-info bg-secondary')
			.addClass(getBadgeClass(order.status))
			.css('color', '#fff');

		$('#customerName').text(order.fullName || 'Không có thông tin');
		$('#customerEmail').text(order.username || 'Không có thông tin');
		$('#customerPhone').text(order.phone || 'Không có thông tin');
		$('#customerAddress').text(order.address || 'Không có thông tin');
		$('#paymentMethod').text(order.paymentMethod || 'Không có thông tin');
		$('#totalAmount').text(`${order.totalPrice.toLocaleString()}đ`);
		$('.totalAmount').text(`${order.totalPrice.toLocaleString()}đ`);
		$('#orderNote').text(order.note || 'Không có');
		$('#orderDate').text(order.createdDate || 'Chưa có thông tin');

		const $productList = $('#productList');
		$productList.empty();
		order.details.forEach(item => {
			$productList.append(`
                <tr>
                    <td>
                        <div class="d-flex align-items-center">
                            <img src="/doan/uploads/${item.images[0] || 'https://via.placeholder.com/50x50'}" alt="${item.productName}" class="rounded me-3" style="width: 50px; height: 50px;">
                            <div>
                                <div class="fw-bold">${item.productName}</div>
                                <div class="small text-muted">Mã: ${item.productCode}</div>
                            </div>
                        </td>
                        <td class="text-center"><span class="badge bg-info">${item.quantity}</span></td>
                        <td class="text-end">${item.priceAtPurchase.toLocaleString()}đ</td>
                        <td class="text-end fw-bold text-danger">${(item.priceAtPurchase * item.quantity).toLocaleString()}đ</td>
                        <td class="text-end">
                            ${order.status === 'COMPLETED' ?
								(item.isReviewed ?
									'Đã đánh giá' :
									`<button type="button" class="btn btn-primary btn-rate-product"
	                                    data-bs-toggle="modal"
	                                    data-bs-target="#ratingModal"
	                                    data-product-id="${item.productId}"
	                                    data-order-id="${order.id}"
	                                    data-product-name="${item.productName}"
	                                    data-product-code="${item.productCode}"
	                                    data-product-price="${item.priceAtPurchase}"
	                                    data-product-image="${item.images[0] || 'https://via.placeholder.com/50x50'}">
	                                    Đánh giá
	                                </button>`
								) : ''
							}
                        </td>
                </tr>
            `);
		});

		// Hiển thị nút "Hủy đơn hàng" chỉ khi trạng thái là PENDING
		const $modalFooter = $('#orderDetailModal .modal-footer');
		$modalFooter.empty();
		if (order.status === 'PENDING') {
			$modalFooter.append(`
                <button class="btn btn-outline-danger cancelOrder" data-order-id="${order.id}">Hủy đơn hàng</button>
                <button type="button" class="btn btn-dark" data-bs-dismiss="modal">Đóng</button>
            `);
			$('.cancelOrder').on('click', function() {
				const orderId = $(this).data('order-id');
				cancelOrder(orderId);
			});
		} else {
			$modalFooter.append(`
                <button type="button" class="btn btn-dark" data-bs-dismiss="modal">Đóng</button>
            `);
		}

		// Xử lý sự kiện khi mở modal đánh giá
		$('.btn-rate-product').off('click').on('click', function() {
			const productId = $(this).data('product-id');
			const orderId = $(this).data('order-id');
			const productName = $(this).data('product-name');
			const productCode = $(this).data('product-code');
			const productPrice = $(this).data('product-price');
			const productImage = $(this).data('product-image');

			// Cập nhật thông tin sản phẩm trong modal đánh giá
			$('#ratingModal .modal-body .d-flex').html(`
                <div class="me-3">
                    <img src="/doan/uploads/${productImage}" alt="${productName}" style="width: 60px; height: 60px; border-radius: 6px;">
                </div>
                <div>
                    <div class="fw-semibold">${productName}</div>
                    <div class="text-muted small">Mã: ${productCode}</div>
                    <div class="text-danger fw-bold">Giá: ${productPrice.toLocaleString()}₫</div>
                </div>
            `);

			// Reset trạng thái modal
			$('#stars i').removeClass('bi-star-fill').addClass('bi-star');
			$('#stars').data('rating', 0);
			$('#ratingModal .text-center .mb-1').text('Hãy đánh giá sản phẩm');
			$('#comment').val('');
			$('#charCount').text('0');

			// Lưu productId và orderId vào modal để sử dụng khi gửi đánh giá
			$('#ratingModal').data('product-id', productId);
			$('#ratingModal').data('order-id', orderId);
		});

		// Cập nhật tiến trình dựa trên trạng thái
		const $progressSteps = $('#progressSteps');
		$progressSteps.find('.step-number').removeClass('bg-primary bg-danger').addClass('bg-light').css('color', '#6c757d').css('border', '1px solid #dee2e6');

		switch (order.status) {
			case 'FAILED':
				$progressSteps.find('[data-step="1"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none').html('✓');
				$progressSteps.find('[data-step="2"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none').html('✓');
				$progressSteps.find('[data-step="3"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none').html('✓');
				$progressSteps.find('[data-step="4"]').removeClass('bg-light').addClass('bg-danger').css('color', '#fff').css('border', 'none').html('✕');
				$progressSteps.find('[data-step="4"] ~ .small .step-name').text('Giao hàng thất bại');
				$progressSteps.find('[data-line-step="1"]').css('backgroundColor', '#3CB815');
				$progressSteps.find('[data-line-step="2"]').css('backgroundColor', '#3CB815');
				$progressSteps.find('[data-line-step="3"]').css('backgroundColor', '#3CB815');
				
				break;
			case 'PENDING':
				$progressSteps.find('[data-step="1"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none').html('✓');
				$progressSteps.find('[data-step="1"] ~ .small .step-name').text('Đã đặt hàng');
				$progressSteps.find('[data-step="2"] ~ .small .step-name').text('Chưa xác nhận');
				$progressSteps.find('[data-step="3"] ~ .small .step-name').text('Chưa giao hàng');
				$progressSteps.find('[data-step="4"] ~ .small .step-name').text('Chưa hoàn thành');
				break;
			case 'CONFIRMED':
				$progressSteps.find('[data-step="1"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none').html('✓');
				$progressSteps.find('[data-step="2"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none').html('✓');
				$progressSteps.find('[data-step="1"] ~ .small .step-name').text('Đã đặt hàng');
				$progressSteps.find('[data-step="2"] ~ .small .step-name').text('Đã xác nhận');
				$progressSteps.find('[data-step="3"] ~ .small .step-name').text('Chưa giao hàng');
				$progressSteps.find('[data-step="4"] ~ .small .step-name').text('Chưa hoàn thành');
				$progressSteps.find('[data-line-step="1"]').css('backgroundColor', '#3CB815');
				break;
			case 'SHIPPING':
				$progressSteps.find('[data-step="1"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none').html('✓');
				$progressSteps.find('[data-step="2"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none').html('✓');
				$progressSteps.find('[data-step="3"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none');
				$progressSteps.find('[data-step="1"] ~ .small .step-name').text('Đã đặt hàng');
				$progressSteps.find('[data-step="2"] ~ .small .step-name').text('Đẫ xác nhận');
				$progressSteps.find('[data-step="3"] ~ .small .step-name').text('Đang giao hàng');
				$progressSteps.find('[data-step="4"] ~ .small .step-name').text('Chưa hoàn thành');
				$progressSteps.find('[data-line-step="1"]').css('backgroundColor', '#3CB815');
				$progressSteps.find('[data-line-step="2"]').css('backgroundColor', '#3CB815');
				break;
			case 'COMPLETED':
				$progressSteps.find('[data-step="1"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none').html('✓');
				$progressSteps.find('[data-step="2"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none').html('✓');
				$progressSteps.find('[data-step="3"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none').html('✓');
				$progressSteps.find('[data-step="4"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none').html('✓');
				$progressSteps.find('[data-step="1"] ~ .small .step-name').text('Đã đặt hàng');
				$progressSteps.find('[data-step="2"] ~ .small .step-name').text('Đẫ xác nhận');
				$progressSteps.find('[data-step="3"] ~ .small .step-name').text('Đã giao hàng');
				$progressSteps.find('[data-step="4"] ~ .small .step-name').text('Đã hoàn thành');
				$progressSteps.find('[data-line-step="1"]').css('backgroundColor', '#3CB815');
				$progressSteps.find('[data-line-step="2"]').css('backgroundColor', '#3CB815');
				$progressSteps.find('[data-line-step="3"]').css('backgroundColor', '#3CB815');
				break;
			case 'CANCELLED':
				$progressSteps.find('[data-step="1"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none').html('✓');
				$progressSteps.find('[data-step="2"]').removeClass('bg-light').addClass('bg-danger').css('color', '#fff').css('border', 'none').html('✕');
				$progressSteps.find('[data-step="1"] ~ .small .step-name').text('Đã đặt hàng');
				$progressSteps.find('[data-step="2"] ~ .small .step-name').text('Đã hủy');
				$progressSteps.find('[data-step="3"] ~ .small .step-name').text('Đã hủy');
				$progressSteps.find('[data-step="4"] ~ .small .step-name').text('Đã hủy');
				$progressSteps.find('[data-line-step="1"]').css('backgroundColor', '#3CB815');
				break;
		}

		$('#orderDetailModal').modal('show');
	}

	// Hàm xử lý gửi đánh giá
	function submitReview() {
		const productId = $('#ratingModal').data('product-id');
		const orderId = $('#ratingModal').data('order-id');
		const rating = $('#stars').data('rating') || 0;
		const comment = $('#comment').val();
		const userId = localStorage.getItem("id");

		if (rating === 0) {
			alert('Vui lòng chọn số sao để đánh giá!');
			return;
		}

		$.ajax({
			url: 'http://localhost:8080/doan/reviews',
			method: 'POST',
			contentType: 'application/json',
			xhrFields: { withCredentials: true },
			data: JSON.stringify({
				userId: userId,
				orderId: orderId,
				productId: productId,
				rating: rating,
				comment: comment
			}),
			success: function(response) {
				console.log('Review response:', response);
				if (response && response.code === 1000) {
					alert('Gửi đánh giá thành công!');
					fetchOrders('COMPLETED', 1);
					$('#ratingModal').modal('hide');
					// Lấy lại chi tiết đơn hàng để reload modal
					$.ajax({
						url: `http://localhost:8080/doan/orders/${orderId}`,
						method: 'GET',
						xhrFields: { withCredentials: true },
						success: function(orderResponse) {
							if (orderResponse && orderResponse.code === 1000 && orderResponse.result) {
								// Gọi lại showOrderDetail để reload modal với dữ liệu mới
								showOrderDetail(orderResponse.result);
							} else {
								alert('Không thể tải lại chi tiết đơn hàng.');
							}
						},
						error: function(xhr) {
							console.error('Error fetching order details:', xhr.responseText);
							alert('Lỗi khi tải lại chi tiết đơn hàng.');
						}
					});
				} else {
					alert('Gửi đánh giá thất bại: ' + (response.message || 'Lỗi không xác định'));
				}
			},
			error: function(xhr) {
				console.error('Error submitting review:', xhr.responseText);
				let message = xhr.responseJSON?.message || 'Lỗi khi gửi đánh giá.';
				alert(message);
			}
		});
	}

	// Gắn sự kiện click cho nút gửi đánh giá chỉ một lần
	$('#ratingModal .btn-primary').on('click', submitReview);

	// Xử lý chọn sao
	const ratingMessages = {
		1: 'Rất không hài lòng',
		2: 'Không hài lòng',
		3: 'Bình thường',
		4: 'Hài lòng',
		5: 'Rất hài lòng'
	};

	$('#stars i').on('click', function() {
		const rating = $(this).data('value');
		$('#stars').data('rating', rating);
		$('#stars i').each(function() {
			if ($(this).data('value') <= rating) {
				$(this).removeClass('bi-star').addClass('bi-star-fill');
			} else {
				$(this).removeClass('bi-star-fill').addClass('bi-star');
			}
		});
		$('#ratingModal .text-center .mb-1').text(`${ratingMessages[rating]}`);
	});

	// Đếm ký tự trong textarea
	$('#comment').on('input', function() {
		const charCount = $(this).val().length;
		$('#charCount').text(charCount);
	});

	// Hàm hủy đơn hàng
	function cancelOrder(orderId) {
		if (confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')) {
			$.ajax({
				url: `http://localhost:8080/doan/orders/${orderId}/cancel`,
				method: 'PATCH',
				xhrFields: { withCredentials: true },
				success: function(response) {
					console.log(`Cancel response for order ${orderId}:`, response);
					if (response && response.code === 1000) {
						alert('Đơn hàng đã được hủy thành công!');
						// Làm mới danh sách đơn hàng cho PENDING và CANCELLED
						fetchOrders('PENDING', 1);
						fetchOrders('CANCELLED', 1);
						// Đóng modal
						$('#orderDetailModal').modal('hide');
					} else {
						alert('Hủy đơn hàng thất bại: ' + (response.message || 'Lỗi không xác định'));
					}
				},
				error: function(xhr) {
					console.error(`Error canceling order ${orderId}:`, xhr.responseText);
					let message = xhr.responseJSON?.message || 'Lỗi khi hủy đơn hàng.';
					alert(message);
				}
			});
		}
	}

	// Hàm xác định lớp badge dựa trên trạng thái
	function getBadgeClass(status) {
		switch (status) {
			case 'PENDING':
				return 'bg-info';
			case 'CONFIRMED':
				return 'bg-success';
			case 'SHIPPING':
				return 'bg-secondary';
			case 'COMPLETED':
				return 'bg-primary';
			case 'FAILED':
				return 'bg-danger';
			case 'CANCELLED':
				return 'bg-danger';
			default:
				return 'bg-secondary';
		}
	}

	// Hàm xử lý phân trang
	function setupPagination(status, totalPage, currentPage, pageSize) {
		const $tabPane = $(`#${status.toLowerCase()}`);
		const $pagination = $tabPane.find('.pagination');
		$pagination.empty();

		if (totalPage > 0) {
			$pagination.append('<li class="page-item ' + (currentPage === 1 ? 'disabled' : '') + '"><span class="page-link">«</span></li>');
			for (let i = 1; i <= totalPage; i++) {
				$pagination.append('<li class="page-item ' + (i === currentPage ? 'active' : '') + '"><span class="page-link">' + i + '</span></li>');
			}
			$pagination.append('<li class="page-item ' + (currentPage === totalPage ? 'disabled' : '') + '"><span class="page-link">»</span></li>');

			$pagination.find('.page-link').on('click', function() {
				const page = $(this).text() === '«' ? currentPage - 1 : $(this).text() === '»' ? currentPage + 1 : parseInt($(this).text());
				if (!$(this).parent().hasClass('disabled') && page >= 1 && page <= totalPage) {
					fetchOrders(status, page);
				}
			});
		}
	}

	// Gọi API cho tất cả các trạng thái khi trang tải
	const statuses = ['PENDING', 'CANCELLED', 'CONFIRMED', 'SHIPPING', 'COMPLETED', 'FAILED'];
	statuses.forEach(status => {
		fetchOrders(status, 1);
	});
});