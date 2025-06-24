$(document).ready(function () {
    // Kiểm tra trạng thái đăng nhập
    checkLoginStatus();

    // Xử lý sự kiện đăng xuất
    $('#logout').on('click', function (e) {
        e.preventDefault();
        logout();
    });

    // Lấy orderId từ URL
    const urlParams = new URLSearchParams(window.location.search);
    const orderId = urlParams.get('id');

    if (orderId) {
        fetchOrderDetails(orderId);
    } else {
        alert('Không tìm thấy ID đơn hàng.');
    }

    // Hàm lấy chi tiết đơn hàng
    function fetchOrderDetails(orderId) {
        $.ajax({
            url: `http://localhost:8080/doan/orders/${orderId}`,
            method: 'GET',
            xhrFields: { withCredentials: true },
            success: function (response) {
                console.log('Order details response:', response);
                if (response && response.code === 1000 && response.result) {
                    const order = response.result;
                    renderOrderDetails(order);
                } else {
                    alert('Không tải được chi tiết đơn hàng: ' + (response.message || 'Lỗi không xác định'));
                }
            },
            error: function (xhr) {
                console.error('Error fetching order details:', xhr.responseText);
                let message = xhr.responseJSON?.message || 'Lỗi khi tải chi tiết đơn hàng.';
                alert(message);
            }
        });
    }

    // Hàm render chi tiết đơn hàng
    function renderOrderDetails(order) {
        // Cập nhật tiêu đề và trạng thái
        $('.card-body h5 .text-muted').text(`#${order.id}`);
        $('.card-body h5 .badge').removeClass('bg-primary bg-success bg-danger bg-info').addClass(getBadgeClass(order.status)).text(order.status);

        // Cập nhật tiến trình
        updateOrderSteps(order.status);

        // Cập nhật thông tin khách hàng
        $('.table-bordered tbody').eq(0).find('p').eq(0).html(`<strong>Họ và tên:</strong> ${order.fullName}`);
        $('.table-bordered tbody').eq(0).find('p').eq(1).html(`<strong>Email:</strong> ${order.username}`);
        $('.table-bordered tbody').eq(0).find('p').eq(2).html(`<strong>Số điện thoại:</strong> ${order.phone}`);
        $('.table-bordered tbody').eq(0).find('p').eq(3).html(`<strong>Địa chỉ:</strong> ${order.address}`);

        // Cập nhật thông tin đơn hàng
        $('.table-bordered tbody').eq(1).find('p').eq(0).html(`<strong>Phương thức thanh toán:</strong> ${order.paymentMethod}`);
        $('.table-bordered tbody').eq(1).find('p').eq(1).html(`<strong>Tổng tiền:</strong> <span class="text-danger fw-bold">${order.totalPrice.toLocaleString()}₫</span>`);
        $('.table-bordered tbody').eq(1).find('p').eq(2).html(`<strong>Ghi chú:</strong> ${order.note || 'Không có'}`);
        $('.table-bordered tbody').eq(1).find('p').eq(3).html(`<strong>Ngày tạo:</strong> ${new Date(order.createdDate).toLocaleString('vi-VN', { timeZone: 'Asia/Ho_Chi_Minh' })}`);

        // Cập nhật danh sách sản phẩm
        const $productTableBody = $('.table-bordered tbody').eq(2);
        $productTableBody.empty();
        order.details.forEach(item => {
            const $row = $(`
                <tr>
                    <td>
                        <div class="d-flex align-items-center">
                            <img src="/doan/uploads/${item.images && item.images[0] ? item.images[0] : 'https://via.placeholder.com/50'}" class="me-2 rounded" alt="${item.productName}" width="50" height="50">
                            <div>
                                <strong>${item.productName}</strong><br>
                                <small class="text-muted">Mã SP: ${item.productCode}</small>
                            </div>
                        </div>
                    </td>
                    <td class="text-center"><span class="px-3">${item.quantity}</span></td>
                    <td class="text-end">${item.priceAtPurchase.toLocaleString()}₫</td>
                    <td class="text-end text-danger">${(item.quantity * item.priceAtPurchase).toLocaleString()}₫</td>
                </tr>
            `);
            $productTableBody.append($row);
        });

        // Cập nhật tổng cộng
        $('.table-bordered tfoot td:last-child').text(`${order.totalPrice.toLocaleString()}₫`);

        // Cập nhật trạng thái hiện tại
        const $statusBadge = $('.border p .badge');
        $statusBadge.removeClass('bg-primary bg-success bg-danger bg-info').addClass(getBadgeClass(order.status)).text(order.status);
        $('.border .form-label').html(`Trạng thái hiện tại: <span class="badge ${getBadgeClass(order.status)}">${order.status}</span>`);

        // Cập nhật select trạng thái tiếp theo
        const $select = $('.form-select');
        const $updateButton = $('.btn-order-status');
        $select.empty().prop('disabled', false); // Reset select
        $select.append('<option value="" selected disabled>Chọn trạng thái tiếp theo</option>'); // Placeholder
        const nextStatuses = getNextStatuses(order.status);
        if (nextStatuses.length > 0) {
            nextStatuses.forEach(status => {
                $select.append(`<option value="${status}">${status === 'CANCELLED' ? 'CANCELLED' : status === 'CONFIRMED' ? 'CONFIRMED' : status}</option>`);
            });
        } else {
            $select.append('<option value="" disabled>Không có trạng thái tiếp theo</option>').prop('disabled', true);
        }

        // Khởi tạo trạng thái ban đầu cho button
        updateButtonState($select, $updateButton);

        // Gắn sự kiện thay đổi select
        $select.on('change', function () {
            updateButtonState($select, $updateButton);
        });

        // Gắn sự kiện cập nhật trạng thái
        $updateButton.off('click').on('click', function () {
            const newStatus = $select.val();
            if (newStatus && newStatus !== '') {
                updateOrderStatus(orderId, newStatus);
            } else {
                alert('Vui lòng chọn trạng thái tiếp theo.');
            }
        });
    }

    // Hàm cập nhật trạng thái button
    function updateButtonState($select, $button) {
        const selectedValue = $select.val();
        if (selectedValue && selectedValue !== '') { // Kiểm tra nếu có giá trị hợp lệ
            $button.removeClass('btn-order-status').addClass('btn-order-update-status').prop('disabled', false);
        } else {
            $button.removeClass('btn-order-update-status').addClass('btn-order-status').prop('disabled', true);
        }
    }

    // Hàm lấy class badge dựa trên trạng thái
    function getBadgeClass(status) {
        switch (status) {
            case 'PENDING': return 'bg-primary';
            case 'CONFIRMED': return 'bg-success';
            case 'SHIPPING': return 'bg-info';
            case 'COMPLETED': return 'bg-success';
            case 'CANCELLED': return 'bg-danger';
            case 'FAILED': return 'bg-danger';
            default: return 'bg-secondary';
        }
    }

    // Hàm xác định trạng thái tiếp theo dựa trên trạng thái hiện tại
    function getNextStatuses(currentStatus) {
        switch (currentStatus) {
            case 'PENDING': return ['CONFIRMED', 'CANCELLED'];
            case 'CONFIRMED': return ['SHIPPING'];
            case 'SHIPPING': return ['COMPLETED', 'FAILED'];
            case 'COMPLETED':
            case 'CANCELLED':
            case 'FAILED':
                return [];
            default: return [];
        }
    }

    // Hàm cập nhật trạng thái đơn hàng
    function updateOrderStatus(orderId, newStatus) {
        if (confirm(`Bạn có chắc chắn muốn cập nhật trạng thái thành ${newStatus}?`)) {
            $.ajax({
                url: `http://localhost:8080/doan/orders/${orderId}/status`,
                method: 'PATCH',
                contentType: 'application/json',
                data: JSON.stringify({ status: newStatus }),
                xhrFields: { withCredentials: true },
                success: function (response) {
                    console.log(`Update status response for order ${orderId}:`, response);
                    if (response && response.code === 1000) {
                        alert('Cập nhật trạng thái thành công.');
                        fetchOrderDetails(orderId); // Làm mới chi tiết đơn hàng
                    } else {
                        alert('Cập nhật trạng thái thất bại: ' + (response.message || 'Lỗi không xác định'));
                    }
                },
                error: function (xhr) {
                    console.error(`Error updating order status ${orderId}:`, xhr.responseText);
                    let message = xhr.responseJSON?.message || 'Lỗi khi cập nhật trạng thái.';
                    alert(message);
                }
            });
        }
    }

    // Hàm kiểm tra đăng nhập
    function checkLoginStatus() {
        $.ajax({
            url: 'http://localhost:8080/doan/users/myInfo',
            type: 'GET',
            xhrFields: { withCredentials: true },
            success: function (response) {
                console.log('myInfo API response:', response);
                const user = response.result;
                localStorage.setItem("id", user.id);
                $('#user-name').text(user.fullName || 'Unknown User');
                $("#full-name").text(user.fullName || 'Unknown User');
                $('#user-role').text(user.roles && user.roles.length > 0 ? user.roles.join(', ') : 'User');
            },
            error: function (xhr, status, error) {
                if (xhr.status === 401) {
                    if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                        localStorage.removeItem("id");
                        window.location.href = 'login.html';
                        return;
                    }
                } else {
                    console.error('Error checking login status:', status, error, xhr.responseText);
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
            success: function (response) {
                localStorage.removeItem("id");
                console.log('Logout successful:', response);
                document.cookie = 'token=; Max-Age=0; path=/;';
                window.location.href = 'login.html';
            },
            error: function (xhr, status, error) {
                console.error('Logout error:', status, error, xhr.responseText);
                localStorage.removeItem("id");
                document.cookie = 'token=; Max-Age=0; path=/;';
                window.location.href = 'login.html';
            }
        });
    }

    // Hàm cập nhật tiến trình dựa trên trạng thái
    function updateOrderSteps(status) {
        const steps = $('.step');
        const labels = $('.order-step-label');
        steps.removeClass('inactive bg-success bg-danger').addClass('inactive'); // Reset tất cả về inactive

        switch (status) {
            case 'PENDING':
                steps.eq(0).removeClass('inactive');
                labels.eq(0).html('Đặt hàng <br><small>Chờ xác nhận</small>');
                labels.eq(1).html('Xác nhận <br><small>Đã xác nhận</small>');
                labels.eq(2).html('Vận chuyển <br><small>Đang giao hàng</small>');
                labels.eq(3).html('Hoàn thành <br><small>Đã giao hàng</small>');
                break;
            case 'CONFIRMED':
                steps.eq(0).removeClass('inactive');
                steps.eq(1).removeClass('inactive').addClass('bg-primary');
                labels.eq(0).html('Đặt hàng <br><small>Chờ xác nhận</small>');
                labels.eq(1).html('Xác nhận <br><small>Đã xác nhận</small>');
                labels.eq(2).html('Vận chuyển <br><small>Đang giao hàng</small>');
                labels.eq(3).html('Hoàn thành <br><small>Đã giao hàng</small>');
                break;
            case 'SHIPPING':
                steps.eq(0).removeClass('inactive').addClass('bg-primary');
                steps.eq(1).removeClass('inactive').addClass('bg-primary');
                steps.eq(2).removeClass('inactive').addClass('bg-primary');
                labels.eq(0).html('Đặt hàng <br><small>Chờ xác nhận</small>');
                labels.eq(1).html('Xác nhận <br><small>Đã xác nhận</small>');
                labels.eq(2).html('Vận chuyển <br><small>Đang giao hàng</small>');
                labels.eq(3).html('Hoàn thành <br><small>Đã giao hàng</small>');
                break;
            case 'COMPLETED':
                steps.eq(0).removeClass('inactive').addClass('bg-primary');
                steps.eq(1).removeClass('inactive').addClass('bg-primary');
                steps.eq(2).removeClass('inactive').addClass('bg-primary');
                steps.eq(3).removeClass('inactive').addClass('bg-primary');
                labels.eq(0).html('Đặt hàng <br><small>Chờ xác nhận</small>');
                labels.eq(1).html('Xác nhận <br><small>Đã xác nhận</small>');
                labels.eq(2).html('Vận chuyển <br><small>Đang giao hàng</small>');
                labels.eq(3).html('Hoàn thành <br><small>Đã giao hàng</small>');
                break;
            case 'CANCELLED':
                steps.eq(0).removeClass('inactive').addClass('bg-primary'); // Bước 1 hoàn thành
                steps.eq(1).removeClass('inactive').addClass('bg-danger'); // Bước 2 lỗi
                labels.eq(0).html('Đặt hàng <br><small>Chờ xác nhận</small>');
                labels.eq(1).html('Xác nhận <br><small>Đã hủy</small>');
                labels.eq(2).html('Vận chuyển <br><small>Đang giao hàng</small>');
                labels.eq(3).html('Hoàn thành <br><small>Đã giao hàng</small>');
                break;
            case 'FAILED':
                steps.eq(0).removeClass('inactive').addClass('bg-primary'); // Bước 1 hoàn thành
                steps.eq(1).removeClass('inactive').addClass('bg-primary'); // Bước 2 hoàn thành
                steps.eq(2).removeClass('inactive').addClass('bg-primary'); // Bước 3 hoàn thành
                steps.eq(3).removeClass('inactive').addClass('bg-danger'); // Bước 4 lỗi
                labels.eq(0).html('Đặt hàng <br><small>Chờ xác nhận</small>');
                labels.eq(1).html('Xác nhận <br><small>Đã xác nhận</small>');
                labels.eq(2).html('Vận chuyển <br><small>Đang giao hàng</small>');
                labels.eq(3).html('Hoàn thành <br><small>Giao hàng thất bại</small>');
                break;
        }
    }
});