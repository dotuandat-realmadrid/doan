$(document).ready(function() {
    // Lấy ID phiếu nhập từ URL
    const urlParams = new URLSearchParams(window.location.search);
    const receiptId = urlParams.get('id');
    if (receiptId) {
        loadReceiptDetails(receiptId);
    } else {
        alert('Không tìm thấy ID phiếu nhập trong URL.');
    }

    // Xử lý sự kiện cập nhật phiếu
    $('#updatedBtn').on('click', function() {
        if ($(this).attr('disabled')) return;
        if (confirm('Bạn có chắc chắn muốn cập nhật phiếu nhập không?')) {
            updateReceipt(receiptId);
        }
    });

    // Xử lý sự kiện quay lại
    $('.btn-outline-secondary.btn-sm').on('click', function() {
        window.location.href = 'inventory-receipt.html';
    });

    // Biến lưu trữ danh sách sản phẩm trong phiếu nhập
    let inventoryReceiptItems = [];
    let selectedCode = null;

    const $productInput = $('#search-code');
    const $tableBody = $('#createInventoryReceiptPanel tbody');
    const $totalAmount = $('#createInventoryReceiptPanel #totalAmount');

    // Khôi phục trạng thái ban đầu khi focus vào input
    $productInput.on('focus', function() {
        if (selectedCode) {
            $(this).val('').removeClass('selected').removeAttr('readonly');
        }
    });

    // Xử lý tìm kiếm sản phẩm
    $productInput.on('input', function() {
        if ($('#statusSelect').val() !== 'PENDING') {
            $(this).prop('disabled', true);
            return;
        }
        $(this).prop('disabled', false);
        const query = $(this).val().trim();
        if ($(this).hasClass('selected') && query !== selectedCode) {
            $(this).val(selectedCode);
            return;
        }
        if (query.length === 0 && selectedCode) {
            $(this).removeClass('selected').removeAttr('readonly');
        } else if (query.length < 3) {
            $('#productSuggestions').remove();
            return;
        }
        $.ajax({
            url: 'http://localhost:8080/doan/products',
            method: 'GET',
            xhrFields: { withCredentials: true },
            data: { code: query, sortBy: 'code', direction: 'DESC' },
            success: function(response) {
                if (response && response.code === 1000 && response.result && response.result.data) {
                    const suggestions = response.result.data;
                    let $suggestions = $('#productSuggestions');
                    if ($suggestions.length) $suggestions.remove();
                    if (suggestions.length > 0) {
                        const inputOffset = $productInput.offset();
                        $suggestions = $('<div id="productSuggestions" class="list-group bg-white shadow rounded-3" style="position: absolute; z-index: 1000; width: 25%; left: ' + inputOffset.left + 'px;"></div>');
                        suggestions.forEach(product => {
                            $suggestions.append(`
                                <a href="#" class="list-group-item list-group-item-action" data-code="${product.code}">${product.code} - ${product.name}</a>
                            `);
                        });
                        $('body').append($suggestions);
                        const suggestionsHeight = $suggestions.outerHeight();
                        const topPosition = Math.max(inputOffset.top - suggestionsHeight, 0);
                        $suggestions.css('top', topPosition + 'px');
                        $suggestions.on('click', 'a', function(e) {
                            e.preventDefault();
                            selectedCode = $(this).data('code');
                            if (inventoryReceiptItems.some(item => item.code === selectedCode)) {
                                alert('Sản phẩm này đã tồn tại trong bảng!');
                                $productInput.val('').removeClass('selected').removeAttr('readonly');
                                return;
                            }
                            $productInput.val(selectedCode).addClass('selected').attr('readonly', 'readonly');
                            $suggestions.remove();
                            fetchProductDetails(selectedCode);
                        });
                    }
                }
            },
            error: function(xhr) {
                console.error('Error fetching product suggestions:', xhr.responseText);
            }
        });
    });

    // Xử lý cập nhật trạng thái với xác nhận
    $('#updateStatusBtn').on('click', function() {
        if ($(this).attr('disabled')) return;
        const newStatus = $('#statusSelect').val();
        if (confirm('Bạn có chắc chắn muốn cập nhật trạng thái không?')) {
            updateReceiptStatus(receiptId, newStatus);
        }
    });

    function loadReceiptDetails(id) {
        $.ajax({
            url: `http://localhost:8080/doan/inventory-receipts/${id}`,
            method: 'GET',
            xhrFields: { withCredentials: true },
            success: function(response) {
                if (response && response.code === 1000 && response.result) {
                    const receipt = response.result;
                    const statusText = {
                        'PENDING': 'Chờ xử lý',
                        'COMPLETED': 'Hoàn thành',
                        'CANCELED': 'Đã hủy'
                    }[receipt.status];
                    const statusClass = {
                        'PENDING': 'status-pending',
                        'COMPLETED': 'status-completed',
                        'CANCELED': 'status-canceled'
                    }[receipt.status];
                    $('#statusDisplay').text(statusText).removeClass('status-pending status-completed status-canceled').addClass(statusClass);
                    $('#statusSelect').val(receipt.status);

                    const $updateStatusBtn = $('#updateStatusBtn');
                    const $statusSelect = $('#statusSelect');
                    const $updateReceiptBtn = $('#updatedBtn');
                    const $information = $('#information');
                    const $searchInput = $('#search-code');
                    if (receipt.status === 'PENDING') {
                        $updateStatusBtn.removeClass('btn-outline-primary').addClass('btn-primary').removeAttr('disabled');
                        $statusSelect.removeAttr('disabled');
                        $updateReceiptBtn.removeClass('btn-outline-primary').addClass('btn-primary').removeAttr('disabled');
                        $information.hide();
                        $searchInput.removeAttr('disabled');
                    } else {
                        $updateStatusBtn.removeClass('btn-primary').addClass('btn-outline-primary').attr('disabled', 'disabled');
                        $statusSelect.attr('disabled', 'disabled');
                        $updateReceiptBtn.removeClass('btn-primary').addClass('btn-outline-primary').attr('disabled', 'disabled');
                        $information.show();
                        $searchInput.attr('disabled', 'disabled');
                    }

                    $('#noteInput').val(receipt.note || '');

                    const total = receipt.totalAmount.toLocaleString() + 'đ';
                    $totalAmount.text(total);
                    $('.totalAmount').text(total);

                    inventoryReceiptItems = [];
                    $tableBody.empty();
                    receipt.detailResponses.forEach(item => {
                        const total = item.quantity * item.price;
                        let manufacturedDate = '';
                        if (item.manufacturedDate) {
                            manufacturedDate = new Date(item.manufacturedDate).toISOString().split('T')[0];
                        }
                        let expiryDate = '';
                        if (item.expiryDate) {
                            expiryDate = new Date(item.expiryDate).toISOString().split('T')[0];
                        }
                        const $newRow = $(`
                            <tr>
                                <td>${item.productCode}</td>
                                <td class="text-center" style="width: 120px;">
                                    <input class="text-center rounded-2 ps-2 quantity" type="number" value="${item.quantity}" style="width: 80px; border-color: rgba(0,0,0,0.2);" min="1" ${receipt.status !== 'PENDING' ? 'disabled' : ''}>
                                </td>
                                <td class="text-end">${item.price.toLocaleString()}đ</td>
                                <td class="text-end total-price">${total.toLocaleString()}đ</td>
                                <td style="width: 160px;">
                                    <input type="date" class="form-control manufacturedDate" value="${manufacturedDate}" ${receipt.status !== 'PENDING' ? 'disabled' : ''}>
                                </td>
                                <td style="width: 160px;">
                                    <input type="date" class="form-control expiryDate" value="${expiryDate}" ${receipt.status !== 'PENDING' ? 'disabled' : ''}>
                                </td>
                                <td class="text-center"><button class="btn btn-outline-danger btn-sm" ${receipt.status !== 'PENDING' ? 'disabled' : ''}><i class="bi bi-trash"></i> Xóa</button></td>
                            </tr>
                        `);
                        $tableBody.append($newRow);
                        inventoryReceiptItems.push({
                            code: item.productCode,
                            productId: item.productId,
                            price: item.price,
                            quantity: item.quantity,
                            total: total,
                            manufacturedDate: manufacturedDate || null,
                            expiryDate: expiryDate || null
                        });

                        $newRow.find('.quantity').on('change', function() {
                            if (receipt.status !== 'PENDING') return;
                            const qty = parseInt($(this).val()) || 1;
                            const $row = $(this).closest('tr');
                            const index = $row.index();
                            inventoryReceiptItems[index].quantity = qty;
                            inventoryReceiptItems[index].total = qty * inventoryReceiptItems[index].price;
                            $row.find('.total-price').text((qty * inventoryReceiptItems[index].price).toLocaleString() + 'đ');
                            updateTotalAmount();
                        });

                        $newRow.find('.manufacturedDate').on('change', function() {
                            if (receipt.status !== 'PENDING') return;
                            const manufacturedDate = $(this).val() || null;
                            const $row = $(this).closest('tr');
                            const index = $row.index();
                            inventoryReceiptItems[index].manufacturedDate = manufacturedDate;
                        });

                        $newRow.find('.expiryDate').on('change', function() {
                            if (receipt.status !== 'PENDING') return;
                            const expiryDate = $(this).val() || null;
                            const $row = $(this).closest('tr');
                            const index = $row.index();
                            inventoryReceiptItems[index].expiryDate = expiryDate;
                        });

                        $newRow.find('button').on('click', function() {
                            if (receipt.status !== 'PENDING') return;
                            const $row = $(this).closest('tr');
                            const index = $row.index();
                            inventoryReceiptItems.splice(index, 1);
                            $row.remove();
                            updateTotalAmount();
                        });
                    });
                }
            },
            error: function(xhr) {
                console.error('Error fetching receipt details:', xhr.responseText);
                alert('Không thể tải thông tin phiếu nhập.');
            }
        });
    }

    function fetchProductDetails(code) {
        $.ajax({
            url: `http://localhost:8080/doan/products/${code}`,
            method: 'GET',
            xhrFields: { withCredentials: true },
            success: function(response) {
                if (response && response.code === 1000 && response.result) {
                    const product = response.result;
                    const price = product.discountPrice || product.price;
                    const displayPrice = product.discountPrice ? `<del>${product.price.toLocaleString()}đ</del><br>
                        <span class="text-danger">${product.discountPrice.toLocaleString()}đ</span>` : `${product.price.toLocaleString()}đ`;
                    const total = price * 1;

                    let manufacturedDate = '';
                    if (product.manufacturedDate) {
                        manufacturedDate = new Date(product.manufacturedDate).toISOString().split('T')[0];
                    }
                    let expiryDate = '';
                    if (product.expiryDate) {
                        expiryDate = new Date(product.expiryDate).toISOString().split('T')[0];
                    }

                    const $newRow = $(`
                        <tr>
                            <td>${product.code}</td>
                            <td class="text-center" style="width: 120px;">
                                <input class="rounded-2 ps-2 quantity" type="number" value="1" style="width: 80px; border-color: rgba(0,0,0,0.2);" min="1">
                            </td>
                            <td class="text-end">${displayPrice}</td>
                            <td class="text-end total-price">${total.toLocaleString()}đ</td>
                            <td style="width: 160px;">
                                <input type="date" class="form-control manufacturedDate" value="${manufacturedDate}">
                            </td>
                            <td style="width: 160px;">
                                <input type="date" class="form-control expiryDate" value="${expiryDate}">
                            </td>
                            <td class="text-center"><button class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> Xóa</button></td>
                        </tr>
                    `);
                    $tableBody.append($newRow);
                    inventoryReceiptItems.push({ 
                        code: product.code, 
                        productId: product.id, 
                        price: price, 
                        quantity: 1, 
                        total: total,
                        manufacturedDate: manufacturedDate || null,
                        expiryDate: expiryDate || null
                    });
                    updateTotalAmount();

                    $newRow.find('.quantity').on('change', function() {
                        if ($('#statusSelect').val() !== 'PENDING') return;
                        const qty = parseInt($(this).val()) || 1;
                        const $row = $(this).closest('tr');
                        const index = $row.index();
                        inventoryReceiptItems[index].quantity = qty;
                        inventoryReceiptItems[index].total = qty * price;
                        $row.find('.total-price').text((qty * price).toLocaleString() + 'đ');
                        updateTotalAmount();
                    });

                    $newRow.find('.manufacturedDate').on('change', function() {
                        if ($('#statusSelect').val() !== 'PENDING') return;
                        const manufacturedDate = $(this).val() || null;
                        const $row = $(this).closest('tr');
                        const index = $row.index();
                        inventoryReceiptItems[index].manufacturedDate = manufacturedDate;
                    });

                    $newRow.find('.expiryDate').on('change', function() {
                        if ($('#statusSelect').val() !== 'PENDING') return;
                        const expiryDate = $(this).val() || null;
                        const $row = $(this).closest('tr');
                        const index = $row.index();
                        inventoryReceiptItems[index].expiryDate = expiryDate;
                    });

                    $newRow.find('button').on('click', function() {
                        if ($('#statusSelect').val() !== 'PENDING') return;
                        const $row = $(this).closest('tr');
                        const index = $row.index();
                        inventoryReceiptItems.splice(index, 1);
                        $row.remove();
                        updateTotalAmount();
                    });
                }
            },
            error: function(xhr) {
                console.error('Error fetching product details:', xhr.responseText);
                alert('Không tìm thấy sản phẩm.');
            }
        });
    }

    function updateReceipt(id) {
        const totalAmount = inventoryReceiptItems.reduce((sum, item) => sum + item.total, 0);
        const note = $('#noteInput').val();
        const details = inventoryReceiptItems.map(item => {
            // Đảm bảo manufacturedDate và expiryDate là chuỗi yyyy-MM-dd hoặc null
            let manufacturedDate = item.manufacturedDate;
            let expiryDate = item.expiryDate;

            // Xác thực định dạng ngày (tuỳ chọn)
            if (manufacturedDate && !/^\d{4}-\d{2}-\d{2}$/.test(manufacturedDate)) {
                manufacturedDate = null; // Hoặc ném lỗi nếu ngày bắt buộc
            }
            if (expiryDate && !/^\d{4}-\d{2}-\d{2}$/.test(expiryDate)) {
                expiryDate = null; // Hoặc ném lỗi nếu ngày bắt buộc
            }

            return {
                productCode: item.code,
                quantity: item.quantity,
                price: item.price,
                manufacturedDate: manufacturedDate || null,
                expiryDate: expiryDate || null
            };
        });

        const requestData = {
            totalAmount: totalAmount,
            note: note || null,
            details: details
        };

        $.ajax({
            url: `http://localhost:8080/doan/inventory-receipts/${id}`,
            method: 'PUT',
            contentType: 'application/json',
            xhrFields: { withCredentials: true },
            data: JSON.stringify(requestData),
            success: function(response) {
                if (response && response.code === 1000) {
                    alert('Cập nhật phiếu nhập thành công!');
                    loadReceiptDetails(id);
                }
            },
            error: function(xhr) {
                console.error('Error updating receipt:', xhr.responseText);
                if (xhr.status === 401) {
                    if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                        localStorage.removeItem("id");
                        window.location.href = 'login.html';
                    }
                } else {
                    alert('Cập nhật phiếu nhập thất bại.');
                }
            }
        });
    }

    function updateReceiptStatus(id, status) {
        $.ajax({
            url: `http://localhost:8080/doan/inventory-receipts/${id}/status`,
            method: 'PATCH',
            contentType: 'application/json',
            xhrFields: { withCredentials: true },
            data: JSON.stringify({ status: status }),
            success: function(response) {
                if (response && response.code === 1000) {
                    const statusText = {
                        'PENDING': 'Chờ xử lý',
                        'COMPLETED': 'Hoàn thành',
                        'CANCELED': 'Đã hủy'
                    }[status];
                    const statusClass = {
                        'PENDING': 'status-pending',
                        'COMPLETED': 'status-completed',
                        'CANCELED': 'status-canceled'
                    }[status];
                    $('#statusDisplay').text(statusText).removeClass('status-pending status-completed status-canceled').addClass(statusClass);
                    const $updateStatusBtn = $('#updateStatusBtn');
                    const $statusSelect = $('#statusSelect');
                    const $updateReceiptBtn = $('#updatedBtn');
                    const $information = $('#information');
                    const $searchInput = $('#search-code');
                    if (status === 'PENDING') {
                        $updateStatusBtn.removeClass('btn-outline-primary').addClass('btn-primary').removeAttr('disabled');
                        $statusSelect.removeAttr('disabled');
                        $updateReceiptBtn.removeClass('btn-outline-primary').addClass('btn-primary').removeAttr('disabled');
                        $information.hide();
                        $searchInput.removeAttr('disabled');
                    } else {
                        $updateStatusBtn.removeClass('btn-primary').addClass('btn-outline-primary').attr('disabled', 'disabled');
                        $statusSelect.attr('disabled', 'disabled');
                        $updateReceiptBtn.removeClass('btn-primary').addClass('btn-outline-primary').attr('disabled', 'disabled');
                        $information.show();
                        $searchInput.attr('disabled', 'disabled');
                    }
                    alert('Cập nhật trạng thái thành công!');
                }
            },
            error: function(xhr) {
                console.error('Error updating status:', xhr.responseText);
                if (xhr.status === 401) {
                    if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                        localStorage.removeItem("id");
                        window.location.href = 'login.html';
                    }
                } else {
                    alert('Cập nhật trạng thái thất bại.');
                }
            }
        });
    }

    function updateTotalAmount() {
        const total = inventoryReceiptItems.reduce((sum, item) => sum + item.total, 0);
        $totalAmount.text(total.toLocaleString() + 'đ');
        $('.totalAmount').text(total.toLocaleString() + 'đ');
    }
});