$(document).ready(function () {
    // Kiểm tra trạng thái đăng nhập
    checkLoginStatus();

    // Xử lý sự kiện đăng xuất
    $('#logout').on('click', function (e) {
        e.preventDefault();
        logout();
    });
	
	/****************************************************Giao diện danh sách đơn hàng************************************************************/
    // Mảng lưu trữ dữ liệu đơn hàng theo trạng thái
    let orderData = {
        PENDING: { count: 0, data: [], currentPage: 1, totalPages: 1, pageSize: 5 },
        CANCELLED: { count: 0, data: [], currentPage: 1, totalPages: 1, pageSize: 5 },
        CONFIRMED: { count: 0, data: [], currentPage: 1, totalPages: 1, pageSize: 5 },
        SHIPPING: { count: 0, data: [], currentPage: 1, totalPages: 1, pageSize: 5 },
        COMPLETED: { count: 0, data: [], currentPage: 1, totalPages: 1, pageSize: 5 },
        FAILED: { count: 0, data: [], currentPage: 1, totalPages: 1, pageSize: 5 }
    };

    // Hàm gọi API để lấy danh sách đơn hàng
    function fetchOrders(status, page = 1) {
        $.ajax({
            url: `http://localhost:8080/doan/orders/status/${status}`,
            method: 'GET',
            xhrFields: { withCredentials: true },
            data: { page: page, size: orderData[status].pageSize },
            success: function (response) {
                console.log(`API response for ${status}:`, response);
                if (response && response.code === 1000 && response.result) {
                    const { data, totalElements, totalPage, currentPage } = response.result;
                    orderData[status].count = totalElements || 0;
                    orderData[status].data = data || [];
                    orderData[status].currentPage = currentPage || 1;
                    orderData[status].totalPages = totalPage || 1;

                    // Cập nhật badge trên tab (nếu có)
                    $(`#${status.toLowerCase()}-tab .badge`).text(totalElements || 0);

                    // Render danh sách đơn hàng
                    renderOrderList(status, data || []);

                    // Cập nhật phân trang
                    renderPagination(status, currentPage || 1, totalPage || 1);
                } else {
                    console.warn(`No valid data for ${status}. Displaying empty state.`);
                    renderOrderList(status, []);
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
                    console.error(`Error loading ${status} orders:`, xhr.responseText);
                    let message = xhr.responseJSON?.message || 'Lỗi khi tải dữ liệu.';
                    alert(message);
                    renderOrderList(status, []);
                    renderPagination(status, 1, 1);
                }
            }
        });
    }

    // Hàm render danh sách đơn hàng
    function renderOrderList(status, orders) {
        const $tabPane = $(`#${status.toLowerCase()}`);
        const $container = $tabPane.find('.bg-white.rounded-3.shadow-sm.p-4');
        $container.find('.border.rounded-3.p-3.mb-3:not(.template)').remove(); // Xóa các mục không phải template

        if (!orders || orders.length === 0) {
            $container.html(`
				<div class="text-end">
                    <button class="btn btn-success btn-sm" onclick="showSearchPanel()">
                        <i class="bi bi-search"></i> Tìm kiếm
                    </button>
                    <button class="btn btn-primary btn-sm" onclick="showCreatePanel()">
                        <i class="bi bi-plus"></i> Thêm mới
                    </button>
                </div>
                <div class="text-center text-muted py-5">
                    <i class="bi bi-inbox fa-3x mb-3"></i>
                    <p>Không có đơn hàng ${status.toLowerCase().replace(/^\w/, c => c.toUpperCase())}</p>
                </div>
            `);
        } else {
            orders.forEach(order => {
                const $template = $container.find('.template').clone().removeClass('template d-none').addClass('border rounded-3 p-3 mb-3');
                $template.find('.status').text(order.status || status);
                $template.find('.order-id').text(`#${order.id || 'N/A'}`);
                $template.find('.customer-name').text(order.fullName || 'N/A');
                $template.find('.customer-phone').text(order.phone || 'N/A');

                // Render danh sách sản phẩm
                const $productContainer = $template.find('.product-container');
                $productContainer.empty();
                (order.details || []).forEach((item, index) => {
                    const $productItem = $(`
                        <div class="d-flex align-items-center cursor-pointer mb-2 ${index > 0 ? 'mt-2' : ''}">
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

                // Thay thế cột .item-count bằng nút "Chi tiết" và "Hủy đơn hàng" tùy theo tab
                const $buttonContainer = $template.find('.col-md-2.text-end');
                $buttonContainer.empty();
                if (status === 'PENDING') {
                    $buttonContainer.append(`
                        <button class="btn btn-primary btn-sm rounded-3 w-75 detail-btn"><i class="bi bi-chevron-double-right"></i> Chi tiết</button>
                        <button class="btn btn-outline-danger btn-sm rounded-3 mt-2 w-75 cancel-btn">Hủy đơn hàng</button>
                    `);
                } else {
                    $buttonContainer.append(`
                        <button class="btn btn-primary btn-sm rounded-3 w-75 detail-btn"><i class="bi bi-chevron-double-right"></i> Chi tiết</button>
                    `);
                }

                $container.append($template);
            });

            // Cập nhật tổng số đơn hàng dựa trên totalElements
            $tabPane.find('.text-muted').first().text(`Tổng số: ${orderData[status].count} đơn hàng`);
        }

        // Gắn sự kiện cho nút "Hủy đơn hàng"
        $container.find('.cancel-btn').off('click').on('click', function () {
            const $orderItem = $(this).closest('.border.rounded-3.p-3.mb-3');
            const orderId = $orderItem.find('.order-id').text().replace('#', '');
            cancelOrder(orderId, status);
        });

		// Gắn sự kiện cho nút "Chi tiết" để chuyển hướng
        $container.find('.detail-btn').off('click').on('click', function () {
            const $orderItem = $(this).closest('.border.rounded-3.p-3.mb-3');
            const orderId = $orderItem.find('.order-id').text().replace('#', '');
            window.location.href = `detail-order.html?id=${orderId}`; // Chuyển hướng với id
        });
    }

    // Hàm hủy đơn hàng
    function cancelOrder(orderId, status) {
        if (confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')) {
            $.ajax({
                url: `http://localhost:8080/doan/orders/${orderId}/cancel`,
                method: 'PATCH',
                xhrFields: { withCredentials: true },
                success: function (response) {
                    console.log(`Cancel response for order ${orderId}:`, response);
                    if (response && response.code === 1000) {
                        alert('Đơn hàng đã được hủy thành công.');
                        fetchOrders(status); // Làm mới danh sách đơn hàng
                    } else {
                        alert('Hủy đơn hàng thất bại: ' + (response.message || 'Lỗi không xác định'));
                    }
                },
                error: function (xhr) {
                    console.error(`Error canceling order ${orderId}:`, xhr.responseText);
                    let message = xhr.responseJSON?.message || 'Lỗi khi hủy đơn hàng.';
                    alert(message);
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
                fetchOrders(status, page);
            }
        });
    }

    // Gọi API cho tất cả các trạng thái khi trang tải
    const statuses = ['PENDING', 'CANCELLED', 'CONFIRMED', 'SHIPPING', 'COMPLETED', 'FAILED'];
    statuses.forEach(status => {
        fetchOrders(status, 1);
    });

    // Gọi API khi tab được kích hoạt
    $('#orderTabs a[data-bs-toggle="pill"]').on('shown.bs.tab', function (e) {
        const status = $(e.target).attr('id').split('-')[0].toUpperCase();
        fetchOrders(status, orderData[status].currentPage);
    });
	
	// Xử lý sự kiện submit form tìm kiếm
    $('#filterForm form').on('submit', function (e) {
        e.preventDefault(); // Ngăn chặn hành vi submit mặc định

        // Thu thập dữ liệu từ form
        const searchParams = {
            id: $('#orderId').val().trim() || null,
            email: $('#email').val().trim() || null,
            fullName: $('#fullName').val().trim() || null,
            phone: $('#phone').val().trim() || null,
            fromDate: $('#fromDate').val() || null,
            toDate: $('#toDate').val() || null,
            page: 1,
            size: 10 // Kích thước trang mặc định, khớp với API
        };

        // Gọi API tìm kiếm đơn hàng
        getOrders(searchParams);
    });

	/********************************************************Giao diện tìm kiếm**********************************************************************/
	// Lưu searchParams toàn cục để tái sử dụng khi làm mới
    let currentSearchParams = null;

    // Ẩn khu vực .search-orders khi trang tải
    $('.search-orders').addClass('d-none');

    // Xử lý sự kiện submit form tìm kiếm
    $('#filterForm form').on('submit', function (e) {
        e.preventDefault(); // Ngăn chặn hành vi submit mặc định
        // Thu thập dữ liệu từ form
        currentSearchParams = {
            id: $('#orderId').val().trim() || null,
            email: $('#email').val().trim() || null,
            fullName: $('#fullName').val().trim() || null,
            phone: $('#phone').val().trim() || null,
            fromDate: $('#fromDate').val() || null,
            toDate: $('#toDate').val() || null,
            page: 1,
            size: 10 // Kích thước trang mặc định, khớp với API
        };

        // Gọi API tìm kiếm đơn hàng
        getOrders(currentSearchParams);
    });

    // Xử lý sự kiện reset form (Xóa bộ lọc)
    $('#filterForm form').on('reset', function () {
        // Xóa danh sách kết quả tìm kiếm
        const $container = $('.search-orders .bg-white.rounded-4.shadow.p-4');
        $container.find('.border.rounded-3.p-3.mb-3:not(.template)').remove();
        $container.find('.text-center.text-muted.py-5').remove();
        $container.find('.fw-bold').text('Tổng số: 0 đơn hàng');
        $('.search-orders').addClass('d-none'); // Ẩn khu vực kết quả

        // Đặt lại phân trang về trạng thái ban đầu
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

        // Xóa searchParams hiện tại
        currentSearchParams = null;
    });

    // Xử lý sự kiện khi hiển thị giao diện tìm kiếm
    $(document).on('click', '[onclick="showSearchPanel()"]', function () {
        $('.search-orders').addClass('d-none'); // Ẩn khu vực .search-orders khi vào giao diện tìm kiếm
    });

    // Hàm gọi API để lấy danh sách đơn hàng
    function getOrders(params) {
        $.ajax({
            url: 'http://localhost:8080/doan/orders',
            method: 'GET',
            xhrFields: { withCredentials: true },
            data: params,
            success: function (response) {
                console.log('Search API response:', response);
                if (response && response.code === 1000 && response.result) {
                    const { data, totalElements, totalPage, currentPage } = response.result;
                    // Render danh sách đơn hàng
                    renderSearchResults(data || [], totalElements || 0);
                    // Render phân trang
                    renderSearchPagination(currentPage || 1, totalPage || 1, params);
                } else {
                    console.warn('No valid data for search. Displaying empty state.');
                    renderSearchResults([], 0);
                    renderSearchPagination(1, 1, params);
                }
            },
            error: function (xhr) {
                console.error('Error searching orders:', xhr.responseText);
                let message = xhr.responseJSON?.message || 'Lỗi khi tìm kiếm đơn hàng.';
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

    // Hàm render danh sách đơn hàng tìm kiếm
    function renderSearchResults(orders, totalCount) {
        const $container = $('.search-orders .bg-white.rounded-4.shadow.p-4');
        const $searchOrders = $('.search-orders');
        // Xóa các mục cũ và thông báo rỗng
        $container.find('.border.rounded-3.p-3.mb-3:not(.template)').remove();
        $container.find('.text-center.text-muted.py-5').remove();

        // Cập nhật tổng số đơn hàng
        $container.find('.fw-bold').text(`Tổng số: ${totalCount} đơn hàng`);

        if (!orders || orders.length === 0) {
            $container.find('.template').after(`
                <div class="text-center text-muted py-5">
                    <i class="bi bi-inbox fa-3x mb-3"></i>
                    <p>Không tìm thấy đơn hàng nào.</p>
                </div>
            `);
            $searchOrders.addClass('d-none'); // Ẩn khu vực kết quả
        } else {
            $searchOrders.removeClass('d-none'); // Hiện khu vực kết quả
            orders.forEach(order => {
                const $template = $container.find('.template').clone().removeClass('template d-none');
                $template.find('.status').text(order.status || 'N/A');
                $template.find('.order-id').text(`#${order.id || 'N/A'}`);
                $template.find('.customer-name').text(order.fullName || 'N/A');
                $template.find('.customer-phone').text(order.phone || 'N/A');

                // Render danh sách sản phẩm
                const $productContainer = $template.find('.product-container');
                $productContainer.empty();
                (order.details || []).forEach((item, index) => {
                    const $productItem = $(`
                        <div class="d-flex align-items-center cursor-pointer mb-2 ${index > 0 ? 'mt-2' : ''}">
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

                // Thêm nút "Chi tiết" và "Hủy" (nếu trạng thái là PENDING)
                const $buttonContainer = $template.find('.col-md-2.text-end');
                $buttonContainer.empty();
                $buttonContainer.append(`
                    <button class="btn btn-primary btn-sm rounded-3 w-75 detail-btn"><i class="bi bi-chevron-double-right"></i> Chi tiết</button>
                `);
                if (order.status === 'PENDING') {
                    $buttonContainer.append(`
                        <button class="btn btn-outline-danger btn-sm rounded-3 mt-2 w-75 cancel-btn">Hủy đơn hàng</button>
                    `);
                }

                // Thêm template vào sau .template gốc
                $container.find('.template').after($template);

                // Gắn sự kiện cho nút "Chi tiết"
                $template.find('.detail-btn').on('click', function () {
                    const orderId = $template.find('.order-id').text().trim().replace(/^#/, '');
                    window.location.href = `detail-order.html?id=${orderId}`;
                });

                // Gắn sự kiện cho nút "Hủy"
                $template.find('.cancel-btn').on('click', function () {
                    const orderId = $template.find('.order-id').text().trim().replace(/^#/, '');
                    cancelOrderSearch(orderId);
                });
            });
        }
    }

    // Hàm hủy đơn hàng (làm mới giao diện tìm kiếm)
    function cancelOrderSearch(orderId) {
        if (confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')) {
            $.ajax({
                url: `http://localhost:8080/doan/orders/${orderId}/cancel`,
                method: 'PATCH',
                xhrFields: { withCredentials: true },
                success: function (response) {
                    console.log(`Cancel response for order ${orderId}:`, response);
                    if (response && response.code === 1000) {
                        alert('Đơn hàng đã được hủy thành công!');
                        // Làm mới giao diện tìm kiếm nếu có searchParams
                        if (currentSearchParams) {
                            getOrders(currentSearchParams);
                        } else {
                            // Nếu không có searchParams, đặt lại giao diện
                            $('#filterForm form').trigger('reset');
                        }
                    } else {
                        alert('Hủy đơn hàng thất bại: ' + (response.message || 'Lỗi không xác định'));
                    }
                },
                error: function (xhr) {
                    console.error(`Error canceling order ${orderId}:`, xhr.responseText);
                    let message = xhr.responseJSON?.message || 'Lỗi khi hủy đơn hàng.';
                    alert(message);
                }
            });
        }
    }

    // Hàm render phân trang
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
                searchParams.page = page;
                getOrders(searchParams);
            }
        });
    }
	
	/*******************************************************Giao diện thêm đơn hàng******************************************************************/
	// Biến lưu trữ danh sách sản phẩm trong bảng
	let cartItems = [];
	let selectedCode = null;

	const $productInput = $('#search-code');
	const $tableBody = $('#createOrderPanel tbody');
	const $totalAmount = $('#createOrderPanel #totalAmount');

	// Khôi phục trạng thái ban đầu khi focus vào input
	$productInput.on('focus', function () {
	    if (selectedCode) {
	        $(this).val('').removeClass('selected').removeAttr('readonly'); // Trở về placeholder ban đầu
	    }
	});

	// Ngăn chỉnh sửa và xử lý khi nhập lại
	$productInput.on('input', function () {
	    const query = $(this).val().trim();
	    if ($(this).hasClass('selected') && query !== selectedCode) {
	        $(this).val(selectedCode); // Khôi phục giá trị nếu cố chỉnh sửa
	        return;
	    }
	    if (query.length === 0 && selectedCode) {
	        $(this).removeClass('selected').removeAttr('readonly'); // Xóa class và readonly khi xóa hết
	    } else if (query.length < 3) {
	        $('#productSuggestions').remove();
	        return;
	    }
	    $.ajax({
	        url: 'http://localhost:8080/doan/products',
	        method: 'GET',
	        xhrFields: { withCredentials: true },
	        data: { code: query, sortBy: 'code', direction: 'DESC' },
	        success: function (response) {
	            if (response && response.code === 1000 && response.result && response.result.data) {
	                const suggestions = response.result.data;
	                let $suggestions = $('#productSuggestions');
	                if ($suggestions.length) $suggestions.remove();
	                if (suggestions.length > 0) {
	                    const inputOffset = $productInput.offset();
	                    $suggestions = $('<div id="productSuggestions" class="list-group bg-white shadow rounded-3" style="position: absolute; z-index: 1000; width: 25%; top: ' + (inputOffset.top + $productInput.outerHeight()) + 'px; left: ' + inputOffset.left + 'px;"></div>');
	                    suggestions.forEach(product => {
	                        $suggestions.append(`
	                            <a href="#" class="list-group-item list-group-item-action" data-code="${product.code}">${product.code} - ${product.name}</a>
	                        `);
	                    });
	                    $('body').append($suggestions);
	                    $suggestions.on('click', 'a', function (e) {
	                        e.preventDefault();
	                        selectedCode = $(this).data('code'); // Lưu mã đã chọn
	                        if (cartItems.some(item => item.code === selectedCode)) {
	                            alert('Sản phẩm này đã tồn tại trong bảng!');
	                            $productInput.val('').removeClass('selected').removeAttr('readonly'); // Reset input
	                            return;
	                        }
	                        $productInput.val(selectedCode).addClass('selected').attr('readonly', 'readonly'); // Hiển thị với hiệu ứng placeholder và khóa
	                        $suggestions.remove();
	                        fetchProductDetails(selectedCode);
	                    });
	                }
	            }
	        },
	        error: function (xhr) {
	            console.error('Error fetching product suggestions:', xhr.responseText);
	        }
	    });
	});

	function fetchProductDetails(code) {
	    $.ajax({
	        url: `http://localhost:8080/doan/products/${code}`,
	        method: 'GET',
	        xhrFields: { withCredentials: true },
	        success: function (response) {
	            if (response && response.code === 1000 && response.result) {
	                const product = response.result;
	                const price = product.discountPrice || product.price;
	                const displayPrice = product.discountPrice ? `<del>${product.price.toLocaleString()}đ</del><br>
	                    <span class="text-danger">${product.discountPrice.toLocaleString()}đ</span>` : `${product.price.toLocaleString()}đ`;
	                const total = price * 1;

	                const $newRow = $(`
	                    <tr>
	                        <td>${product.code}</td>
	                        <td class="text-center">
	                            <input class="w-25 rounded-2 ps-2 quantity" type="number" value="1" style="border-color: rgba(0,0,0,0.2);" min="1">
	                        </td>
	                        <td class="text-end">${displayPrice}</td>
	                        <td class="text-end total-price">${total.toLocaleString()}đ</td>
	                        <td class="text-center"><button class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> Xóa</button></td>
	                    </tr>
	                `);
	                $tableBody.append($newRow);
	                cartItems.push({ code: product.code, productId: product.id, price: price, quantity: 1, total: total });
	                updateTotalAmount();
	                $newRow.find('.quantity').on('change', function () {
	                    const qty = parseInt($(this).val()) || 1;
	                    const $row = $(this).closest('tr');
	                    const index = $row.index();
	                    cartItems[index].quantity = qty;
	                    cartItems[index].total = qty * price;
	                    $row.find('.total-price').text((qty * price).toLocaleString() + 'đ');
	                    updateTotalAmount();
	                });
	                $newRow.find('button').on('click', function () {
	                    const $row = $(this).closest('tr');
	                    const index = $row.index();
	                    cartItems.splice(index, 1);
	                    $row.remove();
	                    updateTotalAmount();
	                });
	            }
	        },
	        error: function (xhr) {
	            console.error('Error fetching product details:', xhr.responseText);
	            alert('Không tìm thấy sản phẩm.');
	        }
	    });
	}

	function updateTotalAmount() {
	    const total = cartItems.reduce((sum, item) => sum + item.total, 0);
	    $totalAmount.text(total.toLocaleString() + 'đ');
	    $('#createOrderPanel .totalAmount').text(total.toLocaleString() + 'đ');
	}

	// Xử lý sự kiện khi nhấn nút "Đặt hàng"
	$('#createOrderPanel .btn-primary').on('click', function () {
	    if (cartItems.length === 0) {
	        alert('Vui lòng thêm ít nhất một sản phẩm vào đơn hàng!');
	        return;
	    }

	    const email = $('#createOrderPanel #email').val().trim();
	    if (!email) {
	        alert('Vui lòng nhập email!');
	        return;
	    }
	    
	    const phone = $('#createOrderPanel #phone').val().trim();
	    if (!phone || !/^0\d{9}$/.test(phone)) {
	        alert('Số điện thoại phải là 10 chữ số và bắt đầu bằng số 0');
	        return;
	    }

	    if (confirm('Bạn có chắc chắn muốn thêm đơn hàng này không?')) {
	        // Bước 1: Lấy userId dựa trên email
	        $.ajax({
	            url: 'http://localhost:8080/doan/orders',
	            method: 'GET',
	            xhrFields: { withCredentials: true },
	            data: { email: email },
	            success: function (response) {
	                if (response && response.code === 1000 && response.result && response.result.data && response.result.data.length > 0) {
	                    const userId = response.result.data[0].userId;

	                    // Bước 2: Lưu địa chỉ
	                    const addressData = {
	                        userId: userId,
	                        fullName: $('#createOrderPanel #fullName').val().trim(),
	                        phone: phone,
	                        province: $('#createOrderPanel #province').val().trim(),
	                        district: $('#createOrderPanel #district').val().trim(),
	                        ward: $('#createOrderPanel #ward').val().trim(),
	                        detail: $('#createOrderPanel #detail').val().trim()
	                    };

	                    $.ajax({
	                        url: 'http://localhost:8080/doan/addresses',
	                        method: 'POST',
	                        contentType: 'application/json',
	                        xhrFields: { withCredentials: true },
	                        data: JSON.stringify(addressData),
	                        success: function (addressResponse) {
	                            if (addressResponse && addressResponse.code === 1000 && addressResponse.result) {
	                                const addressId = addressResponse.result.id;

	                                // Bước 3: Lưu đơn hàng
	                                const orderData = {
	                                    userId: userId,
	                                    orderType: 'OFFLINE',
	                                    totalPrice: cartItems.reduce((sum, item) => sum + item.total, 0),
	                                    paymentMethod: $('#createOrderPanel input[name="paymentMethod"]:checked').val() || 'CASH',
	                                    note: $('#createOrderPanel #note').val().trim(),
	                                    addressId: addressId,
	                                    details: cartItems.map(item => ({
	                                        productId: item.productId,
	                                        quantity: item.quantity,
	                                        priceAtPurchase: item.price
	                                    }))
	                                };

	                                $.ajax({
	                                    url: 'http://localhost:8080/doan/orders/in-store',
	                                    method: 'POST',
	                                    contentType: 'application/json',
	                                    xhrFields: { withCredentials: true },
	                                    data: JSON.stringify(orderData),
	                                    success: function (orderResponse) {
	                                        if (orderResponse && orderResponse.code === 1000 && orderResponse.result) {
	                                            const orderId = orderResponse.result.id; // Giả định API trả về orderId trong result
	                                            // Reset form
	                                            cartItems = [];
	                                            $tableBody.empty();
	                                            updateTotalAmount();
	                                            $('#createOrderPanel input, #createOrderPanel textarea').val('');
	                                            $('#createOrderPanel input[name="paymentMethod"]').prop('checked', false);
	                                            // Ẩn createOrderPanel và hiển thị order-confirmation
	                                            $('#createOrderPanel').addClass('d-none');
	                                            $('#order-confirmation').removeClass('d-none');

												// Gọi API để lấy chi tiết đơn hàng
												$.ajax({
												    url: `http://localhost:8080/doan/orders/${orderId}`,
												    method: 'GET',
												    xhrFields: { withCredentials: true },
												    success: function (response) {
												        console.log('Order Details API response:', response);
												        if (response && response.code === 1000 && response.result) {
												            const order = response.result;

												            // Cập nhật header
												            $('#order-confirmation .bg-dark span').text(`Đơn hàng #${order.id}`);
												            $('#order-confirmation .bg-primary p strong').text(order.username || 'Không có thông tin');

												            // Cập nhật thông tin mua hàng
												            $('#order-confirmation .card:contains("Thông tin mua hàng") .card-body')
												                .find('.fw-bold').eq(0).text(order.fullName || 'Không có thông tin');
												            $('#order-confirmation .card:contains("Thông tin mua hàng") .card-body')
												                .find('.fw-bold').eq(1).text(order.username || 'Không có thông tin');
												            $('#order-confirmation .card:contains("Thông tin mua hàng") .card-body')
												                .find('.fw-bold').eq(2).text(order.phone || 'Không có thông tin');

												            // Cập nhật phương thức thanh toán
												            $('#order-confirmation .card:contains("Phương thức thanh toán") .card-body .fw-bold')
												                .text(order.paymentMethod || 'Không có thông tin');

												            // Cập nhật địa chỉ nhận hàng
												            $('#order-confirmation .card:contains("Địa chỉ nhận hàng") .card-body')
												                .find('.fw-bold').eq(0).text(order.fullName || 'Không có thông tin');
												            $('#order-confirmation .card:contains("Địa chỉ nhận hàng") .card-body')
												                .find('.fw-bold').eq(1).text(order.address || 'Không có thông tin');
												            $('#order-confirmation .card:contains("Địa chỉ nhận hàng") .card-body')
												                .find('.fw-bold').eq(2).text(order.phone || 'Không có thông tin');

												            // Cập nhật tóm tắt đơn hàng
												            const $productContainer = $('#order-confirmation .card:contains("Tóm tắt đơn hàng") .card-body');
												            const $productList = $productContainer.find('.product-list table tbody');
												            const $templateRow = $productList.find('tr').first().clone();
												            $productList.empty();

												            let totalPrice = order.totalPrice || 0;
												            order.details.forEach((item) => {
												                const $newRow = $templateRow.clone();
												                $newRow.find('td').eq(0).text(item.productName || 'Không có thông tin');
												                $newRow.find('td').eq(1).text(item.quantity || 0);
												                $newRow.find('td').eq(2).text(`${(item.priceAtPurchase || 0).toLocaleString()}đ`);
												                $productList.append($newRow);
												            });

												            // Cập nhật tổng tiền
												            $productContainer.find('.row .text-danger').text(`${totalPrice.toLocaleString()}đ`);
												        } else {
												            alert('Không thể tải thông tin đơn hàng. Vui lòng thử lại.');
												            window.location.href = 'list-order.html';
												        }
												    },
												    error: function (xhr) {
											            console.error('Error loading order details:', xhr.responseText);
											            let message = xhr.responseJSON?.message || 'Không thể tải thông tin đơn hàng.';
											            alert(message);
											            $('#order-confirmation').addClass('d-none');
											            window.location.href = 'list-order.html';
												    }
												});
	                                        } else {
	                                            alert('Lỗi khi đặt hàng: ' + (orderResponse.message || 'Không xác định'));
	                                        }
	                                    },
	                                    error: function (xhr) {
	                                        console.error('Error creating order:', xhr.responseText);
	                                        alert('Lỗi khi đặt hàng.');
	                                    }
	                                });
	                            } else {
	                                alert('Lỗi khi lưu địa chỉ: ' + (addressResponse.message || 'Không xác định'));
	                            }
	                        },
	                        error: function (xhr) {
	                            console.error('Error saving address:', xhr.responseText);
	                            alert('Lỗi khi lưu địa chỉ.');
	                        }
	                    });
	                } else {
	                    alert('Không tìm thấy người dùng với email này.');
	                }
	            },
	            error: function (xhr) {
	                console.error('Error fetching userId:', xhr.responseText);
	                alert('Lỗi khi lấy thông tin người dùng.');
	            }
	        });
	    }
	});

	// Xử lý nút "Trở về" trong order-confirmation
	$('#order-confirmation .btn.bg-primary').on('click', function () {
	    $('#order-confirmation').addClass('d-none');
	    hidePanels();
	});

	// Xử lý click ngoài để ẩn suggestions
	$(document).on('click', function (e) {
	    if (!$(e.target).closest('#productSuggestions').length && !$(e.target).is($productInput)) {
	        $('#productSuggestions').remove();
	    }
	});
});

// Hàm kiểm tra đăng nhập
function checkLoginStatus() {
    $.ajax({
        url: 'http://localhost:8080/doan/users/myInfo',
        type: 'GET',
        xhrFields: {
            withCredentials: true
        },
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
        xhrFields: {
            withCredentials: true
        },
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

function showSearchPanel() {
    document.getElementById('orderTabsContent').classList.add('d-none');
    document.getElementById('searchOrderPanel').classList.remove('d-none');
    document.getElementById('createOrderPanel').classList.add('d-none');
    document.getElementById('orderTabs').classList.add('d-none');
}

function showCreatePanel() {
    document.getElementById('orderTabsContent').classList.add('d-none');
    document.getElementById('createOrderPanel').classList.remove('d-none');
    document.getElementById('searchOrderPanel').classList.add('d-none');
    document.getElementById('orderTabs').classList.add('d-none');
}

function hidePanels() {
    document.getElementById('orderTabsContent').classList.remove('d-none');
    document.getElementById('searchOrderPanel').classList.add('d-none');
    document.getElementById('createOrderPanel').classList.add('d-none');
    document.getElementById('orderTabs').classList.remove('d-none');
}