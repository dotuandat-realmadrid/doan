/**
 * 
 */
function getQueryParam(name) {
	const urlParams = new URLSearchParams(window.location.search);
	return urlParams.get(name);
}

$(document).ready(function() {
    const orderId = getQueryParam("orderId");
    if (!orderId) {
        alert('Không tìm thấy thông tin đơn hàng. Vui lòng thử lại.');
        window.location.href = 'index.html';
        return;
    }

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
                $('.bg-dark .id').text(`Đơn hàng #${order.id}`);
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
            if (xhr.status === 401) {
                if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                    localStorage.removeItem("id");
                    localStorage.removeItem("orderId");
                    window.location.href = 'login.html';
                    return;
                }
            } else {
                console.error('Error loading order details:', xhr.responseText);
                let message = xhr.responseJSON?.message || 'Không thể tải thông tin đơn hàng.';
                alert(message);
                window.location.href = 'index.html';
            }
        }
    });

    // Gán sự kiện cho nút "Tiếp tục mua hàng"
    $('.btn.bg-primary').on('click', function() {
        window.location.href = 'index.html';
    });
});