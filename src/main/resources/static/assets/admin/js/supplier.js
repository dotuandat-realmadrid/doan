$(document).ready(function() {
    // Kiểm tra trạng thái đăng nhập
    checkLoginStatus();

    // Xử lý sự kiện đăng xuất
    $('#logout').on('click', function(e) {
        e.preventDefault();
        logout();
    });

    let currentSuppliers = [];

    // Hàm tải danh sách nhà cung cấp
    function loadSuppliers() {
        $.ajax({
            url: 'http://localhost:8080/doan/suppliers',
            type: 'GET',
            xhrFields: {
                withCredentials: true
            },
            success: function(response) {
                console.log('Suppliers response:', response);
                currentSuppliers = response.result || [];
                renderSuppliers();
                $('h5 span').text(`${currentSuppliers.length} nhà cung cấp`);
            },
            error: function(xhr, status, error) {
                console.error('Error loading suppliers:', status, error);
                const $tbody = $('table tbody');
                $tbody.empty();
                $tbody.append('<tr><td colspan="4" class="text-center">Lỗi tải dữ liệu</td></tr>');
                if (xhr.status === 401) {
                    if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                        localStorage.removeItem("id");
                        window.location.href = 'login.html';
                    }
                }
            }
        });
    }

    // Hàm hiển thị danh sách nhà cung cấp
    function renderSuppliers() {
        const $tbody = $('table tbody');
        $tbody.empty();
        if (currentSuppliers.length > 0) {
            currentSuppliers.forEach((supplier, index) => {
                $tbody.append(`
                    <tr>
                        <td class="text-center">${index + 1}</td>
                        <td><a href="#">${supplier.code}</a></td>
                        <td>${supplier.name}</td>
                        <td class="text-center">
                            <button class="btn btn-sm btn-outline-primary me-1 edit-btn" data-code="${supplier.code}" data-bs-toggle="modal" data-bs-target="#editSupplierModal"><i class="bi bi-pencil"></i></button>
                            <button class="btn btn-sm btn-outline-danger delete-btn" data-code="${supplier.code}"><i class="bi bi-trash"></i></button>
                        </td>
                    </tr>
                `);
            });
        } else {
            $tbody.append('<tr><td colspan="4" class="text-center">Không có dữ liệu</td></tr>');
        }
    }

    // Thêm mới nhà cung cấp
    $('#addSupplierModal form').on('submit', function(e) {
        e.preventDefault();
        const code = $('#addSupplierModal input[placeholder="Nhập code"]').val();
        const name = $('#addSupplierModal input[placeholder="Nhập tên"]').val();
        const data = {
            code: code,
            name: name
        };
        $.ajax({
            url: 'http://localhost:8080/doan/suppliers',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            xhrFields: {
                withCredentials: true
            },
            success: function(response) {
                $('#addSupplierModal').modal('hide');
                $('#addSupplierModal form')[0].reset();
                loadSuppliers();
                alert('Thêm nhà cung cấp thành công!');
            },
            error: function(xhr, status, error) {
                console.error('Error adding supplier:', status, error);
                alert('Thêm nhà cung cấp thất bại!');
            }
        });
    });

    // Cập nhật nhà cung cấp
    $(document).on('click', '.edit-btn', function() {
        const code = $(this).data('code');
        const supplier = currentSuppliers.find(s => s.code === code);
        if (supplier) {
            $('#editSupplierModal input.form-control').val(supplier.name);
            $('#editSupplierModal').data('code', code).modal('show');
        }
    });

    $('#editSupplierModal form').on('submit', function(e) {
        e.preventDefault();
        const code = $('#editSupplierModal').data('code');
        const name = $('#editSupplierModal input.form-control').val();
        const data = {
            name: name
        };
        if (confirm('Bạn có chắc chắn muốn cập nhật nhà cung cấp này?')) {
            $.ajax({
                url: `http://localhost:8080/doan/suppliers/${code}`,
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(data),
                xhrFields: {
                    withCredentials: true
                },
                success: function(response) {
                    $('#editSupplierModal').modal('hide');
                    loadSuppliers();
                    alert('Cập nhật nhà cung cấp thành công!');
                },
                error: function(xhr, status, error) {
                    console.error('Error updating supplier:', status, error);
                    alert('Cập nhật nhà cung cấp thất bại!');
                }
            });
        }
    });

    // Xóa nhà cung cấp
    $(document).on('click', '.delete-btn', function() {
        const code = $(this).data('code');
        if (confirm('Bạn có chắc chắn muốn xóa nhà cung cấp này?')) {
            $.ajax({
                url: `http://localhost:8080/doan/suppliers/${code}`,
                type: 'DELETE',
                xhrFields: {
                    withCredentials: true
                },
                success: function(response) {
                    loadSuppliers();
                    alert('Xóa nhà cung cấp thành công!');
                },
                error: function(xhr, status, error) {
                    console.error('Error deleting supplier:', status, error);
                    alert('Xóa nhà cung cấp thất bại!');
                }
            });
        }
    });

    // Khởi tạo
    loadSuppliers();
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