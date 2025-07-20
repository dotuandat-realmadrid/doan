$(document).ready(function() {
    const urlParams = new URLSearchParams(window.location.search);
    const userId = urlParams.get('id'); // Lấy ID người dùng từ URL

    // Ẩn mục "Lịch sử đặt hàng" trong breadcrumb và giao diện lịch sử đặt hàng ban đầu
    $('#historyOrder').hide();
    $('#historyOrderContainer').hide(); // Ẩn container lịch sử đặt hàng
    // Vô hiệu hóa "Chi tiết tài khoản" ban đầu
    $('#detailAccount a').addClass('disabled').css('pointer-events', 'none');

    if (userId) {
        getUser(userId);
        getAddress(userId);
    } else {
        alert("Không tìm thấy thông tin người dùng.");
    }

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
    function fetchOrders(userId, status, page = 1) {
        $.ajax({
            url: `http://localhost:8080/doan/orders/user/${userId}/status/${status}`,
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
        // Xóa tất cả các mục đơn hàng, kể cả hardcode, chỉ giữ template
        $container.find('.border.rounded-3.p-3.mb-3').not('.template').remove();
        $container.find('.text-center.text-muted.py-5').remove(); // Xóa thông báo rỗng nếu có

        if (!orders || orders.length === 0) {
            $container.append(`
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

                // Thêm nút "Chi tiết" cho tất cả các trạng thái
                const $buttonContainer = $template.find('.col-md-2.text-end');
                $buttonContainer.empty();
                $buttonContainer.append(`
                    <button class="btn btn-primary btn-sm rounded-3 w-75 detail-btn"><i class="bi bi-chevron-double-right"></i> Chi tiết</button>
                `);

                $container.append($template);

                // Gắn sự kiện cho nút "Chi tiết"
                $template.find('.detail-btn').on('click', function () {
                    const orderId = $template.find('.order-id').text().trim().replace(/^#/, '');
                    window.location.href = `detail-order.html?id=${orderId}`;
                });
            });

            // Cập nhật tổng số đơn hàng
            $tabPane.find('.fw-bold').first().text(`Tổng số: ${orderData[status].count} đơn hàng`);
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
                fetchOrders(userId, status, page);
            }
        });
    }

    // Xử lý sự kiện nhấn nút "Reset mật khẩu"
    $('#resetPassword').on('click', function (e) {
        e.preventDefault();
        if (confirm('Bạn có chắc chắn muốn reset mật khẩu của người dùng này không?')) {
            $.ajax({
                url: `http://localhost:8080/doan/password/reset/${userId}`,
                method: 'PUT',
                xhrFields: { withCredentials: true },
                success: function (response) {
                    console.log('Reset password response:', response);
                    if (response && response.code === 1000) {
                        alert(response.message || 'Mật khẩu đã được reset thành "12345678"!');
                    } else {
                        alert('Reset mật khẩu thất bại: ' + (response.message || 'Lỗi không xác định'));
                    }
                },
                error: function (xhr) {
                    console.error('Error resetting password:', xhr.responseText);
                    let message = xhr.responseJSON?.message || 'Lỗi khi reset mật khẩu.';
                    alert(message);
                }
            });
        }
    });

    // Xử lý sự kiện nhấn nút "Lịch sử đặt hàng"
    $('#historyOrderModal').on('click', function (e) {
        e.preventDefault();
        console.log('Clicked historyOrderModal'); // Debug
        // Ẩn các cột chi tiết tài khoản và danh sách địa chỉ
        $('.col-lg-8').hide();
        $('#addressContainer').hide();
        // Hiển thị container lịch sử đặt hàng với col-lg-12
        $('#historyOrderContainer').show().removeClass('col-lg-4').addClass('col-lg-12');
        $('.historyOrder').show();
        // Hiển thị breadcrumb "Lịch sử đặt hàng" và kích hoạt "Chi tiết tài khoản"
        $('#historyOrder').show();
        $('#detailAccount a').removeClass('disabled').css('pointer-events', '');
        // Gọi API cho tất cả các trạng thái
        const statuses = ['PENDING', 'CANCELLED', 'CONFIRMED', 'SHIPPING', 'COMPLETED', 'FAILED'];
        statuses.forEach(status => {
            fetchOrders(userId, status, 1);
        });
    });

    // Xử lý sự kiện nhấn "Chi tiết tài khoản" trong breadcrumb
    $('#detailAccount a').on('click', function (e) {
        e.preventDefault();
        console.log('Clicked detailAccount'); // Debug
        if (!$(this).hasClass('disabled')) {
            // Hiển thị lại cột chi tiết tài khoản và danh sách địa chỉ
            $('.col-lg-8').show();
            $('#addressContainer').show();
            // Khôi phục lớp col-lg-4 cho lịch sử đặt hàng và ẩn nó
            $('#historyOrderContainer').removeClass('col-lg-12').addClass('col-lg-4').hide();
            $('.historyOrder').hide();
            // Ẩn breadcrumb "Lịch sử đặt hàng" và vô hiệu hóa "Chi tiết tài khoản"
            $('#historyOrder').hide();
            $('#detailAccount a').addClass('disabled').css('pointer-events', 'none');
        }
    });

    // Gọi API khi tab được kích hoạt
    $('#orderTabs a[data-bs-toggle="pill"]').on('shown.bs.tab', function (e) {
        const status = $(e.target).attr('id').split('-')[0].toUpperCase();
        fetchOrders(userId, status, orderData[status].currentPage);
    });

    // Các chức năng hiện có được giữ nguyên
    $(".save-btn").click(function(e) {
        e.preventDefault();
        var roles = [];
        if ($("#kho").prop('checked')) roles.push("STAFF_INVENTORY");
        if ($("#khachhang").prop('checked')) roles.push("CUSTOMER");
        if ($("#banhang").prop('checked')) roles.push("STAFF_SALE");
        if ($("#admin").prop('checked')) roles.push("ADMIN");
        if ($("#chamsoc").prop('checked')) roles.push("STAFF_CUSTOMER_SERVICE");

        const username = $("#Username").val().trim();
        const fullName = $("#FullName").val().trim();
        const phone = $("#Phone").val().trim();
        const dob = $("#Dob").val().trim() || null;
        let isGuest;
        if ($("#IsGuest").val().trim() === "Người dùng hệ thống") {
            isGuest = 0;
        } else {
            isGuest = 1;
        }

        var formData = {
            username: username,
            fullName: fullName,
            phone: phone,
            dob: dob,
            isGuest: isGuest,
            roles: roles
        };

        console.log(JSON.stringify(formData, null, 2));

        var userId = $("#Id").val().trim();
        if (!userId) {
            alert("User ID không hợp lệ!");
            return;
        }

        if (confirm('Bạn có chắc chắn muốn cập nhật tài khoản này không?')) {
            $.ajax({
                url: `http://localhost:8080/doan/users/${userId}`,
                method: 'PUT',
                credentials: 'include',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: function(response) {
                    alert("Tài khoản đã được lưu!");
                    console.log(response);
                    document.getElementById('editCard').classList.add('d-none');
                    document.getElementById('viewCard').classList.remove('d-none');
                    getUser(userId);
                },
                error: function(xhr, status, error) {
                    alert(xhr.responseText);
                    console.error(xhr, status, error);
                }
            });
        }
    });

    $(".edit-btn").click(function(e) {
        e.preventDefault();
        document.getElementById('viewCard').classList.add('d-none');
        document.getElementById('editCard').classList.remove('d-none');
    });

    $(".remove-btn").click(function(e) {
        e.preventDefault();
        document.getElementById('editCard').classList.add('d-none');
        document.getElementById('viewCard').classList.remove('d-none');
    });

    $(".btn-remove").click(function(e) {
        e.preventDefault();
        $("#addAddressForm")[0].reset();
        $("#addAddressModal").modal('hide');
    });

    $(document).on("click", ".btn-save", function(e) {
        e.preventDefault();
        const userId = $("#id").val().trim() || $("#Id").val().trim();
        const fullName = $("#addFullName").val().trim();
        const phone = $("#addPhone").val().trim();
        const ward = $("#addWard").val().trim();
        const district = $("#addDistrict").val().trim();
        const province = $("#addProvince").val().trim();
        const detail = $("#addDetail").val().trim();
        const createdDate = getLocalDateTimeNow();
        const createdBy = $("#username").val().trim() || $("#Username").val().trim();
        const modifiedDate = getLocalDateTimeNow();
        const modifiedBy = $("#username").val().trim() || $("#Username").val().trim();

        const requestData = {
            userId: userId,
            fullName: fullName,
            ward: ward,
            phone: phone,
            district: district,
            province: province,
            detail: detail,
            createdDate: createdDate,
            createdBy: createdBy,
            modifiedDate: modifiedDate,
            modifiedBy: modifiedBy
        };

        if (confirm('Bạn có chắc chắn muốn thêm địa chỉ này không?')) {
            $.ajax({
                url: `http://localhost:8080/doan/addresses`,
                type: "POST",
                credentials: 'include',
                contentType: "application/json",
                data: JSON.stringify(requestData),
                success: function(response) {
                    alert("Thêm địa chỉ thành công!");
                    $("#addAddressModal").modal('hide');
                    $('#addAddressModal input').val('');
                    getUser(userId);
                    getAddress(userId);
                    console.log(response);
                },
                error: function(xhr) {
                    console.log("Thêm thất bại: " + xhr.responseText);
                }
            });
        }
    });

    $(document).on("click", ".update-btn", function(e) {
        e.preventDefault();
        const addressId = $(this).data("address-id");
        if (!addressId) {
            alert("Không tìm thấy addressId");
            return;
        }

        $.ajax({
            url: `http://localhost:8080/doan/addresses/${addressId}`,
            method: "GET",
            success: function(response) {
                const address = response.result;
                console.log("address object:", address);
                $("#updateId").val(address.id);
                $("#updateFullName").val(address.fullName);
                $("#updatePhone").val(address.phone);
                $("#updateProvince").val(address.province);
                $("#updateDistrict").val(address.district);
                $("#updateWard").val(address.ward);
                $("#updateDetail").val(address.detail);
                $("#updateCreatedDate").val(address.createdDate || "Không có");
                $("#updateCreatedBy").val(address.createdBy || "Không có");
                $("#updateModifiedDate").val(address.modifiedDate || "Không có");
                $("#updateModifiedBy").val(address.modifiedBy || "Không có");
            },
            error: function(xhr) {
                alert("Lỗi khi lấy thông tin địa chỉ: " + xhr.responseText);
            }
        });
    });

    $(document).on("click", "#btn-save", function(e) {
        e.preventDefault();
        const id = $("#updateId").val().trim();
        const fullName = $("#updateFullName").val().trim();
        const phone = $("#updatePhone").val().trim();
        const province = $("#updateProvince").val().trim();
        const district = $("#updateDistrict").val().trim();
        const ward = $("#updateWard").val().trim();
        const detail = $("#updateDetail").val().trim();

        const requestData = {
            fullName: fullName,
            ward: ward,
            phone: phone,
            district: district,
            province: province,
            detail: detail
        };

        if (confirm('Bạn có chắc chắn muốn cập nhật địa chỉ này không?')) {
            $.ajax({
                url: `http://localhost:8080/doan/addresses/${id}`,
                type: "PUT",
                contentType: "application/json",
                data: JSON.stringify(requestData),
                success: function(response) {
                    alert("Cập nhật địa chỉ thành công!");
                    $("#updateAddressModal").modal('hide');
                    getUser(userId);
                    getAddress(userId);
                    console.log(response);
                },
                error: function(xhr) {
                    console.log("Thêm thất bại: " + xhr.responseText);
                }
            });
        }
    });

    $(document).on("click", ".delete-btn", function(e) {
        e.preventDefault();
        if (!userId) {
            alert('Không tìm thấy userId');
            return;
        }

        if (confirm('Bạn có chắc chắn muốn xóa tài khoản này không?')) {
            $.ajax({
                url: `http://localhost:8080/doan/users/${userId}`,
                type: "DELETE",
                success: function(response) {
                    alert("Bạn đã xóa tài khoản người dùng thành công!");
                    location.reload();
                },
                error: function(xhr) {
                    console.log("Lỗi xóa tài khoản người dùng: " + xhr.responseText);
                }
            });
        }
    });

    $(document).on("click", ".btn-delete", function(e) {
        e.preventDefault();
        const addressId = $(this).data("address-id");
        if (!addressId) {
            alert("Không tìm thấy addressId");
            return;
        }

        if (confirm('Bạn có chắc chắn muốn xóa địa chỉ này không?')) {
            $.ajax({
                url: `http://localhost:8080/doan/addresses/${addressId}`,
                type: "DELETE",
                success: function(response) {
                    alert("Xóa địa chỉ thành công!");
                    getUser(userId);
                    getAddress(userId);
                },
                error: function(xhr) {
                    console.log("Xóa thất bại: " + xhr.responseText);
                }
            });
        }
    });

    $("#btn-remove").click(function(e) {
        e.preventDefault();
        $("#updateAddressModal").modal('hide');
    });

    function getLocalDateTimeNow() {
        const now = new Date();
        now.setHours(now.getHours() + 7);
        return now.toISOString().slice(0, 19);
    }

    $('#addAddressModal').on('hidden.bs.modal', function() {
        $('body').focus();
    });
});

