$(document).ready(function () {
    // Kiểm tra trạng thái đăng nhập
    checkLoginStatus();

    // Xử lý sự kiện đăng xuất
    $('#logout').on('click', function (e) {
        e.preventDefault();
        logout();
    });

    // Xử lý sự kiện thêm phiếu nhập cho từng tab
    $('#pending, #completed, #failed').find('.btn-success.btn-sm').each(function () {
        if ($(this).find('.bi-plus-lg').length) { // Chỉ chọn nút "Tạo phiếu nhập kho"
            $(this).on('click', function (e) {
                e.preventDefault();
                window.location.href = "add-inventory-receipt.html";
            });
        }
    });

    // ***************************************************Giao diện danh sách phiếu nhập***********************************************************
    // Mảng lưu trữ dữ liệu phiếu nhập theo trạng thái
    let inventoryReceiptData = {
        PENDING: { count: 0, data: [], currentPage: 1, totalPages: 1, pageSize: 5 },
        COMPLETED: { count: 0, data: [], currentPage: 1, totalPages: 1, pageSize: 5 },
        CANCELED: { count: 0, data: [], currentPage: 1, totalPages: 1, pageSize: 5 }
    };

    // Lưu searchParams toàn cục để tái sử dụng khi làm mới
    let currentSearchParams = null;

    // Ẩn khu vực .search-orders khi trang tải
    $('.search-orders').addClass('d-none');

    // Hàm gọi API để lấy danh sách phiếu nhập
    function fetchInventoryReceipts(status, page = 1) {
        $.ajax({
            url: `http://localhost:8080/doan/inventory-receipts/status/${status}`,
            method: 'GET',
            xhrFields: { withCredentials: true },
            data: { page: page, size: inventoryReceiptData[status].pageSize },
            success: function (response) {
                console.log(`API response for ${status}:`, response);
                if (response && response.code === 1000 && response.result) {
                    const { data, totalElements, totalPage, currentPage } = response.result;
                    inventoryReceiptData[status].count = totalElements || 0;
                    inventoryReceiptData[status].data = data || [];
                    inventoryReceiptData[status].currentPage = currentPage || 1;
                    inventoryReceiptData[status].totalPages = totalPage || 1;

                    // Cập nhật badge trên tab (nếu có)
                    $(`#${status.toLowerCase()}-tab .badge`).text(totalElements || 0);

                    // Render danh sách phiếu nhập
                    renderInventoryReceiptList(status, data || []);

                    // Cập nhật phân trang
                    renderPagination(status, currentPage || 1, totalPage || 1);
                } else {
                    console.warn(`No valid data for ${status}. Displaying empty state.`);
                    renderInventoryReceiptList(status, []);
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
                    console.error(`Error loading ${status} inventory-receipts:`, xhr.responseText);
                    let message = xhr.responseJSON?.message || 'Lỗi khi tải dữ liệu.';
                    alert(message);
                    renderInventoryReceiptList(status, []);
                    renderPagination(status, 1, 1);
                }
            }
        });
    }

    // Hàm render danh sách phiếu nhập
    function renderInventoryReceiptList(status, inventory_receipts) {
        const tabMapping = {
            PENDING: 'pending',
            COMPLETED: 'completed',
            CANCELED: 'failed'
        };
        const $tabPane = $(`#${tabMapping[status]}`);
        const $container = $tabPane.find('.bg-white.rounded-3.shadow-sm.p-4');
        $container.find('.border.rounded-3.p-3.mb-3:not(.template)').remove();

        $container.find('.fw-bold').first().text(`Tổng số: ${inventoryReceiptData[status].count} phiếu nhập`);

        if (!inventory_receipts || inventory_receipts.length === 0) {
            $container.find('.d-flex.justify-content-between').after(`
                <div class="text-center text-muted py-5">
                    <i class="bi bi-inbox fa-3x mb-3"></i>
                    <p>Không có phiếu nhập ${status === 'PENDING' ? 'đang chờ xử lý' : (status === 'COMPLETED' ? 'đã hoàn thành' : 'đã hủy')}</p>
                </div>
            `);
        } else {
            inventory_receipts.forEach(inventory_receipt => {
                const $template = $container.find('.template').clone().removeClass('template d-none').addClass('border rounded-3 p-3 mb-3');
                
                const statusText = status === 'PENDING' ? 'Chờ xử lý' : (status === 'COMPLETED' ? 'Hoàn thành' : 'Đã hủy');
                $template.find('.inventory-receipt-status').text(statusText);
                $template.find('.inventory-receipt-id').text(`#${inventory_receipt.id || 'N/A'}`);

				const createdDate = inventory_receipt.createdDate 
				    ? new Date(inventory_receipt.createdDate).toLocaleString('vi-VN', { 
				        day: '2-digit', 
				        month: '2-digit', 
				        year: 'numeric', 
				        hour: '2-digit', 
				        minute: '2-digit' 
				    })
				    : 'N/A';

				const modifiedDate = inventory_receipt.modifiedDate 
				    ? new Date(inventory_receipt.modifiedDate).toLocaleString('vi-VN', { 
				        day: '2-digit', 
				        month: '2-digit', 
				        year: 'numeric', 
				        hour: '2-digit', 
				        minute: '2-digit' 
				    })
				    : 'N/A';

				$template.find('.created-date').text(createdDate);
				$template.find('.modified-date').text(modifiedDate);
				$template.find('.created-by').text(inventory_receipt.createdBy || 'N/A');
				$template.find('.modified-by').text(inventory_receipt.modifiedBy || 'N/A');

                const totalAmount = inventory_receipt.totalAmount ? `${inventory_receipt.totalAmount.toLocaleString()}đ` : '0đ';
                $template.find('.total-amount').text(totalAmount);

                const $buttonContainer = $template.find('.col-md-3.text-end');
                $buttonContainer.empty();
                $buttonContainer.append(`
                    <button class="btn btn-primary btn-sm rounded-3 detail-btn"><i class="bi bi-chevron-double-right"></i> Chi tiết</button>
                `);

                $template.find('.detail-btn').on('click', function () {
                    const inventoryReceiptId = $template.find('.inventory-receipt-id').text().replace('#', '');
                    window.location.href = `detail-inventory-receipt.html?id=${inventoryReceiptId}`;
                });

                $container.append($template);
            });
        }
    }

    // Hàm render phân trang
    function renderPagination(status, current, totalPages) {
        const tabMapping = {
            PENDING: 'pending',
            COMPLETED: 'completed',
            CANCELED: 'failed'
        };
        const $pagination = $(`#${tabMapping[status]} .pagination`);
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
        }

        const nextClass = current === totalPages ? "disabled" : "";
        $pagination.append(`
            <li class="page-item ${nextClass}">
                <a class="page-link" href="#" data-page="${current + 1}">»</a>
            </li>
        `);

        $pagination.find('.page-link').on('click', function (e) {
            e.preventDefault();
            const page = $(this).data('page');
            if (page && page >= 1 && page <= totalPages) {
                fetchInventoryReceipts(status, page);
            }
        });
    }

    // Xử lý sự kiện submit form tìm kiếm
    $('#filterForm form').on('submit', function (e) {
        e.preventDefault();
        currentSearchParams = {
            id: $('#inventoryReceiptId').val().trim() || null,
            email: $('#email').val().trim() || null,
            fromDate: $('#fromDate').val() || null,
            toDate: $('#toDate').val() || null,
            page: 1,
            size: 10
        };
        getInventoryReceipts(currentSearchParams);
    });

    // Xử lý sự kiện reset form
    $('#filterForm form').on('reset', function () {
        const $container = $('.search-orders .bg-white.rounded-4.shadow.p-4');
        $container.find('.border.rounded-3.p-3.mb-3:not(.template)').remove();
        $container.find('.text-center.text-muted.py-5').remove();
        $container.find('.fw-bold').text('Tổng số: 0 phiếu nhập');
        $('.search-orders').addClass('d-none');

        const $pagination = $('.search-orders .pagination');
        $pagination.empty().append(`
            <li class="page-item disabled">
                <span class="page-link">«</span>
            </li>
            <li class="page-item active">
                <span class="page-link">1</span>
            </li>
            <li class="page-item disabled">
                <span class="page-link">»</span>
            </li>
        `);

        currentSearchParams = null;
    });

    // Hàm gọi API tìm kiếm phiếu nhập
    function getInventoryReceipts(params) {
        $.ajax({
            url: 'http://localhost:8080/doan/inventory-receipts',
            method: 'GET',
            xhrFields: { withCredentials: true },
            data: params,
            success: function (response) {
                console.log('Search API response:', response);
                if (response && response.code === 1000 && response.result) {
                    const { data, totalElements, totalPage, currentPage } = response.result;
                    renderSearchResults(data || [], totalElements || 0);
                    renderSearchPagination(currentPage || 1, totalPage || 1, params);
                } else {
                    console.warn('No valid data for search. Displaying empty state.');
                    renderSearchResults([], 0);
                    renderSearchPagination(1, 1, params);
                }
            },
            error: function (xhr) {
                console.error('Error searching inventory receipts:', xhr.responseText);
                let message = xhr.responseJSON?.message || 'Lỗi khi tìm kiếm phiếu nhập.';
                if (xhr.status === 401) {
                    if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                        localStorage.removeItem("id");
                        window.location.href = 'login.html';
                    }
                } else {
                    alert(message);
                    renderSearchResults([], 0);
                    renderSearchPagination(1, 1, params);
                }
            }
        });
    }

    // Hàm render kết quả tìm kiếm
    function renderSearchResults(inventory_receipts, totalCount) {
        const $tabPane = $('#searchInventoryReceiptPanel');
        const $container = $tabPane.find('.bg-white.rounded-4.shadow.p-4');
        $container.find('.border.rounded-3.p-3.mb-3:not(.template)').remove();
        $container.find('.text-center.text-muted.py-5').remove();

        // Thêm nút "Tạo phiếu nhập kho" và "Tải lên danh sách" vào khu vực tìm kiếm
        $container.find('.d-flex.justify-content-start.align-items-start.my-3').html(`
            <span class="fw-bold">Tổng số: ${totalCount} phiếu nhập</span>
        `);

        // Gắn sự kiện cho nút "Tạo phiếu nhập kho" trong khu vực tìm kiếm
        $container.find('.add-inventory-receipt').on('click', function (e) {
            e.preventDefault();
            window.location.href = "add-inventory-receipt.html";
        });

        if (!inventory_receipts || inventory_receipts.length === 0) {
            $container.find('.d-flex.justify-content-start').after(`
                <div class="text-center text-muted py-5">
                    <i class="bi bi-inbox fa-3x mb-3"></i>
                    <p>Không tìm thấy phiếu nhập nào.</p>
                </div>
            `);
            $('.search-orders').addClass('d-none');
        } else {
            $('.search-orders').removeClass('d-none');
            inventory_receipts.forEach(inventory_receipt => {
                const $template = $container.find('.template').clone().removeClass('template d-none').addClass('border rounded-3 p-3 mb-3');
                const statusText = inventory_receipt.status === 'PENDING' ? 'Chờ xử lý' : (inventory_receipt.status === 'COMPLETED' ? 'Hoàn thành' : 'Đã hủy');
                $template.find('.inventory-receipt-status').text(statusText);
                $template.find('.inventory-receipt-id').text(`#${inventory_receipt.id || 'N/A'}`);
                const createdDate = new Date(inventory_receipt.createdDate).toLocaleString('vi-VN', { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' });
                const modifiedDate = new Date(inventory_receipt.modifiedDate).toLocaleString('vi-VN', { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' });
                $template.find('.created-date').text(createdDate);
                $template.find('.modified-date').text(modifiedDate);
                $template.find('.created-by').text(inventory_receipt.createdBy || 'N/A');
                $template.find('.modified-by').text(inventory_receipt.modifiedBy || 'N/A');
                const totalAmount = inventory_receipt.totalAmount ? `${inventory_receipt.totalAmount.toLocaleString()}đ` : '0đ';
                $template.find('.total-amount').text(totalAmount);

                const $buttonContainer = $template.find('.col-md-3.text-end');
                $buttonContainer.empty();
                $buttonContainer.append(`
                    <button class="btn btn-primary btn-sm rounded-3 detail-btn"><i class="bi bi-chevron-double-right"></i> Chi tiết</button>
                `);

                $template.find('.detail-btn').on('click', function () {
                    const inventoryReceiptId = $template.find('.inventory-receipt-id').text().replace('#', '');
                    window.location.href = `detail-inventory-receipt.html?id=${inventoryReceiptId}`;
                });

                $container.append($template);
            });
        }
    }

    // Hàm render phân trang cho tìm kiếm
    function renderSearchPagination(current, totalPages, searchParams) {
        const $pagination = $('.search-orders .pagination');
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
        }

        const nextClass = current === totalPages ? "disabled" : "";
        $pagination.append(`
            <li class="page-item ${nextClass}">
                <a class="page-link" href="#" data-page="${current + 1}">»</a>
            </li>
        `);

        $pagination.find('.page-link').on('click', function (e) {
            e.preventDefault();
            const page = $(this).data('page');
            if (page && page >= 1 && page <= totalPages) {
                searchParams.page = page;
                getInventoryReceipts(searchParams);
            }
        });
    }

    // Gọi API cho tất cả các trạng thái khi trang tải
    const statuses = ['PENDING', 'COMPLETED', 'CANCELED'];
    statuses.forEach(status => {
        fetchInventoryReceipts(status, 1);
    });

    // Gọi API khi tab được kích hoạt
    $('#inventory-receiptTabs a[data-bs-toggle="pill"]').on('shown.bs.tab', function (e) {
        const tabId = $(e.target).attr('id');
        const statusMap = {
            'pending-tab': 'PENDING',
            'completed-tab': 'COMPLETED',
            'failed-tab': 'CANCELED'
        };
        const status = statusMap[tabId];
        if (status) {
            fetchInventoryReceipts(status, inventoryReceiptData[status].currentPage);
        }
    });

    // Xử lý sự kiện hiển thị giao diện tìm kiếm
    $(document).on('click', '[onclick="showSearchPanel()"]', function () {
        showSearchPanel();
    });
});

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

// Hàm hiển thị giao diện tìm kiếm
function showSearchPanel() {
    document.getElementById('inventoryReceiptTabsContent').classList.add('d-none');
    document.getElementById('searchInventoryReceiptPanel').classList.remove('d-none');
    document.getElementById('inventory-receiptTabs').classList.add('d-none');
    $('.search-orders').addClass('d-none');
}

// Hàm ẩn giao diện tìm kiếm và hiển thị giao diện ban đầu
function hidePanels() {
    document.getElementById('inventoryReceiptTabsContent').classList.remove('d-none');
    document.getElementById('searchInventoryReceiptPanel').classList.add('d-none');
    document.getElementById('inventory-receiptTabs').classList.remove('d-none');
    $('.search-orders').addClass('d-none');
}

// **************************************************** Modal Import ***************************************************************
// Xử lý modal Import QR
document.addEventListener('DOMContentLoaded', function() {
    // Xử lý modal Import QR
    var modal = document.getElementById('importQRModal');
    if (!modal) return;

    modal.addEventListener('shown.bs.modal', function() {
        var qrReaderResult = document.getElementById('qr-reader-result');
        var submitBtn = document.getElementById('submitQRBtn');
        var qrFileInput = document.getElementById('qrFileUpload');
        var qrFileInfoContainer = document.getElementById('qrFileInfoContainer');
        var qrFileNameText = document.getElementById('qrFileNameText');
        var qrRemoveFileBtn = document.getElementById('qrRemoveFileBtn');
        var qrFileIcon = document.querySelector('#qrFileInfoContainer .bi-image');
        var qrContentInput = document.getElementById('qrContent');
        var modalMessage = document.getElementById('modalQRMessage');

        if (!qrReaderResult || !submitBtn || !qrFileInput || !qrFileInfoContainer || !qrFileNameText || !qrRemoveFileBtn || !qrFileIcon || !qrContentInput || !modalMessage) {
            console.error('Không tìm thấy các phần tử cần thiết trong modal importQRModal');
            return;
        }

        var isQrScanned = false;

        function showQRFileInfo(fileName) {
            qrFileNameText.textContent = fileName;
            qrFileInfoContainer.hidden = false;
            qrFileIcon.hidden = false;
            qrRemoveFileBtn.hidden = false;
        }

        function updateSubmitButtons() {
            var hasFile = qrFileInput.files.length > 0;
            submitBtn.disabled = !hasFile && !isQrScanned;
        }

        function showModalMessage(message, type) {
            modalMessage.textContent = message;
            modalMessage.classList.remove('d-none', 'alert-success', 'alert-danger');
            modalMessage.classList.add(`alert-${type}`, 'show');
            setTimeout(() => {
                modalMessage.classList.add('d-none');
            }, 10000); // Ẩn thông báo sau 10 giây
        }

        function tryDecodeIsoToUtf8(text) {
            try {
                var uint8Array = new Uint8Array(text.split('').map(c => c.charCodeAt(0)));
                var decoder = new TextDecoder('utf-8');
                return decoder.decode(uint8Array);
            } catch (e) {
                return text;
            }
        }

        function sendQRData() {
            var formData = new FormData();
            var file = qrFileInput.files[0];
            var qrContent = qrContentInput.value.trim();

            if (!file && !isQrScanned) {
                showModalMessage('Vui lòng quét mã QR hoặc chọn file để nhập dữ liệu!', 'danger');
                return;
            }

            if (!file && qrContent && !/^[a-zA-Z0-9:|,.\-_\/{}[\]"=ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚÝàáâãèéêìíòóôõùúýĂăĐđĨĩŨũƠơƯưẠạẢảẤấẦầẨẩẪẫẬậẮắẰằẲẳẴẵẶặẸẹẺẻẼẽẾếỀềỂểỄễỆệỈỉỊịỌọỎỏỐốỒồỔổỖỗỘộỚớỜờỞởỠỡỢợỤụỦủỨứỬửỮữỰựỲỳỴỷỶỹỸỹ\s]+$/.test(qrContent)) {
                showModalMessage('Nội dung QR chứa ký tự không hợp lệ!', 'danger');
                return;
            }

            if (file) {
                formData.append('source', 'file');
                formData.append('file', file);
            } else {
                formData.append('source', 'camera');
                formData.append('qrContent', qrContent);
            }

            $.ajax({
                url: '/doan/inventory-receipts/import-qr',
                method: 'POST',
                data: formData,
                contentType: false,
                processData: false,
                xhrFields: { withCredentials: true },
                beforeSend: function() {
                    submitBtn.disabled = true;
                    submitBtn.innerHTML = '<i class="bi bi-hourglass-split"></i> Đang xử lý...';
                },
                success: function(response) {
                    showModalMessage('Đã thêm mới phiếu nhập thành công!', 'success');
                    qrFileInput.value = '';
                    qrContentInput.value = '';
                    qrFileNameText.textContent = '';
                    qrFileInfoContainer.hidden = true;
                    qrFileIcon.hidden = true;
                    qrRemoveFileBtn.hidden = true;
                    qrReaderResult.innerText = 'Đưa mã QR vào khung chấm sáng để quét.';
                    isQrScanned = false;
                    updateSubmitButtons();
                    setTimeout(() => {
                        $('#importQRModal').modal('hide');
                        location.reload();
                    }, 1500); // Chờ 1.5 giây để hiển thị thông báo
                },
                error: function(xhr) {
                    var errorMsg = xhr.responseJSON?.message || xhr.responseText || 'Đã xảy ra lỗi không xác định. Vui lòng thử lại!';
                    showModalMessage(`Lỗi khi thêm mới phiếu nhập: ${errorMsg}`, 'danger');
                },
                complete: function() {
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = '<i class="bi bi-cloud-arrow-up"></i> Tải lên';
                }
            });
        }

        qrContentInput.addEventListener('change', updateSubmitButtons);
        qrFileInput.addEventListener('change', function() {
            var file = qrFileInput.files[0];
            if (file) {
                // ✅ Added file validation
                var allowedTypes = ['.jpg', '.jpeg', '.png', '.gif', '.bmp'];
                var fileExtension = file.name.toLowerCase().substr(file.name.lastIndexOf('.'));
                
                if (!allowedTypes.includes(fileExtension)) {
                    showModalMessage('Chỉ chấp nhận file hình ảnh (.jpg, .jpeg, .png, .gif, .bmp)', 'danger');
                    qrFileInput.value = '';
                    return;
                }
                
                showQRFileInfo(file.name);
            }
            updateSubmitButtons();
        });

        var qrDropArea = document.getElementById('qrDropArea');
        qrDropArea.addEventListener('click', function() {
            qrFileInput.click();
        });
        qrDropArea.addEventListener('dragover', function(e) {
            e.preventDefault();
            qrDropArea.classList.add('border-primary', 'bg-light');
        });
        qrDropArea.addEventListener('dragleave', function() {
            qrDropArea.classList.remove('border-primary', 'bg-light');
        });
        qrDropArea.addEventListener('drop', function(e) {
            e.preventDefault();
            qrDropArea.classList.remove('border-primary', 'bg-light');
            var files = e.dataTransfer.files;
            if (files.length > 0) {
                qrFileInput.files = files;
                showQRFileInfo(files[0].name);
            }
            updateSubmitButtons();
        });

        qrRemoveFileBtn.addEventListener('click', function() {
            qrFileInput.value = '';
            qrFileNameText.textContent = '';
            qrFileInfoContainer.hidden = true;
            qrFileIcon.hidden = true;
            qrRemoveFileBtn.hidden = true;
            updateSubmitButtons();
        });

        submitBtn.addEventListener('click', sendQRData);

        // Khởi động camera với Html5Qrcode
        if (typeof Html5Qrcode === 'undefined') {
            qrReaderResult.innerText = 'Lỗi: Không thể tải thư viện quét QR. Vui lòng kiểm tra kết nối mạng.';
            qrDropArea.classList.remove('border-secondary');
            qrDropArea.classList.add('border-primary');
            return;
        }

        var html5QrCode = new Html5Qrcode('qr-reader');
        var isScanning = false;
        var scanInterval;

        function startScanning() {
            navigator.mediaDevices.getUserMedia({ video: true }).then(function(stream) {
                stream.getTracks().forEach(function(track) {
                    track.stop();
                });

                navigator.mediaDevices.enumerateDevices().then(function(devices) {
                    var videoDevices = devices.filter(function(device) {
                        return device.kind === 'videoinput';
                    });

                    if (videoDevices.length === 0) {
                        qrReaderResult.innerText = 'Không tìm thấy camera trên thiết bị. Vui lòng tải lên hình ảnh QR.';
                        qrDropArea.classList.remove('border-secondary');
                        qrDropArea.classList.add('border-primary');
                        return;
                    }

                    var cameraId = videoDevices[0].deviceId;

                    try {
                        html5QrCode.start(
                            cameraId,
                            {
                                fps: 15,
                                qrbox: { width: 400, height: 400 },
                                aspectRatio: 1.0,
                                experimentalFeatures: { useBarCodeDetectorIfSupported: true }
                            },
                            function(decodedText) {
                                if (decodedText.length > 500) {
                                    qrReaderResult.innerText = 'Nội dung QR quá dài (tối đa 500 ký tự).';
                                    return;
                                }
                                var correctedText = tryDecodeIsoToUtf8(decodedText);
                                qrContentInput.value = correctedText;
                                qrContentInput.dispatchEvent(new Event('change'));
                                qrReaderResult.innerHTML = 'Đã quét thành công!';
                                console.log('Nội dung QR thô:', decodedText);
                                console.log('Nội dung QR sau sửa:', correctedText);
                                clearInterval(scanInterval);
                                html5QrCode.stop();
                                isScanning = false;
                                isQrScanned = true;
                                updateSubmitButtons();
                            },
                            function(errorMessage) {
                                // Lỗi quét, tiếp tục quét
                            }
                        );
                        isScanning = true;
                    } catch (err) {
                        qrReaderResult.innerText = 'Lỗi khởi động camera: ' + err.message + '. Vui lòng tải lên hình ảnh QR.';
                        qrDropArea.classList.remove('border-secondary');
                        qrDropArea.classList.add('border-primary');
                        return;
                    }

                    scanInterval = setInterval(function() {
                        var video = document.querySelector('#qr-reader video');
                        if (video && video.videoWidth > 0 && isScanning) {
                            qrReaderResult.innerText = 'Camera đã bật. Đưa mã QR vào khung để quét.';
                        } else if (!isScanning) {
                            clearInterval(scanInterval);
                        }
                    }, 100);

                    setTimeout(function() {
                        var video = document.querySelector('#qr-reader video');
                        if (!video || video.videoWidth === 0) {
                            qrReaderResult.innerText = 'Lỗi: Camera không hiển thị. Vui lòng kiểm tra quyền camera hoặc thiết bị.';
                            qrDropArea.classList.remove('border-secondary');
                            qrDropArea.classList.add('border-primary');
                            clearInterval(scanInterval);
                            html5QrCode.stop();
                            isScanning = false;
                        }
                    }, 5000);

                }, function(err) {
                    qrReaderResult.innerText = 'Lỗi khi lấy danh sách camera: ' + err.message + '. Vui lòng tải lên hình ảnh QR.';
                    qrDropArea.classList.remove('border-secondary');
                    qrDropArea.classList.add('border-primary');
                });
            }, function(err) {
                qrReaderResult.innerText = 'Lỗi quyền camera: ' + err.message + '. Vui lòng cấp quyền và thử lại.';
                qrDropArea.classList.remove('border-secondary');
                qrDropArea.classList.add('border-primary');
            });
        }

        startScanning();

        modal.addEventListener('hidden.bs.modal', function() {
            if (isScanning) {
                clearInterval(scanInterval);
                try {
                    html5QrCode.stop();
                } catch (error) {
                    console.log('Camera đã được dừng');
                }
                isScanning = false;
            }
            isQrScanned = false;
            updateSubmitButtons();
        });
    });
});

// Xử lý Modal Excel
document.addEventListener('DOMContentLoaded', () => {
    const dropArea = document.getElementById('dropArea');
    const excelInput = document.getElementById('excelFile');
    const fileInfoContainer = document.getElementById('fileInfoContainer');
    const fileNameText = document.getElementById('fileNameText');
    const fileIcon = document.getElementById('fileIcon');
    const removeFileBtn = document.getElementById('removeFileBtn');
    const submitExcelCreate = document.getElementById('submitExcelCreate');
    const modalMessage = document.getElementById('modalExcelMessage');

    // Kiểm tra xem các phần tử có tồn tại không
    if (!dropArea || !excelInput || !fileInfoContainer || !fileNameText || !fileIcon || !removeFileBtn || !submitExcelCreate || !modalMessage) {
        console.error('Không tìm thấy các phần tử cần thiết trong modal importExcelModal');
        return;
    }

    // Hàm hiển thị thông tin file
    function showFileInfo(fileName) {
        fileNameText.textContent = fileName;
        fileInfoContainer.hidden = false;
        fileIcon.hidden = false;
        removeFileBtn.hidden = false;
    }

    // Hàm hiển thị thông báo trong modal
    function showModalMessage(message, type) {
        modalMessage.textContent = message;
        modalMessage.classList.remove('d-none', 'alert-success', 'alert-danger');
        modalMessage.classList.add(`alert-${type}`, 'show');
        setTimeout(() => {
            modalMessage.classList.add('d-none');
        }, 10000); // Ẩn thông báo sau 10 giây
    }

    // Xử lý sự kiện click vào khu vực kéo thả
    dropArea.addEventListener('click', () => excelInput.click());

    // Xử lý khi chọn file
    excelInput.addEventListener('change', () => {
        const file = excelInput.files[0];
        if (file) {
            // ✅ Added file validation
            const allowedTypes = ['.xlsx', '.xls'];
            const fileExtension = file.name.toLowerCase().substr(file.name.lastIndexOf('.'));
            
            if (!allowedTypes.includes(fileExtension)) {
                showModalMessage('Chỉ chấp nhận file Excel (.xlsx, .xls)', 'danger');
                excelInput.value = '';
                return;
            }
            
            showFileInfo(file.name);
        }
    });

    // Xử lý kéo thả file
    dropArea.addEventListener('dragover', (e) => {
        e.preventDefault();
        dropArea.classList.add('border-primary', 'bg-light');
    });

    dropArea.addEventListener('dragleave', () => {
        dropArea.classList.remove('border-primary', 'bg-light');
    });

    dropArea.addEventListener('drop', (e) => {
        e.preventDefault();
        dropArea.classList.remove('border-primary', 'bg-light');
        const files = e.dataTransfer.files;
        if (files.length > 0) {
            excelInput.files = files;
            showFileInfo(files[0].name);
        }
    });

    // Xử lý xóa file
    removeFileBtn.addEventListener('click', () => {
        excelInput.value = '';
        fileNameText.textContent = '';
        fileInfoContainer.hidden = true;
        fileIcon.hidden = true;
        removeFileBtn.hidden = true;
    });

    // Hàm gửi file Excel qua AJAX
    function sendExcelFile() {
        const file = excelInput.files[0];
        if (!file) {
            showModalMessage('Vui lòng chọn file Excel trước khi thực hiện!', 'danger');
            return;
        }

        const formData = new FormData();
        formData.append('file', file);

        const url = '/doan/inventory-receipts/import-excel';

        $.ajax({
            url: url,
            method: 'POST',
            xhrFields: { withCredentials: true },
            data: formData,
            contentType: false,
            processData: false,
            beforeSend: function() {
                submitExcelCreate.disabled = true;
                submitExcelCreate.innerHTML = '<i class="bi bi-hourglass-split"></i> Đang xử lý...';
            },
            success: function(response) {
                showModalMessage('Đã thêm mới phiếu nhập thành công!', 'success');
                
                // Reset form
                excelInput.value = '';
                fileNameText.textContent = '';
                fileInfoContainer.hidden = true;
                fileIcon.hidden = true;
                removeFileBtn.hidden = true;
                
                // Đóng modal sau khi hiển thị thông báo thành công
                setTimeout(() => {
                    $('#importExcelModal').modal('hide');
                    location.reload();
                }, 1500); // Chờ 1.5 giây để user thấy thông báo thành công
            },
            error: function(xhr) {
                const errorMsg = xhr.responseJSON?.message || xhr.responseText || 'Đã xảy ra lỗi không xác định. Vui lòng thử lại!';
                showModalMessage(`Lỗi khi thêm mới phiếu nhập: ${errorMsg}`, 'danger');
            },
            complete: function() {
                submitExcelCreate.disabled = false;
                submitExcelCreate.innerHTML = '<i class="bi bi-cloud-arrow-up"></i> Tải lên';
            }
        });
    }

    // Xử lý nút "Thêm mới"
    submitExcelCreate.addEventListener('click', sendExcelFile);
});

// Xử lý modal importPDFModal
document.addEventListener('DOMContentLoaded', () => {
    const pdfDropArea = document.getElementById('pdfDropArea');
    const pdfInput = document.getElementById('pdfFile');
    const pdfFileInfoContainer = document.getElementById('pdfFileInfoContainer');
    const pdfFileNameText = document.getElementById('pdfFileNameText');
    const pdfFileIcon = document.getElementById('pdfFileIcon');
    const pdfRemoveFileBtn = document.getElementById('pdfRemoveFileBtn');
    const submitPdfCreate = document.getElementById('submitPdfCreate');
    const modalMessage = document.getElementById('modalPdfMessage');

    // Kiểm tra xem các phần tử có tồn tại không
    if (!pdfDropArea || !pdfInput || !pdfFileInfoContainer || !pdfFileNameText || !pdfFileIcon || !pdfRemoveFileBtn || !submitPdfCreate || !modalMessage) {
        console.error('Không tìm thấy các phần tử cần thiết trong modal importPDFModal');
        return;
    }

    // Hàm hiển thị thông tin file
    function showPDFFileInfo(fileName) {
        pdfFileNameText.textContent = fileName;
        pdfFileInfoContainer.hidden = false;
        pdfFileIcon.hidden = false;
        pdfRemoveFileBtn.hidden = false;
    }

    // Hàm hiển thị thông báo trong modal
    function showModalMessage(message, type) {
        modalMessage.textContent = message;
        modalMessage.classList.remove('d-none', 'alert-success', 'alert-danger');
        modalMessage.classList.add(`alert-${type}`, 'show');
        setTimeout(() => {
            modalMessage.classList.add('d-none');
        }, 10000); // Ẩn thông báo sau 10 giây
    }

    // Xử lý sự kiện click vào khu vực kéo thả
    pdfDropArea.addEventListener('click', () => pdfInput.click());

    // Xử lý khi chọn file
    pdfInput.addEventListener('change', () => {
        const file = pdfInput.files[0];
        if (file) {
            // ✅ Added file validation
            const allowedTypes = ['.pdf'];
            const fileExtension = file.name.toLowerCase().substr(file.name.lastIndexOf('.'));
            
            if (!allowedTypes.includes(fileExtension)) {
                showModalMessage('Chỉ chấp nhận file PDF (.pdf)', 'danger');
                pdfInput.value = '';
                return;
            }
            
            showPDFFileInfo(file.name);
        }
    });

    // Xử lý kéo thả file
    pdfDropArea.addEventListener('dragover', (e) => {
        e.preventDefault();
        pdfDropArea.classList.add('border-primary', 'bg-light');
    });

    pdfDropArea.addEventListener('dragleave', () => {
        pdfDropArea.classList.remove('border-primary', 'bg-light');
    });

    pdfDropArea.addEventListener('drop', (e) => {
        e.preventDefault();
        pdfDropArea.classList.remove('border-primary', 'bg-light');
        const files = e.dataTransfer.files;
        if (files.length > 0) {
            pdfInput.files = files;
            showPDFFileInfo(files[0].name);
        }
    });

    // Xử lý xóa file
    pdfRemoveFileBtn.addEventListener('click', () => {
        pdfInput.value = '';
        pdfFileNameText.textContent = '';
        pdfFileInfoContainer.hidden = true;
        pdfFileIcon.hidden = true;
        pdfRemoveFileBtn.hidden = true;
    });

    // Hàm gửi file PDF qua AJAX
    function sendPDFFile() {
        const file = pdfInput.files[0];
        const sourcePage = document.getElementById('sourcePage').value;

        if (!file) {
            showModalMessage('Vui lòng chọn file PDF trước khi thực hiện!', 'danger');
            return;
        }

        const formData = new FormData();
        formData.append('file', file);
        formData.append('sourcePage', sourcePage);
        formData.append('action', 'create');

        $.ajax({
            url: '/doan/inventory-receipts/import-pdf',
            method: 'POST',
            xhrFields: { withCredentials: true },
            data: formData,
            contentType: false,
            processData: false,
            beforeSend: function() {
                submitPdfCreate.disabled = true;
                submitPdfCreate.innerHTML = '<i class="bi bi-hourglass-split"></i> Đang xử lý...';
            },
            success: function(response) {
                showModalMessage('Đã thêm mới phiếu nhập thành công!', 'success');
                
                // Reset form
                pdfInput.value = '';
                pdfFileNameText.textContent = '';
                pdfFileInfoContainer.hidden = true;
                pdfFileIcon.hidden = true;
                pdfRemoveFileBtn.hidden = true;
                
                // Đóng modal và reload trang
                setTimeout(() => {
                    $('#importPDFModal').modal('hide');
                    location.reload();
                }, 1500); // Chờ 1.5 giây để user thấy thông báo thành công
            },
            error: function(xhr) {
                const errorMsg = xhr.responseJSON?.message || xhr.responseText || 'Đã xảy ra lỗi không xác định. Vui lòng thử lại!';
                showModalMessage(`Lỗi khi thêm mới phiếu nhập: ${errorMsg}`, 'danger');
            },
            complete: function() {
                submitPdfCreate.disabled = false;
                submitPdfCreate.innerHTML = '<i class="bi bi-cloud-arrow-up"></i> Tải lên';
            }
        });
    }

    // Xử lý nút "Thêm mới"
    submitPdfCreate.addEventListener('click', sendPDFFile);
});

// Xử lý modal importAIModal
document.addEventListener('DOMContentLoaded', () => {
    const aiModal = document.getElementById('importAIModal');
    if (!aiModal) return;

    const quantityInput = document.getElementById('quantity');
    const submitButton = document.getElementById('submitAIImport');
    const modalMessageAI = document.getElementById('modalAIMessage');

    if (!quantityInput || !submitButton || !modalMessageAI) {
        console.error('Không tìm thấy các phần tử cần thiết trong modal importAIModal');
        return;
    }

    function showModalMessageAI(message, type) {
        modalMessageAI.textContent = message;
        modalMessageAI.classList.remove('d-none', 'alert-success', 'alert-danger');
        modalMessageAI.classList.add(`alert-${type}`, 'show');
        setTimeout(() => {
            modalMessageAI.classList.add('d-none');
        }, 10000);
    }

    submitButton.addEventListener('click', () => {
        const quantity = parseInt(quantityInput.value);

        if (isNaN(quantity) || quantity < 1 || quantity > 100) {
            showModalMessageAI('Vui lòng nhập số lượng từ 1 đến 100.', 'danger');
            return;
        }

        $.ajax({
            url: '/doan/inventory-receipts/import-ai',
            method: 'POST',
            data: { quantity: quantity },
            xhrFields: { withCredentials: true },
            beforeSend: function() {
                submitButton.disabled = true;
                submitButton.innerHTML = '<i class="bi bi-hourglass-split"></i> Đang xử lý...';
            },
            success: function(response) {
                showModalMessageAI('Đã thêm mới phiếu nhập thành công!', 'success');
                quantityInput.value = '';
                setTimeout(() => {
                    $('#importAIModal').modal('hide');
                    location.reload();
                }, 1500);
            },
            error: function(xhr) {
                const errorMsg = xhr.responseJSON?.message || xhr.responseText || 'Đã xảy ra lỗi không xác định. Vui lòng thử lại!';
                showModalMessageAI(`Lỗi khi thêm mới phiếu nhập: ${errorMsg}`, 'danger');
            },
            complete: function() {
                submitButton.disabled = false;
                submitButton.innerHTML = '<i class="bi bi-cloud-arrow-up"></i> Thêm mới';
            }
        });
    });
});