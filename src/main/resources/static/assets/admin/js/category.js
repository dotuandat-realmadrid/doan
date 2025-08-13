$(document).ready(function() {
    // Biến lưu trữ suppliers đã chọn
    let selectedSuppliersAdd = [];
    let selectedSuppliersEdit = [];
    let allSuppliers = [];

    // Lấy danh sách nhà cung cấp
    function loadSuppliers() {
        $.ajax({
            url: 'http://localhost:8080/doan/suppliers/code',
            type: 'GET',
            xhrFields: {
                withCredentials: true
            },
            success: function(response) {
                allSuppliers = response.result || [];
                updateSupplierDropdowns();
            },
            error: function(xhr, status, error) {
                console.error('Error loading suppliers:', status, error);
            }
        });
    }

    // Cập nhật dropdown suppliers
    function updateSupplierDropdowns() {
        updateSupplierDropdown('add', selectedSuppliersAdd);
        updateSupplierDropdown('edit', selectedSuppliersEdit);
    }

    // Cập nhật dropdown cho modal cụ thể
    function updateSupplierDropdown(type, selectedSuppliers) {
        const $select = type === 'add' ? $('#addModal .supplier-select') : $('#editModal .supplier-select');
        $select.empty();
        $select.append('<option value=""></option>');
        
        allSuppliers.forEach(supplier => {
            if (!selectedSuppliers.includes(supplier)) {
                $select.append(`<option value="${supplier}">${supplier}</option>`);
            }
        });
    }

    // Render supplier tags
    function renderSupplierTags(type, suppliers) {
        const $container = type === 'add' ? $('#addModal .supplier-container') : $('#editModal .supplier-container');
        const $select = $container.find('.supplier-select');
        
        $container.find('.supplier-tag').remove();
        
        suppliers.forEach(supplier => {
            const tag = $(`
                <span class="badge bg-primary me-1 mb-1 supplier-tag" style="font-size: 0.875rem;">
                    ${supplier}
                    <button type="button" class="btn-close btn-close-white ms-1" style="font-size: 0.75rem; width: 16px; height: 16px;" data-supplier="${supplier}"></button>
                </span>
            `);
            $select.before(tag);
        });
    }

    // Thêm supplier vào danh sách
    function addSupplier(type, supplier) {
        if (type === 'add') {
            if (!selectedSuppliersAdd.includes(supplier)) {
                selectedSuppliersAdd.push(supplier);
                renderSupplierTags('add', selectedSuppliersAdd);
                updateSupplierDropdown('add', selectedSuppliersAdd);
            }
        } else {
            if (!selectedSuppliersEdit.includes(supplier)) {
                selectedSuppliersEdit.push(supplier);
                renderSupplierTags('edit', selectedSuppliersEdit);
                updateSupplierDropdown('edit', selectedSuppliersEdit);
            }
        }
    }

    // Xóa supplier khỏi danh sách
    function removeSupplier(type, supplier) {
        if (type === 'add') {
            selectedSuppliersAdd = selectedSuppliersAdd.filter(s => s !== supplier);
            renderSupplierTags('add', selectedSuppliersAdd);
            updateSupplierDropdown('add', selectedSuppliersAdd);
        } else {
            selectedSuppliersEdit = selectedSuppliersEdit.filter(s => s !== supplier);
            renderSupplierTags('edit', selectedSuppliersEdit);
            updateSupplierDropdown('edit', selectedSuppliersEdit);
        }
    }

    // Xử lý sự kiện chọn supplier từ dropdown
    $(document).on('change', '.supplier-select', function() {
        const supplier = $(this).val();
        if (supplier) {
            const type = $(this).closest('#addModal').length ? 'add' : 'edit';
            addSupplier(type, supplier);
            $(this).val('');
        }
    });

    // Xử lý sự kiện xóa supplier tag
    $(document).on('click', '.supplier-tag .btn-close', function() {
        const supplier = $(this).data('supplier');
        const type = $(this).closest('#addModal').length ? 'add' : 'edit';
        removeSupplier(type, supplier);
    });

    // Reset suppliers khi mở modal thêm mới
    $('#addModal').on('show.bs.modal', function() {
        selectedSuppliersAdd = [];
        renderSupplierTags('add', selectedSuppliersAdd);
        updateSupplierDropdown('add', selectedSuppliersAdd);
    });

    // Click vào container để focus vào select
    $(document).on('click', '.supplier-container', function() {
        $(this).find('.supplier-select').focus();
    });

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
            if (!isNaN(page) && page >= 1 && page <= totalPages) {
                const newData = { ...originalData, page };
                loadCategories(newData);
            }
        });
    }

    // Lấy danh sách danh mục với phân trang
    function loadCategories(data = { page: 1, size: 10 }) {
        console.log('Loading categories with params:', data); // Debug
        $.ajax({
            url: 'http://localhost:8080/doan/categories/search',
            type: 'GET',
            data: {
                page: data.page,
                size: data.size
            },
            xhrFields: {
                withCredentials: true
            },
            success: function(response) {
                console.log('API response:', response); // Debug
                if (!response || !response.result || !Array.isArray(response.result.data)) {
                    console.error('Invalid API response:', response);
                    $('table tbody').empty().append('<tr><td colspan="5" class="text-center">Không tìm thấy danh mục nào.</td></tr>');
                    $('h5 span').text('0 danh mục');
                    $('.pagination').hide();
                    return;
                }

                const categories = response.result.data;
                const totalPages = response.result.totalPage || 1;
                // Không cộng 1 nếu backend trả về currentPage từ 1
                const currentPage = response.result.currentPage || 1;
                const totalElements = response.result.totalElements || 0;

                console.log('Pagination data:', { currentPage, totalPages, totalElements }); // Debug

                const $tbody = $('table tbody');
                $tbody.empty();
                if (categories.length === 0) {
                    $tbody.append('<tr><td colspan="5" class="text-center">Không tìm thấy danh mục nào.</td></tr>');
                    $('.pagination').hide();
                } else {
                    categories.forEach((category, index) => {
                        const supplierBadges = category.suppliers.map(supplier => 
                            `<span class="badge bg-primary tag-badge me-1">${supplier.name}</span>`
                        ).join(' ');
                        $tbody.append(`
                            <tr>
                                <td class="text-center">${(currentPage - 1) * data.size + index + 1}</td>
                                <td><a href="#">${category.code}</a></td>
                                <td>${category.name}</td>
                                <td>${supplierBadges}</td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-primary me-1 edit-btn" data-code="${category.code}"><i class="bi bi-pencil"></i></button>
                                    <button class="btn btn-sm btn-outline-danger delete-btn" data-code="${category.code}"><i class="bi bi-trash"></i></button>
                                </td>
                            </tr>
                        `);
                    });
                    $('.pagination').show();
                    renderPagination(currentPage, totalPages, data);
                }
                $('h5 span').text(`${totalElements} danh mục`);
            },
            error: function(xhr, status, error) {
                console.error('Error loading categories:', status, error, xhr.responseText);
                if (xhr.status === 401) {
                    if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                        localStorage.removeItem("id");
                        window.location.href = 'login.html';
                    }
                } else {
                    $('table tbody').empty().append('<tr><td colspan="5" class="text-center">Lỗi khi tải danh mục. Vui lòng thử lại.</td></tr>');
                    $('h5 span').text('0 danh mục');
                    $('.pagination').hide();
                }
            }
        });
    }

    // Thêm mới danh mục
    $('#addModal form').on('submit', function(e) {
        e.preventDefault();
        const code = $('#addModal input[placeholder="Nhập code"]').val();
        const name = $('#addModal input[placeholder="Nhập tên"]').val();
        const data = {
            code: code,
            name: name,
            supplierCodes: selectedSuppliersAdd
        };
        $.ajax({
            url: 'http://localhost:8080/doan/categories',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            xhrFields: {
                withCredentials: true
            },
            success: function(response) {
                $('#addModal').modal('hide');
                $('#addModal form')[0].reset();
                selectedSuppliersAdd = [];
                renderSupplierTags('add', selectedSuppliersAdd);
                loadCategories();
                alert('Thêm danh mục thành công!');
            },
            error: function(xhr, status, error) {
                console.error('Error adding category:', status, error);
                alert('Thêm danh mục thất bại!');
            }
        });
    });

    // Mở modal chỉnh sửa và điền dữ liệu
    $(document).on('click', '.edit-btn', function() {
        const code = $(this).data('code');
        $.ajax({
            url: `http://localhost:8080/doan/categories`,
            type: 'GET',
            xhrFields: {
                withCredentials: true
            },
            success: function(response) {
                const category = response.result.find(cat => cat.code === code);
                if (category) {
                    $('#editModal input.form-control').val(category.name);
                    selectedSuppliersEdit = category.suppliers.map(sup => sup.code);
                    renderSupplierTags('edit', selectedSuppliersEdit);
                    updateSupplierDropdown('edit', selectedSuppliersEdit);
                    $('#editModal').data('code', code).modal('show');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error fetching category:', status, error);
            }
        });
    });

    // Cập nhật danh mục
    $('#editModal form').on('submit', function(e) {
        e.preventDefault();
        const code = $('#editModal').data('code');
        const name = $('#editModal input.form-control').val();
        const data = {
            name: name,
            supplierCodes: selectedSuppliersEdit
        };
        if (confirm('Bạn có chắc chắn muốn cập nhật danh mục này?')) {
            $.ajax({
                url: `http://localhost:8080/doan/categories/${code}`,
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(data),
                xhrFields: {
                    withCredentials: true
                },
                success: function(response) {
                    $('#editModal').modal('hide');
                    loadCategories();
                    alert('Cập nhật danh mục thành công!');
                },
                error: function(xhr, status, error) {
                    console.error('Error updating category:', status, error);
                    alert('Cập nhật danh mục thất bại!');
                }
            });
        }
    });

    // Xóa danh mục
    $(document).on('click', '.delete-btn', function() {
        const code = $(this).data('code');
        if (confirm('Bạn có chắc chắn muốn xóa danh mục này?')) {
            $.ajax({
                url: `http://localhost:8080/doan/categories/${code}`,
                type: 'DELETE',
                xhrFields: {
                    withCredentials: true
                },
                success: function(response) {
                    loadCategories();
                    alert('Xóa danh mục thành công!');
                },
                error: function(xhr, status, error) {
                    console.error('Error deleting category:', status, error);
                    alert('Xóa danh mục thất bại!');
                }
            });
        }
    });

    // Khởi tạo
    loadSuppliers();
    loadCategories();
});