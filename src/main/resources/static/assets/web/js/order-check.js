$(document).ready(function() {
    const userId = localStorage.getItem("id");
    if (!userId) {
        alert('Vui lòng đăng nhập để quản lý đơn hàng.');
        window.location.href = 'login.html';
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
            data: { page: page, size: 5 }, // Thay đổi size thành 5
            success: function(response) {
                console.log(`API response for ${status}:`, response); // Debug
                if (response && response.code === 1000 && response.result) {
                    const { data, totalElements, totalPage, pageSize, currentPage } = response.result;
                    orderData[status].count = totalElements;
                    orderData[status].data = data;

                    // Cập nhật badge
                    $(`#${status.toLowerCase()}-tab .badge`).text(totalElements);

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
                    localStorage.removeItem("id");
                    if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
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
        $container.find('.border.rounded-3.p-3.mb-3:not(.template)').remove(); // Giữ template

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
                            <img src="${item.images[0] || 'https://via.placeholder.com/60x60'}" alt="${item.productName}" class="rounded me-3" style="width: 40px; height: 40px;">
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
	          .css('color', '#fff'); // Đảm bảo chữ trắng để tương phản

	    $('#customerName').text(order.fullName || 'Không có thông tin');
	    $('#customerEmail').text(order.username || 'Không có thông tin');
	    $('#customerPhone').text(order.phone || 'Không có thông tin');
	    $('#customerAddress').text(order.address || 'Không có thông tin');
	    $('#paymentMethod').text(order.paymentMethod || 'Không có thông tin');
	    $('#totalAmount').text(`${order.totalPrice.toLocaleString()}đ`);
	    $('#orderNote').text(order.note || 'Không có');
	    $('#orderDate').text(order.createdDate || 'Chưa có thông tin');

	    const $productList = $('#productList');
	    $productList.empty();
	    order.details.forEach(item => {
	        $productList.append(`
	            <tr>
	                <td>
	                    <div class="d-flex align-items-center">
	                        <img src="${item.images[0] || 'https://via.placeholder.com/50x50'}" alt="${item.productName}" class="rounded me-3" style="width: 50px; height: 50px;">
	                        <div>
	                            <div class="fw-bold">${item.productName}</div>
	                            <div class="small text-muted">Mã SP: ${item.productCode}</div>
	                        </div>
	                    </td>
	                    <td class="text-center"><span class="badge bg-info">${item.quantity}</span></td>
	                    <td class="text-end">${item.priceAtPurchase.toLocaleString()}đ</td>
	                    <td class="text-end fw-bold text-danger">${(item.priceAtPurchase * item.quantity).toLocaleString()}đ</td>
	                    <td class="text-end">${item.isReviewed ? 'Đã đánh giá' : ''}</td>
	            </tr>
	        `);
	    });

	    // Cập nhật tiến trình dựa trên trạng thái
	    const $progressSteps = $('#progressSteps');
	    $progressSteps.find('.step-number').removeClass('bg-primary bg-danger').addClass('bg-light').css('color', '#6c757d').css('border', '1px solid #dee2e6');

	    switch (order.status) {
	        case 'FAILED':
	            $progressSteps.find('[data-step="1"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none');
	            $progressSteps.find('[data-step="2"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none');
	            $progressSteps.find('[data-step="3"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none');
	            $progressSteps.find('[data-step="4"]').removeClass('bg-light').addClass('bg-danger').css('color', '#fff').css('border', 'none');
	            $progressSteps.find('[data-step="4"] ~ .small .step-name').text('Giao hàng thất bại');
	            break;
	        case 'PENDING':
	            $progressSteps.find('[data-step="1"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none');
				$progressSteps.find('[data-step="2"] ~ .small .step-name').text('Chưa xác nhận');
				$progressSteps.find('[data-step="4"] ~ .small .step-name').text('Chưa giao hàng');
				$progressSteps.find('[data-step="4"] ~ .small .step-name').text('Chưa hoàn thành');
	            break;
	        case 'CONFIRMED':
	            $progressSteps.find('[data-step="1"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none');
	            $progressSteps.find('[data-step="2"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none');
				$progressSteps.find('[data-step="4"] ~ .small .step-name').text('Chưa giao hàng');
				$progressSteps.find('[data-step="4"] ~ .small .step-name').text('Chưa hoàn thành');
	            break;
	        case 'SHIPPING':
	            $progressSteps.find('[data-step="1"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none');
	            $progressSteps.find('[data-step="2"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none');
	            $progressSteps.find('[data-step="3"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none');
				$progressSteps.find('[data-step="4"] ~ .small .step-name').text('Chưa hoàn thành');
	            break;
	        case 'COMPLETED':
	            $progressSteps.find('[data-step="1"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none');
	            $progressSteps.find('[data-step="2"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none');
	            $progressSteps.find('[data-step="3"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none');
	            $progressSteps.find('[data-step="4"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none');
	            break;
	        case 'CANCELLED':
	            $progressSteps.find('[data-step="1"]').removeClass('bg-light').addClass('bg-primary').css('color', '#fff').css('border', 'none');
	            $progressSteps.find('[data-step="2"]').removeClass('bg-light').addClass('bg-danger').css('color', '#fff').css('border', 'none');
	            $progressSteps.find('[data-step="2"] ~ .small .step-name').text('Đã hủy');
				$progressSteps.find('[data-step="3"] ~ .small .step-name').text('Đã hủy');
				$progressSteps.find('[data-step="4"] ~ .small .step-name').text('Đã hủy');
	            break;
	    }

	    $('#orderDetailModal').modal('show');
	}

	// Hàm xác định lớp badge dựa trên trạng thái
	function getBadgeClass(status) {
	    switch (status) {
	        case 'PENDING':
	            return 'bg-warning';
	        case 'CONFIRMED':
	            return 'bg-info';
	        case 'SHIPPING':
	            return 'bg-primary';
	        case 'COMPLETED':
	            return 'bg-success';
	        case 'FAILED':
	            return 'bg-danger';
	        case 'CANCELLED':
	            return 'bg-secondary';
	        default:
	            return 'bg-secondary';
	    }
	}

    // Hàm xử lý phân trang
    function setupPagination(status, totalPage, currentPage, pageSize) {
        const $tabPane = $(`#${status.toLowerCase()}`);
        const $pagination = $tabPane.find('.pagination');
        $pagination.empty();

        // Luôn hiển thị phân trang, ngay cả khi totalPage = 1
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