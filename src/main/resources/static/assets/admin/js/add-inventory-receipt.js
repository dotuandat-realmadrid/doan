$(document).ready(function() {
    // Kiểm tra trạng thái đăng nhập
    checkLoginStatus();

    // Xử lý sự kiện đăng xuất
    $('#logout').on('click', function(e) {
        e.preventDefault();
        logout();
    });

    // Xử lý sự kiện tạo phiếu nhập kho
    $('#createdBtn').on('click', function() {
        if ($(this).attr('disabled')) return; // Không làm gì nếu nút bị vô hiệu hóa
        if (confirm('Bạn có chắc chắn muốn tạo phiếu nhập kho không?')) {
            createReceipt();
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
            selectedCode = null;
        }
    });

    // Xử lý tìm kiếm sản phẩm
    $productInput.on('input', function() {
        const query = $(this).val().trim();
        if ($(this).hasClass('selected') && query !== selectedCode) {
            $(this).val(selectedCode);
            return;
        }
        if (query.length === 0 && selectedCode) {
            $(this).removeClass('selected').removeAttr('readonly');
            selectedCode = null;
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
                                selectedCode = null;
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
                alert('Không thể tìm kiếm sản phẩm.');
            }
        });
    });

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
                    inventoryReceiptItems.push({ code: product.code, productId: product.id, price: price, quantity: 1, total: total });
                    updateTotalAmount();

                    $newRow.find('.quantity').on('change', function() {
                        const qty = parseInt($(this).val()) || 1;
                        const $row = $(this).closest('tr');
                        const index = $row.index();
                        inventoryReceiptItems[index].quantity = qty;
                        inventoryReceiptItems[index].total = qty * price;
                        $row.find('.total-price').text((qty * price).toLocaleString() + 'đ');
                        updateTotalAmount();
                    });

                    $newRow.find('button').on('click', function() {
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
                $productInput.val('').removeClass('selected').removeAttr('readonly');
                selectedCode = null;
            }
        });
    }

    function createReceipt() {
        if (inventoryReceiptItems.length === 0) {
            alert('Vui lòng thêm ít nhất một sản phẩm để tạo phiếu nhập kho.');
            return;
        }

        const totalAmount = inventoryReceiptItems.reduce((sum, item) => sum + item.total, 0);
        const note = $('#noteInput').val();
        const details = inventoryReceiptItems.map(item => ({
            productCode: item.code,
            quantity: item.quantity,
            price: item.price
        }));

        const requestData = {
            totalAmount: totalAmount,
            note: note || null,
            details: details
        };

        $.ajax({
            url: 'http://localhost:8080/doan/inventory-receipts',
            method: 'POST',
            contentType: 'application/json',
            xhrFields: { withCredentials: true },
            data: JSON.stringify(requestData),
            success: function(response) {
                if (response && response.code === 1000) {
                    alert('Tạo phiếu nhập kho thành công!');
                    // Làm mới giao diện trước khi chuyển hướng
                    inventoryReceiptItems = [];
                    $tableBody.empty();
                    $('#noteInput').val('');
                    updateTotalAmount();
                    $productInput.val('').removeClass('selected').removeAttr('readonly');
                    selectedCode = null;
                    // Chuyển hướng về trang inventory-receipt.html
                    window.location.href = 'inventory-receipt.html';
                }
            },
            error: function(xhr) {
                console.error('Error creating receipt:', xhr.responseText);
                if (xhr.status === 401) {
                    if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                        localStorage.removeItem("id");
                        window.location.href = 'login.html';
                    }
                } else {
                    alert('Tạo phiếu nhập kho thất bại.');
                }
            }
        });
    }

    function updateTotalAmount() {
        const total = inventoryReceiptItems.reduce((sum, item) => sum + item.total, 0);
        $totalAmount.text(total.toLocaleString() + 'đ');
        $('.totalAmount').text(total.toLocaleString() + 'đ');
    }

    function checkLoginStatus() {
        $.ajax({
            url: 'http://localhost:8080/doan/users/myInfo',
            type: 'GET',
            xhrFields: { withCredentials: true },
            success: function(response) {
                console.log('myInfo API response:', response);
                const user = response.result;
                localStorage.setItem("id", user.id);
                $('#user-name').text(user.fullName || 'Unknown User');
                $("#full-name").text(user.fullName || 'Unknown User');
                $('#user-role').text(user.roles && user.roles.length > 0 ? user.roles.join(', ') : 'User');
            },
            error: function(xhr, status, error) {
                if (xhr.status === 401) {
                    if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                        localStorage.removeItem("id");
                        window.location.href = 'login.html';
                        return;
                    }
                } else {
                    console.error('Error checking login status:', status, error, xhr.responseText);
                    alert('Không thể kiểm tra trạng thái đăng nhập.');
                }
            }
        });
    }

    function logout() {
        $.ajax({
            url: 'http://localhost:8080/doan/auth/logout',
            type: 'POST',
            contentType: 'application/json',
            data: null,
            xhrFields: { withCredentials: true },
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
});