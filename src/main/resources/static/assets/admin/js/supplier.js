$(document).ready(function() {

    let currentSuppliers = [];

    // Hàm phân trang
    function renderPagination(currentPage, totalPages, originalData) {
        console.log('Rendering pagination:', { currentPage, totalPages, originalData }); // Debug
        const paginationContainer = $('.pagination');
        paginationContainer.empty();

        const prevClass = currentPage === 1 ? "disabled" : "";
        paginationContainer.append(`
            <li class="page-item ${prevClass}">
                <a class="page-link" href="#" data-page="${currentPage - 1}">«</a>
            </li>
        `);

        const addPageItem = (i, isActive = false) => {
            const activeClass = isActive ? "active" : "";
            paginationContainer.append(`
                <li class="page-item ${activeClass}">
                    <a class="page-link" href="#" data-page="${i}">${i}</a>
                </li>
            `);
        };

        const addEllipsis = () => {
            paginationContainer.append(`
                <li class="page-item disabled">
                    <a class="page-link" href="#">...</a>
                </li>
            `);
        };

        if (totalPages <= 6) {
            for (let i = 1; i <= totalPages; i++) {
                addPageItem(i, i === currentPage);
            }
        } else {
            if (currentPage <= 3) {
                for (let i = 1; i <= 3; i++) addPageItem(i, i === currentPage);
                addEllipsis();
                for (let i = totalPages - 2; i <= totalPages; i++) addPageItem(i, i === currentPage);
            } else if (currentPage >= totalPages - 2) {
                for (let i = 1; i <= 3; i++) addPageItem(i, i === currentPage);
                addEllipsis();
                for (let i = totalPages - 2; i <= totalPages; i++) addPageItem(i, i === currentPage);
            } else {
                addPageItem(1);
                addEllipsis();
                for (let i = currentPage - 1; i <= currentPage + 1; i++) addPageItem(i, i === currentPage);
                addEllipsis();
                addPageItem(totalPages);
            }
        }

        const nextClass = currentPage === totalPages ? "disabled" : "";
        paginationContainer.append(`
            <li class="page-item ${nextClass}">
                <a class="page-link" href="#" data-page="${currentPage + 1}">»</a>
            </li>
        `);

        // Gắn sự kiện click cho các nút phân trang
        paginationContainer.find('.page-link').off('click').on('click', function(e) {
            e.preventDefault();
            const page = parseInt($(this).data('page'));
            console.log('Clicked page:', page); // Debug
            if (!isNaN(page) && page >= 1 && page <= totalPages && page !== currentPage) {
                const newData = { ...originalData, page };
                loadSuppliers(newData);
            }
        });
    }

    // Hàm tải danh sách nhà cung cấp với phân trang
    function loadSuppliers(data = { page: 1, size: 10 }) {
        console.log('Loading suppliers with params:', { page: data.page, size: data.size }); // Debug
        $.ajax({
            url: 'http://localhost:8080/doan/suppliers/search',
            type: 'GET',
            data: {
                page: data.page, // Gửi page từ 1, backend sẽ trừ 1
                size: data.size
            },
            xhrFields: {
                withCredentials: true
            },
            success: function(response) {
                console.log('Suppliers API response:', response); // Debug
                if (!response || !response.result || !Array.isArray(response.result.data)) {
                    console.error('Invalid API response:', response);
                    const $tbody = $('table tbody');
                    $tbody.empty().append('<tr><td colspan="4" class="text-center">Không tìm thấy nhà cung cấp nào.</td></tr>');
                    $('h5 span').text('0 nhà cung cấp');
                    $('.pagination').hide();
                    return;
                }

                currentSuppliers = response.result.data || [];
                const totalPages = response.result.totalPage || 1;
                const currentPage = response.result.currentPage || 1; // Backend trả về từ 0, nhưng hiển thị từ 1
                const totalElements = response.result.totalElements || 0;

                console.log('Pagination data:', { currentPage, totalPages, totalElements }); // Debug

                const $tbody = $('table tbody');
                $tbody.empty();
                if (currentSuppliers.length === 0) {
                    $tbody.append('<tr><td colspan="4" class="text-center">Không tìm thấy nhà cung cấp nào.</td></tr>');
                    $('.pagination').hide();
                } else {
                    currentSuppliers.forEach((supplier, index) => {
                        $tbody.append(`
                            <tr>
                                <td class="text-center">${(currentPage - 1) * data.size + index + 1}</td>
                                <td><a href="#">${supplier.code}</a></td>
                                <td>${supplier.name}</td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-primary me-1 edit-btn" data-code="${supplier.code}" data-bs-toggle="modal" data-bs-target="#editSupplierModal"><i class="bi bi-pencil"></i></button>
                                    <button class="btn btn-sm btn-outline-danger delete-btn" data-code="${supplier.code}"><i class="bi bi-trash"></i></button>
                                </td>
                            </tr>
                        `);
                    });
                    $('.pagination').show();
                    renderPagination(currentPage, totalPages, data);
                }
                $('h5 span').text(`${totalElements} nhà cung cấp`);
            },
            error: function(xhr, status, error) {
                console.error('Error loading suppliers:', status, error, xhr.responseText);
                const $tbody = $('table tbody');
                $tbody.empty().append('<tr><td colspan="4" class="text-center">Lỗi tải dữ liệu</td></tr>');
                $('h5 span').text('0 nhà cung cấp');
                $('.pagination').hide();
                if (xhr.status === 401) {
                    if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                        localStorage.removeItem("id");
                        window.location.href = 'login.html';
                    }
                }
            }
        });
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