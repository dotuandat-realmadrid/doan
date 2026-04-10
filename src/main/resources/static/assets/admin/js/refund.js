$(document).ready(function () {
    /****************************************************Giao diện danh sách đơn hoàn tiền************************************************************/
    // Mảng lưu trữ dữ liệu đơn hoàn tiền theo trạng thái
    let refundData = {
        PENDING: { count: 0, data: [], currentPage: 1, totalPages: 1, pageSize: 5 },
        COMPLETED: { count: 0, data: [], currentPage: 1, totalPages: 1, pageSize: 5 },
        REJECTED: { count: 0, data: [], currentPage: 1, totalPages: 1, pageSize: 5 }
    };

    // Hàm gọi API để lấy danh sách đơn hoàn tiền
    function fetchRefunds(status, page = 1) {
        $.ajax({
            url: `http://localhost:8080/doan/refunds/status/${status}`,
            method: 'GET',
            xhrFields: { withCredentials: true },
            data: { page: page, size: refundData[status].pageSize },
            success: function (response) {
                console.log(`API response for ${status}:`, response);
                if (response && response.code === 1000 && response.result) {
                    const { data, totalElements, totalPage, currentPage } = response.result;
                    refundData[status].count = totalElements || 0;
                    refundData[status].data = data || [];
                    refundData[status].currentPage = currentPage || 1;
                    refundData[status].totalPages = totalPage || 1;

                    // Render danh sách đơn hoàn tiền
                    renderRefundList(status, data || []);

                    // Cập nhật phân trang
                    renderPagination(status, currentPage || 1, totalPage || 1);
                } else {
                    console.warn(`No valid data for ${status}. Displaying empty state.`);
                    renderRefundList(status, []);
                    renderPagination(status, 1, 1);
                }
            },
            error: function (xhr) {
                if (xhr.status === 401) {
                    if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                        localStorage.removeItem("id");
                        window.location.href = 'login.html';
                    }
                } else {
                    console.error(`Error loading ${status} refunds:`, xhr.responseText);
                    let message = xhr.responseJSON?.message || 'Lỗi khi tải dữ liệu.';
                    alert(message);
                    renderRefundList(status, []);
                    renderPagination(status, 1, 1);
                }
            }
        });
    }

    // Hàm render danh sách đơn hoàn tiền
    function renderRefundList(status, refunds) {
        const $tabPane = $(`#${status.toLowerCase()}`);
        const $container = $tabPane.find('.bg-white.rounded-3.shadow-sm.p-4');
        $container.find('.border.rounded-3.p-3.mb-3:not(.template)').remove(); // Xóa các mục không phải template

        if (!refunds || refunds.length === 0) {
            $container.find('.fw-bold').text(`Tổng số: 0 đơn hàng`);
            // Xóa các thông báo "Không có đơn hoàn tiền" cũ
            $container.find('.text-center.text-muted.py-5').remove();
            // Thêm thông báo mới
            $container.find('.template').after(`
                <div class="text-center text-muted py-5">
                    <i class="bi bi-inbox fa-3x mb-3"></i>
                    <p>Không có đơn hoàn tiền ${status.toLowerCase().replace(/^\w/, c => c.toUpperCase())}</p>
                </div>
            `);
        } else {
            refunds.forEach(refund => {
                const $template = $container.find('.template').clone().removeClass('template d-none').addClass('border rounded-3 p-3 mb-3');
                $template.find('.status').text(refund.status || status);
                $template.find('.order-id').text(`#${refund.orderId || 'N/A'}`);
                $template.find('.customer-name').text(refund.fullName || 'N/A');
                $template.find('.customer-phone').text(refund.phone || 'N/A');

                // Render danh sách sản phẩm
                const $productContainer = $template.find('.product-container');
                $productContainer.empty();
                (refund.details || []).forEach((item, index) => {
                    const $productItem = $(`
                        <div class="d-flex align-items-center mb-2 ${index > 0 ? 'mt-2' : ''}">
                            <img src="/doan/uploads/${item.images && item.images[0] ? item.images[0] : 'https://via.placeholder.com/60x60'}" alt="${item.productName || 'Product'}" class="rounded me-3" style="width: 60px; height: 60px;">
                            <div>
                                <h6 class="mb-1">${item.productName || 'N/A'}</h6>
                                <p class="mb-0 text-muted small">Mã: ${item.productCode || 'N/A'}</p>
                                <p class="mb-0 text-start fw-bold text-danger">${item.priceAtPurchase ? item.priceAtPurchase.toLocaleString() : '0'}đ</p>
                            </div>
                        </div>
                    `);
                    $productContainer.append($productItem);
                });

                // Hiển thị code và refundAmount trong cột .item-count
                const refundType = refund.code === '02' ? 'Hoàn tiền toàn phần' : refund.code === '03' ? 'Hoàn tiền một phần' : 'N/A';
                $template.find('.item-count').html(`
                    <div class="py-2">${refundType}</div>
                    <div><span class="text-danger">${refund.refundAmount ? refund.refundAmount.toLocaleString() : '0'}đ</span></div>
                `);

                // Gắn sự kiện click cho toàn bộ template
                $template.addClass('cursor-pointer').on('click', function () {
                    fetchRefundDetails(refund.id);
                });

                $container.append($template);
            });

            // Cập nhật tổng số đơn hoàn tiền
            $tabPane.find('.fw-bold').first().text(`Tổng số: ${refundData[status].count} đơn hàng`);
        }
    }

    // Hàm gọi API để lấy chi tiết đơn hoàn tiền
    function fetchRefundDetails(refundId) {
        $.ajax({
            url: `http://localhost:8080/doan/refunds/${refundId}`,
            method: 'GET',
            xhrFields: { withCredentials: true },
            success: function (response) {
                console.log('Refund details API response:', response);
                if (response && response.code === 1000 && response.result) {
                    const refund = response.result;
                    renderRefundDetails(refund);
                    $('#refundDetailModal').modal('show');
                } else {
                    alert('Không thể tải chi tiết đơn hoàn tiền.');
                }
            },
            error: function (xhr) {
                console.error('Error fetching refund details:', xhr.responseText);
                let message = xhr.responseJSON?.message || 'Lỗi khi tải chi tiết đơn hoàn tiền.';
                if (xhr.status === 401) {
                    if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                        localStorage.removeItem("id");
                        window.location.href = 'login.html';
                    }
                } else {
                    alert(message);
                }
            }
        });
    }

    // Hàm render chi tiết đơn hoàn tiền vào modal
    function renderRefundDetails(refund) {
        $('#refundDetailModal .refund-id').text(`#${refund.id || 'N/A'}`);
        $('#refundDetailModal .refund-status').text(refund.status || 'N/A');
        $('#refundDetailModal .customer-fullname').text(refund.fullName || 'N/A');
        $('#refundDetailModal .customer-email').text(refund.username || 'N/A');
        $('#refundDetailModal .customer-phone').text(refund.phone || 'N/A');
        $('#refundDetailModal .customer-address').text(refund.address || 'N/A');
        $('#refundDetailModal .refund-type').text(refund.code === '02' ? 'Hoàn tiền toàn phần' : refund.code === '03' ? 'Hoàn tiền một phần' : 'N/A');
        $('#refundDetailModal .refund-amount').text(refund.refundAmount ? `${refund.refundAmount.toLocaleString()}đ` : '0đ');
        $('#refundDetailModal .transaction-date').text(refund.transactionDate || 'N/A');
        $('#refundDetailModal .reason').text(refund.reason || 'N/A');

        // Lưu thông tin refund để sử dụng trong updateRefundStatus
        $('#refundDetailModal').data('refund', refund);

        // Hiển thị giá trị ghi chú (nếu có) trong trường #refundNote
        $('#refundNote').val(refund.note || '');

        // Render danh sách sản phẩm
        const $productList = $('#refundDetailModal .product-list');
        $productList.empty();
        (refund.details || []).forEach(item => {
            const totalItemPrice = item.quantity * item.priceAtPurchase;
            const $row = $(`
                <tr>
                    <td>
                        <div class="d-flex align-items-center">
                            <img src="/doan/uploads/${item.images && item.images[0] ? item.images[0] : 'https://via.placeholder.com/50'}" class="me-2 rounded" alt="${item.productName || 'Product'}" width="50" height="50">
                            <div>
                                <strong>${item.productName || 'N/A'}</strong><br>
                                <small class="text-muted">Mã SP: ${item.productCode || 'N/A'}</small>
                            </div>
                        </div>
                    </td>
                    <td class="text-center">${item.quantity || 0}</td>
                    <td class="text-end">${item.priceAtPurchase ? item.priceAtPurchase.toLocaleString() : '0'}đ</td>
                    <td class="text-end text-danger">${totalItemPrice ? totalItemPrice.toLocaleString() : '0'}đ</td>
                </tr>
            `);
            $productList.append($row);
        });

        // Cập nhật tổng cộng
        $('#refundDetailModal .total-price').last().text(refund.totalPrice ? `${refund.totalPrice.toLocaleString()}đ` : '0đ');

        // Xử lý hiển thị nút và trạng thái trường nhập liệu dựa trên status
        const $completedButton = $('#refundDetailModal .completed');
        const $rejectedButton = $('#refundDetailModal .rejected');
        const $refundNote = $('#refundNote');

        if (refund.status === 'PENDING') {
            // Hiển thị nút và kích hoạt trường ghi chú
            $completedButton.show();
            $rejectedButton.show();
            $refundNote.prop('disabled', false);

            // Gắn sự kiện cho nút "Đồng ý" và "Từ chối"
            $completedButton.off('click').on('click', function () {
                const note = $refundNote.val().trim();
                updateRefundStatus(refund.id, 'COMPLETED', note);
            });
            $rejectedButton.off('click').on('click', function () {
                const note = $refundNote.val().trim();
                updateRefundStatus(refund.id, 'REJECTED', note);
            });
        } else {
            // Ẩn nút và vô hiệu hóa trường ghi chú cho COMPLETED hoặc REJECTED
            $completedButton.hide();
            $rejectedButton.hide();
            $refundNote.prop('disabled', true);
        }
    }

    // Hàm định dạng ngày thành yyyyMMddHHmmss
    function formatDateToVNPay(dateStr) {
        if (!dateStr) return '';
        let date;
        // Kiểm tra nếu dateStr đã ở định dạng yyyyMMddHHmmss
        if (/^\d{14}$/.test(dateStr)) {
            return dateStr; // Giữ nguyên nếu đúng định dạng
        }
        // Chuyển đổi từ các định dạng khác (ISO, hoặc định dạng khác)
        try {
            date = new Date(dateStr);
            if (isNaN(date.getTime())) {
                console.error('Invalid date format:', dateStr);
                return '';
            }
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            const hours = String(date.getHours()).padStart(2, '0');
            const minutes = String(date.getMinutes()).padStart(2, '0');
            const seconds = String(date.getSeconds()).padStart(2, '0');
            return `${year}${month}${day}${hours}${minutes}${seconds}`;
        } catch (e) {
            console.error('Error parsing date:', dateStr, e);
            return '';
        }
    }

    // Hàm cập nhật trạng thái đơn hoàn tiền
    function updateRefundStatus(refundId, status, note) {
        if (!confirm(`Bạn có chắc chắn muốn ${status === 'COMPLETED' ? 'đồng ý' : 'từ chối'} đơn hoàn tiền này?`)) {
            return;
        }

        const refund = $('#refundDetailModal').data('refund');

        if (status === 'COMPLETED') {
            // Định dạng trans_date thành yyyyMMddHHmmss
            const formattedTransDate = formatDateToVNPay(refund.transactionDate);

            if (!formattedTransDate) {
                alert('Lỗi: Ngày giao dịch không hợp lệ.');
                return;
            }

            // Gọi API VNPay refund trước
            $.ajax({
                url: 'http://localhost:8080/doan/payment/vnpay/refund',
                method: 'POST',
                xhrFields: { withCredentials: true },
                data: {
                    trantype: refund.code === '02' ? '02' : '03', // 02: Hoàn toàn phần, 03: Hoàn một phần
                    order_id: refund.orderId || '',
                    amount: refund.refundAmount || 0,
                    trans_date: formattedTransDate,
                    user: 'testuser'
                },
                success: function (response) {
                    console.log('VNPay refund response:', response);
                    if (response && response.code === 1000 && response.result) {
                        // Parse JSON từ result
                        const result = JSON.parse(response.result);
                        if (result.vnp_ResponseCode === '00') {
                            $.ajax({
                                url: `http://localhost:8080/doan/refunds/${refundId}/status`,
                                method: 'PATCH',
                                contentType: 'application/json',
                                xhrFields: { withCredentials: true },
                                data: JSON.stringify({ status: 'COMPLETED', note: note }),
                                success: function (patchResponse) {
                                    console.log('Update status response:', patchResponse);
                                    if (patchResponse && patchResponse.code === 1000) {
                                        alert('Đã đồng ý đơn hoàn tiền thành công.');
                                        $('#refundDetailModal').modal('hide');
                                        // Làm mới danh sách đơn hoàn tiền
                                        const statuses = ['PENDING', 'COMPLETED', 'REJECTED'];
                                        statuses.forEach(status => fetchRefunds(status, 1));
                                    } else {
                                        alert('Cập nhật trạng thái thất bại: ' + (patchResponse.message || 'Lỗi không xác định'));
                                    }
                                },
                                error: function (xhr) {
                                    console.error('Error updating refund status:', xhr.responseText);
                                    let message = xhr.responseJSON?.message || 'Lỗi khi cập nhật trạng thái.';
                                    if (xhr.status === 401) {
                                        if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                                            localStorage.removeItem("id");
                                            window.location.href = 'login.html';
                                        }
                                    } else {
                                        alert(message);
                                    }
                                }
                            });
                        } else {
                            alert('Hoàn tiền VNPay thất bại: ' + (result.vnp_Message || 'Lỗi không xác định'));
                        }
                    } else {
                        alert('Hoàn tiền VNPay thất bại: ' + (response.message || 'Lỗi không xác định'));
                    }
                },
                error: function (xhr) {
                    console.error('Error processing VNPay refund:', xhr.responseText);
                    let message = xhr.responseJSON?.message || 'Lỗi khi thực hiện hoàn tiền VNPay.';
                    if (xhr.status === 401) {
                        if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                            localStorage.removeItem("id");
                            window.location.href = 'login.html';
                        }
                    } else {
                        alert(message);
                    }
                }
            });
        } else {
            // Xử lý trạng thái REJECTED (không gọi VNPay)
            $.ajax({
                url: `http://localhost:8080/doan/refunds/${refundId}/status`,
                method: 'PATCH',
                contentType: 'application/json',
                xhrFields: { withCredentials: true },
                data: JSON.stringify({ status: 'REJECTED', note: note }),
                success: function (response) {
                    console.log('Update status response:', response);
                    if (response && response.code === 1000) {
                        alert('Đã từ chối đơn hoàn tiền thành công.');
                        $('#refundDetailModal').modal('hide');
                        // Làm mới danh sách đơn hoàn tiền
                        const statuses = ['PENDING', 'COMPLETED', 'REJECTED'];
                        statuses.forEach(status => fetchRefunds(status, 1));
                    } else {
                        alert('Cập nhật trạng thái thất bại: ' + (response.message || 'Lỗi không xác định'));
                    }
                },
                error: function (xhr) {
                    console.error('Error updating refund status:', xhr.responseText);
                    let message = xhr.responseJSON?.message || 'Lỗi khi cập nhật trạng thái.';
                    if (xhr.status === 401) {
                        if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                            localStorage.removeItem("id");
                            window.location.href = 'login.html';
                        }
                    } else {
                        alert(message);
                    }
                }
            });
        }
    }

    // Hàm render phân trang
    function renderPagination(status, current, totalPages) {
        const $pagination = $(`#${status.toLowerCase()} .pagination`);
        $pagination.empty();

        const prevClass = current === 1 ? "disabled" : "";
        $pagination.append(`
            <li class="page-item ${prevClass}">
                <a class="page-link" href="#" data-page="${current - 1}">«</a>
            </li>
        `);

        const addPageItem = (i, isActive = false) => {
            const activeClass = isActive ? "active" : "";
            $pagination.append(`
                <li class="page-item ${activeClass}">
                    <a class="page-link" href="#" data-page="${i}">${i}</a>
                </li>
            `);
        };

        const addEllipsis = () => {
            $pagination.append(`
                <li class="page-item disabled">
                    <a class="page-link" href="#">...</a>
                </li>
            `);
        };

        if (totalPages <= 6) {
            for (let i = 1; i <= totalPages; i++) {
                addPageItem(i, i === current);
            }
        } else {
            if (current <= 3) {
                for (let i = 1; i <= 3; i++) addPageItem(i, i === current);
                addEllipsis();
                for (let i = totalPages - 2; i <= totalPages; i++) addPageItem(i);
            } else if (current >= totalPages - 3) {
                if (current >= totalPages - 2) {
                    for (let i = 1; i <= 3; i++) addPageItem(i);
                    addEllipsis();
                    for (let i = totalPages - 2; i <= totalPages; i++) addPageItem(i, i === current);
                } else {
                    addPageItem(1);
                    addEllipsis();
                    for (let i = current - 1; i <= current + 1; i++) addPageItem(i, i === current);
                    addEllipsis();
                    addPageItem(totalPages);
                }
            } else {
                addPageItem(1);
                addEllipsis();
                for (let i = current - 1; i <= current + 1; i++) addPageItem(i, i === current);
                addEllipsis();
                addPageItem(totalPages);
            }
        }

        const nextClass = current === totalPages ? "disabled" : "";
        $pagination.append(`
            <li class="page-item ${nextClass}">
                <a class="page-link" href="#" data-page="${current + 1}">»</a>
            </li>
        `);

        // Gắn sự kiện click cho các nút phân trang
        $pagination.find('.page-link').on('click', function (e) {
            e.preventDefault();
            const page = $(this).data('page');
            if (page && page >= 1 && page <= totalPages) {
                fetchRefunds(status, page);
            }
        });
    }

    // Gọi API cho tất cả các trạng thái khi trang tải
    const statuses = ['PENDING', 'COMPLETED', 'REJECTED'];
    statuses.forEach(status => {
        fetchRefunds(status, 1);
    });

    // Gọi API khi tab được kích hoạt
    $('#refundTabs a[data-bs-toggle="pill"]').on('shown.bs.tab', function (e) {
        const status = $(e.target).attr('id').split('-')[0].toUpperCase();
        fetchRefunds(status, refundData[status].currentPage);
    });

    /* ******************************************************* Giao diện tìm kiếm ********************************************************* */
    // Hàm định dạng ngày từ yyyyMMddHHmmss sang dd/MM/yyyy HH:mm:ss
    function formatPayDate(dateStr) {
        if (!dateStr || !/^\d{14}$/.test(dateStr)) {
            console.warn('Invalid date format:', dateStr);
            return 'N/A';
        }
        try {
            const year = dateStr.substring(0, 4);
            const month = dateStr.substring(4, 6);
            const day = dateStr.substring(6, 8);
            const hour = dateStr.substring(8, 10);
            const minute = dateStr.substring(10, 12);
            const second = dateStr.substring(12, 14);
            return `${day}/${month}/${year} ${hour}:${minute}:${second}`;
        } catch (e) {
            console.error('Error formatting pay date:', dateStr, e);
            return 'N/A';
        }
    }

    // Hàm định dạng ngày thành yyyyMMddHHmmss (tối ưu cho giờ VN)
    function formatDateToVNPAY(dateStr) {
        if (!dateStr) return '';

        // Kiểm tra nếu đã ở định dạng yyyyMMddHHmmss
        if (/^\d{14}$/.test(dateStr)) {
            return dateStr;
        }

        // Sửa nếu thiếu 'T' (VD: 2025-08-2012:17:17 -> 2025-08-20T12:17:17)
        dateStr = dateStr.replace(/(\d{4}-\d{2}-\d{2})(\d{2}:\d{2}:\d{2})/, '$1T$2');

        try {
            const date = new Date(dateStr);
            if (isNaN(date.getTime())) {
                throw new Error('Invalid date format');
            }
            // Không cần điều chỉnh múi giờ vì input đã là giờ VN (UTC+7)
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            const hours = String(date.getHours()).padStart(2, '0');
            const minutes = String(date.getMinutes()).padStart(2, '0');
            const seconds = String(date.getSeconds()).padStart(2, '0');
            return `${year}${month}${day}${hours}${minutes}${seconds}`;
        } catch (e) {
            console.error('Error parsing date:', dateStr, e.message);
            alert('Ngày giao dịch không hợp lệ. Hãy thử định dạng yyyy-MM-ddThh:mm:ss (VD: 2025-08-20T12:17:17).');
            return '';
        }
    }

    // Biến để tránh multiple submissions
    let isSearching = false;

    // Xử lý sự kiện submit form
    $('#searchTransactionForm').off('submit').on('submit', function(event) {
        event.preventDefault();

        if (isSearching) return;

        const $submitBtn = $(this).find('button[type="submit"]');
        const originalText = $submitBtn.html();

        const orderId = $('#orderId').val().trim();
        const transactionDate = $('#transactionDate').val().trim();
        const transDate = formatDateToVNPAY(transactionDate);

        if (!orderId) {
            alert('Vui lòng nhập mã đơn hàng.');
            return;
        }
        if (!transDate) {
            return;
        }

        isSearching = true;
        $submitBtn.prop('disabled', true).html('<i class="bi bi-hourglass-split"></i> Đang tìm kiếm...');

        console.log('Sending request with:', { orderId, transDate });

        $.ajax({
            url: `http://localhost:8080/doan/payment/vnpay/query?order_id=${encodeURIComponent(orderId)}&trans_date=${transDate}`,
            method: 'POST',
            dataType: 'json',
            timeout: 10000,
            success: function(data) {
                console.log('Raw API response:', data);
                
                if (data && data.code === 1000 && data.result) {
                    let result;
                    try {
                        let resultString = data.result;
                        if (typeof resultString === 'string' && resultString.includes('}{')) {
                            console.warn('Response duplicate detected. Fixing temporarily...');
                            resultString = resultString.split('}{')[0] + '}';
                        }
                        result = JSON.parse(resultString);
                        console.log('Parsed result:', result);
                        
                        if (result.vnp_ResponseCode === '00' || result.vnp_TransactionStatus === '00') {
                            displayTransaction(result);
                            $('#totalOrders').text('Thông tin giao dịch');
                        } else {
                            alert('Giao dịch không thành công hoặc không tồn tại: ' + (result.vnp_Message || 'Lỗi không xác định'));
                            $('#totalOrders').text('Thông tin giao dịch');
                            $('#transactionResults').empty();
                        }
                    } catch (parseError) {
                        console.error('Error parsing response:', parseError, 'Raw data:', data);
                        alert('Lỗi khi xử lý dữ liệu phản hồi từ server. Vui lòng kiểm tra backend.');
                        $('#totalOrders').text('Thông tin giao dịch');
                        $('#transactionResults').empty();
                    }
                } else {
                    alert('Phản hồi từ server không hợp lệ.');
                    $('#totalOrders').text('Thông tin giao dịch');
                    $('#transactionResults').empty();
                }
            },
            error: function(xhr, status, error) {
                console.error('Lỗi khi gọi API:', status, error, xhr.responseText);
                let message = xhr.responseJSON?.message || 'Đã xảy ra lỗi khi tìm kiếm giao dịch (có thể timeout hoặc server lỗi).';
                alert(message);
                $('#totalOrders').text('Thông tin giao dịch');
                $('#transactionResults').empty();
            },
            complete: function() {
                isSearching = false;
                $submitBtn.prop('disabled', false).html(originalText);
            }
        });
    });

    // Hàm hiển thị kết quả giao dịch
    function displayTransaction(result) {
        $('#transactionResults').empty();

        const template = $('.search-orders .template').first().clone()
            .removeClass('d-none template')
            .addClass('transaction-result-item');

        template.find('.status').text('Trạng thái giao dịch: ' + (result.vnp_TransactionStatus === '00' ? 'Thành công' : 'Thất bại'));
        template.find('.order-id').text('Mã đơn hàng: ' + (result.vnp_TxnRef || 'N/A'));
        template.find('.bank-code').text('Ngân hàng giao dịch: ' + (result.vnp_BankCode || 'N/A'));
        
        let amount = 'N/A';
        if (result.vnp_Amount != null) {
            const amountValue = parseFloat(result.vnp_Amount);
            if (!isNaN(amountValue)) {
                amount = (amountValue / 100).toLocaleString('vi-VN') + ' VNĐ';
            } else {
                amount = result.vnp_Amount + ' (dữ liệu không hợp lệ)';
            }
        }
        template.find('.amount').text('Số tiền hoàn: ' + amount);
        
        template.find('.transaction-no').text('Giao dịch: ' + (result.vnp_TransactionNo || 'N/A')); // SỬA: Thay 'esult' thành 'result'
        template.find('.pay-date').text('Ngày trả lương: ' + formatPayDate(result.vnp_PayDate || '')); // SỬA: Di chuyển tiền tố vào sau formatPayDate
        template.find('.transaction-type').text('Loại giao dịch: ' + (result.vnp_TransactionType || 'N/A'));
        template.find('.order-info').text(result.vnp_OrderInfo || 'N/A');
        
        if (result.vnp_Message) {
            template.find('.status').attr('title', result.vnp_Message);
        }

        $('#transactionResults').append(template);
        console.log('Transaction displayed successfully:', result);
    }

    // Hàm reset form
    $('#searchTransactionForm').off('reset').on('reset', function() {
        $('#transactionResults').empty();
        $('#totalOrders').text('Thông tin giao dịch');
        $(this).find('button[type="submit"]').prop('disabled', false);
        isSearching = false;
    });
});

// Hàm hiển thị panel tìm kiếm
function showSearchPanel() {
    document.getElementById('refundTabsContent').classList.add('d-none');
    document.getElementById('searchRefundPanel').classList.remove('d-none');
    document.getElementById('refundTabs').classList.add('d-none');
}

// Hàm ẩn các panel
function hidePanels() {
    document.getElementById('refundTabsContent').classList.remove('d-none');
    document.getElementById('searchRefundPanel').classList.add('d-none');
    document.getElementById('refundTabs').classList.remove('d-none');
}