function getUser(userId) {
    $.ajax({
        url: `http://localhost:8080/doan/users/${userId}`,
        method: 'GET',
        credentials: 'include',
        success: function(response) {
            const user = response.result;
            $("#id").val(user.id);
            $("#username").val(user.username);
            $("#fullName").val(user.fullName);
            $("#phone").val(user.phone);
            $("#dob").val(user.dob || "N/A");
            $("#createdDate").val(user.createdDate || "N/A");
			$("#createdBy").val(user.createdBy || "N/A");
            $("#modifiedDate").val(user.modifiedDate || "N/A");
            $("#modifiedBy").val(user.modifiedBy);
            $(".fullName").text(user.fullName); // Cập nhật fullName trong breadcrumb
            $(".username").text(user.username);
            $("#Id").val(user.id);
            $("#Username").val(user.username);
            $("#FullName").val(user.fullName);
            $("#Phone").val(user.phone);
            $("#Dob").val(user.dob);
            user.isGuest === 0 ? $("#IsGuest").val("Người dùng hệ thống") : $("#IsGuest").val("Khách");
            if (user.roles && Array.isArray(user.roles)) {
                user.roles.forEach(function(role) {
                    $(`input.form-check-input[value='${role}']`).prop('checked', true);
                });
            }

            const roles = user.roles.map(role => {
                switch (role) {
                    case "STAFF_INVENTORY": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Nhân viên kiểm kho</a>`;
                    case "CUSTOMER": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Khách hàng</a>`;
                    case "STAFF_SALE": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Nhân viên bán hàng</a>`;
                    case "ADMIN": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Admin</a>`;
                    case "STAFF_CUSTOMER_SERVICE": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Nhân viên chăm sóc khách hàng</a>`;
                    default: return `<span class="text-muted me-1 mb-1">Không có vai trò</span>`;
                }
            }).join(' ');

            $("#roles").html(roles);

            if (user.isActive) {
                $(".isActive").html('<i class="bi bi-circle-fill text-success text-opacity-75 me-2" style="font-size: 6px;"></i> Hoạt động');
				$('#resetPassword').show(); // Hiển thị nút reset mật khẩu nếu hoạt động
            } else {
                $(".isActive").html('<i class="bi bi-circle-fill text-danger me-2" style="font-size: 6px;"></i> Đã xóa');
                $(".edit-btn").hide();
                $(".delete-btn").hide();
				$('#resetPassword').hide(); // Ẩn nút reset mật khẩu nếu là không hoạt động
            }

            if (user.isGuest) {
                $(".isGuest").html('<i class="bi bi-circle-fill text-warning mx-2" style="font-size: 6px;"></i> Khách');
                $('#resetPassword').hide(); // Ẩn nút reset mật khẩu nếu là khách
            } else {
                $(".isGuest").html('<i class="bi bi-circle-fill text-info mx-2" style="font-size: 6px;"></i> Người dùng hệ thống');
                $('#resetPassword').show(); // Hiển thị nút reset mật khẩu nếu không phải khách
            }
        },
        error: function(xhr, status, error) {
            if (xhr.status === 401) {
                alert('Bạn chưa đăng nhập');
                window.location.href = "login.html";
            } else {
                alert("Lỗi khi lấy thông tin người dùng: " + xhr.responseText);
            }
        }
    });
}

function getAddress(userId) {
    let queryParams = `userId=${userId}`;
    $.ajax({
        url: `http://localhost:8080/doan/addresses?${queryParams}`,
        method: "GET",
        success: function(response) {
            const addresses = response.result;
            let row = '';
            addresses.forEach(address => {
                row += `
                    <div class="col-12 mb-2">
                        <div class="card shadow-sm">
                            <div class="card-body d-block">
                                <div class="me-3 d-flex align-items-center">
                                    <div class="justify-content-center align-items-center mb-2 me-2">
                                        <i class="bi bi-person-circle text-primary" style="font-size: 20px;"></i>
                                    </div>
                                    <h6 class="mb-1 fw-bold d-flex align-items-center">
                                        ${address.fullName}
                                        <i class="bi bi-telephone ms-3 me-1 font_size fw-bold"></i>
                                        <span class="fw-normal">${address.phone}</span>
                                    </h6>
                                </div>
                                <div class="col-12">
                                    <p class="mb-0 d-flex align-items-start"><i class="bi bi-house-door me-1 ms-1"></i> ${address.detail}</p>
                                    <small class="d-flex align-items-start mt-1 ms-4">
                                        ${address.ward}, ${address.district}, ${address.province}
                                    </small>
                                </div>
                            </div>
                            <div class="card-footer bg-white d-flex justify-content-around">
                                <button class="btn btn-link text-decoration-none text-muted update-btn" data-bs-toggle="modal" data-bs-target="#updateAddressModal" data-address-id="${address.id}" title="Cập nhật">
                                    <i class="bi bi-pencil-square"></i>
                                </button>
                                <button class="btn btn-link text-danger text-decoration-none btn-delete" data-address-id="${address.id}" title="Xóa">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                `;
            });
            $('#address-list-container').html(row);
        },
        error: function() {
            alert('Lỗi khi tải danh sách địa chỉ!');
        }
    });
}