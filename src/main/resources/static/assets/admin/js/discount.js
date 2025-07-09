$(document).ready(function() {
    // Kiểm tra trạng thái đăng nhập
    checkLoginStatus();

    // Xử lý sự kiện đăng xuất
    $('#logout').on('click', function(e) {
        e.preventDefault();
        logout();
    });

    let currentDiscounts = [];

    // Hàm tải danh sách mã giảm giá
    function loadDiscounts() {
        $.ajax({
            url: 'http://localhost:8080/doan/discounts',
            type: 'GET',
            xhrFields: {
                withCredentials: true
            },
            success: function(response) {
                console.log('Discounts response:', response);
                currentDiscounts = response.result || [];
                renderDiscounts();
                $('h5 span').text(`${currentDiscounts.length} mã giảm giá`);
            },
            error: function(xhr, status, error) {
                console.error('Error loading discounts:', status, error);
                const $tbody = $('table tbody');
                $tbody.empty();
                $tbody.append('<tr><td colspan="6" class="text-center">Lỗi tải dữ liệu</td></tr>');
                if (xhr.status === 401) {
                    if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                        localStorage.removeItem("id");
                        window.location.href = 'login.html';
                    }
                }
            }
        });
    }

    // Hàm hiển thị danh sách mã giảm giá
    function renderDiscounts() {
        const $tbody = $('table tbody');
        $tbody.empty();
        if (currentDiscounts.length > 0) {
            currentDiscounts.forEach((discount, index) => {
                $tbody.append(`
                    <tr>
                        <td class="text-center">${index + 1}</td>
                        <td>${discount.name}</td>
                        <td>${discount.percent}%</td>
                        <td>${discount.startDate}</td>
                        <td>${discount.endDate}</td>
                        <td class="text-center">
                            <button class="btn btn-sm btn-outline-primary me-1 edit-btn" data-id="${discount.id}" data-bs-toggle="modal" data-bs-target="#editDiscountModal"><i class="bi bi-pencil"></i></button>
                            <button class="btn btn-sm btn-outline-danger delete-btn" data-id="${discount.id}"><i class="bi bi-trash"></i></button>
                        </td>
                    </tr>
                `);
            });
        } else {
            $tbody.append('<tr><td colspan="6" class="text-center">Không có dữ liệu</td></tr>');
        }
    }

    // Thêm mới mã giảm giá
    $('#addDiscountForm').on('submit', function(e) {
        e.preventDefault();
        const name = $('#discountName').val();
        const percent = $('#discountPercent').val();
        const startDate = $('#startDate').val();
        const endDate = $('#endDate').val();
        const data = {
            name: name,
            percent: parseFloat(percent),
            startDate: startDate,
            endDate: endDate
        };
        $.ajax({
            url: 'http://localhost:8080/doan/discounts',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            xhrFields: {
                withCredentials: true
            },
            success: function(response) {
                $('#addDiscountModal').modal('hide');
                $('#addDiscountForm')[0].reset();
                loadDiscounts();
                alert('Thêm mã giảm giá thành công!');
            },
            error: function(xhr, status, error) {
                console.error('Error adding discount:', status, error);
                alert('Thêm mã giảm giá thất bại! Chi tiết: ' + (xhr.responseText || error));
            }
        });
    });

    // Cập nhật mã giảm giá
    $(document).on('click', '.edit-btn', function() {
        const id = $(this).data('id');
        const discount = currentDiscounts.find(d => d.id === id);
        if (discount) {
            $('#editDiscountName').val(discount.name);
            $('#editDiscountPercent').val(discount.percent);
            $('#editStartDate').val(discount.startDate);
            $('#editEndDate').val(discount.endDate);
            $('#editDiscountModal').data('id', id).modal('show');
        }
    });

    $('#editDiscountForm').on('submit', function(e) {
        e.preventDefault();
        const id = $('#editDiscountModal').data('id');
        const name = $('#editDiscountName').val();
        const percent = $('#editDiscountPercent').val();
        const startDate = $('#editStartDate').val();
        const endDate = $('#editEndDate').val();
        const data = {
			id: id,
            name: name,
            percent: parseFloat(percent),
            startDate: startDate,
            endDate: endDate
        };
        if (confirm('Bạn có chắc chắn muốn cập nhật mã giảm giá này?')) {
            $.ajax({
                url: `http://localhost:8080/doan/discounts/${id}`,
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(data),
                xhrFields: {
                    withCredentials: true
                },
                success: function(response) {
                    $('#editDiscountModal').modal('hide');
                    loadDiscounts();
                    alert('Cập nhật mã giảm giá thành công!');
                },
                error: function(xhr, status, error) {
                    console.error('Error updating discount:', status, error);
                    alert('Cập nhật mã giảm giá thất bại! Chi tiết: ' + (xhr.responseText || error));
                }
            });
        }
    });

    // Xóa mã giảm giá
    $(document).on('click', '.delete-btn', function() {
        const id = $(this).data('id');
        if (confirm('Bạn có chắc chắn muốn xóa mã giảm giá này?')) {
            $.ajax({
                url: `http://localhost:8080/doan/discounts/${id}`,
                type: 'DELETE',
                xhrFields: {
                    withCredentials: true
                },
                success: function(response) {
                    loadDiscounts();
                    alert('Xóa mã giảm giá thành công!');
                },
                error: function(xhr, status, error) {
                    console.error('Error deleting discount:', status, error);
                    alert('Xóa mã giảm giá thất bại! Chi tiết: ' + (xhr.responseText || error));
                }
            });
        }
    });

    // Khởi tạo
    loadDiscounts();
});

// Hàm kiểm tra đăng nhập
function checkLoginStatus() {
    $.ajax({
        url: 'http://localhost:8080/doan/users/myInfo',
        type: 'GET',
        xhrFields: {
            withCredentials: true
        },
        success: function(response) {
            console.log('myInfo API response:', response);
            const user = response.result;
            localStorage.setItem("id", user.id);
            $('#user-name').text(user.fullName || 'Unknown User');
        },
        error: function(xhr, status, error) {
            if (xhr.status === 401) {
                if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                    localStorage.removeItem("id");
                    window.location.href = 'login.html';
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
        success: function(response) {
            localStorage.removeItem("id");
            console.log('Logout successful:', response);
            document.cookie = 'token=; Max-Age=0; path=/;';
            window.location.href = 'login.html';
        },
        error: function(xhr, status, error) {
            console.error('Logout error:', status, error, xhr.responseText);
            localStorage.removeItem("id");
            document.cookie = 'token=; Max-Age=0; path=/;';
            window.location.href = 'login.html';
        }
    });
}