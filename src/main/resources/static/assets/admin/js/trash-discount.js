$(document).ready(function() {
    let currentDiscounts = [];
    let intervalId = null;

    // Hàm tải danh sách mã giảm giá trong thùng rác
    function loadDiscounts() {
        $.ajax({
            url: 'http://localhost:8080/doan/discounts/trash',
            type: 'GET',
            xhrFields: { withCredentials: true },
            success: function(response) {
                console.log('Discounts trash response:', response);
                if (response.code === 1000) {
                    currentDiscounts = response.result || [];
                    renderDiscounts();
                    $('h5 span').text(`${currentDiscounts.length} mã giảm giá`);
                } else if (response.code === 1012) {
                    if (confirm('Bạn cần đăng nhập để xem danh sách mã giảm giá. Bạn có muốn đăng nhập ngay không?')) {
                        localStorage.removeItem("id");
                        window.location.href = 'login.html';
                    }
                } else {
                    alert('Có lỗi xảy ra khi tải mã giảm giá!');
                }
            },
            error: function(xhr) {
                console.error('Error loading discounts:', xhr.status, xhr.responseText);
                const $tbody = $('table tbody');
                $tbody.empty();
                $tbody.append('<tr><td colspan="8" class="text-center">Lỗi tải dữ liệu</td></tr>');
                if (xhr.status === 401) {
                    if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                        localStorage.removeItem("id");
                        window.location.href = 'login.html';
                    }
                } else if (xhr.status === 403) {
                    alert('Bạn không có quyền!');
                    window.location.href = 'home.html';
                } else {
                    alert('Lỗi: ' + (xhr.responseJSON?.message || 'Không thể tải danh sách mã giảm giá.'));
                }
            }
        });
    }

    // Hàm hiển thị danh sách mã giảm giá
    function renderDiscounts() {
        const $tbody = $('table tbody');
        $tbody.empty();
        $('h5 span').text('0 mã giảm giá');

        if (currentDiscounts.length > 0) {
            $('h5 span').text(`${currentDiscounts.length} mã giảm giá`);
            currentDiscounts.forEach((item, index) => {
                if (!item.id || !item.discount || !item.discount.id) {
                    console.warn(`Dữ liệu mã giảm giá không hợp lệ tại index ${index}:`, item);
                    return;
                }

                const deletedDate = item.deletedDate || '';
                const initialRemainingTime = item.remainingTime || 'Hết hạn';

                const row = `
                    <tr data-discount-id="${item.discount.id}">
                        <td class="text-center"><input type="checkbox" class="discount-checkbox"></td>
                        <td class="text-center">${index + 1}</td>
                        <td>${item.discount.name || 'Không có tên'}</td>
                        <td>${item.discount.percent || 0}%</td>
                        <td>${item.discount.startDate || 'N/A'}</td>
                        <td>${item.discount.endDate || 'N/A'}</td>
                        <td class="text-center">
                            <span class="btn btn-sm btn-secondary remaining-time" data-deleted-date="${deletedDate}">${initialRemainingTime}</span>
                        </td>
                        <td class="text-center">
                            <button class="btn btn-sm btn-outline-success border-0 restore-discount" data-discount-id="${item.discount.id}" title="Khôi phục">
                                <i class="bi bi-arrow-counterclockwise"></i>
                            </button>
                        </td>
                    </tr>
                `;
                $tbody.append(row);
            });

            // Xử lý sự kiện khôi phục cho từng mã giảm giá
            $('.restore-discount').on('click', function() {
                const discountId = $(this).data('discount-id');
                if (!discountId || discountId === 'undefined') {
                    alert('Không tìm thấy ID mã giảm giá!');
                    return;
                }
                if (confirm('Bạn có chắc chắn muốn khôi phục mã giảm giá này?')) {
                    $.ajax({
                        url: `http://localhost:8080/doan/discounts/restore/${discountId}`,
                        type: 'PUT',
                        xhrFields: { withCredentials: true },
                        success: function() {
                            alert('Khôi phục mã giảm giá thành công!');
                            loadDiscounts();
                        },
                        error: function(xhr) {
                            const errorMsg = xhr.responseJSON?.message || xhr.responseText || 'Lỗi không xác định';
                            if (xhr.responseJSON?.code === 'NO_RESTORABLE') {
                                alert('Mã giảm giá đã hết hạn khôi phục (quá 60 ngày).');
                            } else {
                                alert(`Lỗi khi khôi phục mã giảm giá: ${errorMsg}`);
                            }
                        }
                    });
                }
            });

            // Cập nhật thời gian còn lại ngay sau khi render
            updateRemainingTime();
        } else {
            $tbody.append('<tr><td colspan="8" class="text-center">Không có dữ liệu mã giảm giá</td></tr>');
        }
    }

    // Xử lý checkbox "Chọn tất cả"
    $('#selectAll').on('change', function() {
        const isChecked = $(this).is(':checked');
        $('table tbody input[type="checkbox"]').prop('checked', isChecked);
        toggleRestoreButton();
    });

    // Xử lý checkbox riêng lẻ
    $('table tbody').on('change', 'input[type="checkbox"]', function() {
        toggleRestoreButton();
        const allChecked = $('table tbody input[type="checkbox"]').length ===
            $('table tbody input[type="checkbox"]:checked').length;
        $('#selectAll').prop('checked', allChecked);
    });

    // Xử lý nút khôi phục nhiều mã giảm giá
    $('#restoreSelected').on('click', function() {
        if (confirm('Bạn có chắc chắn muốn khôi phục các mã giảm giá đã chọn?')) {
            restoreSelectedDiscounts();
        }
    });

    // Hàm hiển thị/ẩn nút khôi phục và cập nhật văn bản
    function toggleRestoreButton() {
        const checkedCount = $('table tbody input[type="checkbox"]:checked').length;
        $('#restoreSelected').toggle(checkedCount > 0);
        $('#restoreSelected').text(`Khôi phục ${checkedCount} mã giảm giá`);
    }

    // Hàm khôi phục nhiều mã giảm giá
    function restoreSelectedDiscounts() {
        const selectedIds = [];
        $('table tbody input[type="checkbox"]:checked').each(function() {
            const row = $(this).closest('tr');
            const discountId = row.data('discount-id');
            if (discountId && discountId !== 'undefined') {
                selectedIds.push(discountId);
            }
        });

        if (selectedIds.length === 0) {
            alert('Vui lòng chọn ít nhất một mã giảm giá hợp lệ để khôi phục!');
            return;
        }

        $.ajax({
            url: `http://localhost:8080/doan/discounts/restore/${selectedIds.join(',')}`,
            type: 'PUT',
            xhrFields: { withCredentials: true },
            success: function() {
                alert('Khôi phục mã giảm giá thành công!');
                $('#selectAll').prop('checked', false);
                $('table tbody input[type="checkbox"]').prop('checked', false);
                toggleRestoreButton();
                loadDiscounts();
            },
            error: function(xhr) {
                const errorMsg = xhr.responseJSON?.message || xhr.responseText || 'Lỗi không xác định';
                if (xhr.responseJSON?.code === 'NO_RESTORABLE') {
                    alert('Một hoặc nhiều mã giảm giá đã hết hạn khôi phục (quá 60 ngày).');
                } else {
                    alert(`Lỗi khi khôi phục mã giảm giá: ${errorMsg}`);
                }
            }
        });
    }

    // Hàm cập nhật thời gian còn lại
    function updateRemainingTime() {
        const vietnamTime = moment().tz("Asia/Ho_Chi_Minh");
        // console.log("Updating time at:", vietnamTime.format("YYYY-MM-DD HH:mm:ss Z"));

        $('.remaining-time').each(function() {
            const deletedDateStr = $(this).data('deleted-date');
            let buttonClass = 'btn-secondary';
            let remainingTimeText = 'Hết hạn';

            if (deletedDateStr) {
                const deletedDate = moment.tz(deletedDateStr, 'Asia/Ho_Chi_Minh');
                if (!deletedDate.isValid()) {
                    // console.warn(`Định dạng deletedDate không hợp lệ: ${deletedDateStr}`);
                } else {
                    const expiryDate = deletedDate.clone().add(60, 'days');
                    const totalMinutes = Math.max(0, Math.floor(vietnamTime.diff(expiryDate, 'minutes') * -1));

                    // console.log(`Discount ${$(this).closest('tr').data('discount-id')}: deletedDate=${deletedDate.format('YYYY-MM-DD HH:mm:ss Z')}, expiryDate=${expiryDate.format('YYYY-MM-DD HH:mm:ss Z')}, totalMinutes=${totalMinutes}`);

                    if (totalMinutes > 0) {
                        const days = Math.floor(totalMinutes / (24 * 60));
                        const hours = Math.floor((totalMinutes % (24 * 60)) / 60);
                        const minutes = totalMinutes % 60;
                        remainingTimeText = `${days} ngày ${hours} giờ ${minutes} phút`;

                        const threshold20Days = 20 * 24 * 60;
                        const threshold40Days = 40 * 24 * 60;
                        if (totalMinutes <= threshold20Days) {
                            buttonClass = 'btn-danger';
                        } else if (totalMinutes <= threshold40Days) {
                            buttonClass = 'btn-warning';
                        } else {
                            buttonClass = 'btn-success';
                        }
                    }
                }
            }

            $(this).text(remainingTimeText).removeClass('btn-danger btn-warning btn-success btn-secondary').addClass(buttonClass);
        });
    }

    // Hàm bắt đầu interval để cập nhật thời gian
    function startInterval() {
        if (intervalId !== null) {
            clearInterval(intervalId);
            console.log('Cleared previous interval');
        }
        intervalId = setInterval(() => {
            updateRemainingTime();
            // console.log('Interval triggered');
        }, 60 * 1000);
    }

    // Xử lý visibility change để dừng/bắt đầu interval
    document.addEventListener('visibilitychange', () => {
        if (document.visibilityState === 'hidden') {
            clearInterval(intervalId);
            intervalId = null;
            console.log('Interval stopped: tab hidden');
        } else {
            startInterval();
            updateRemainingTime(); // Cập nhật ngay khi tab hiển thị
            // console.log('Interval restarted: tab visible');
        }
    });

    // Dừng interval khi rời trang
    $(window).on('beforeunload', () => {
        clearInterval(intervalId);
        intervalId = null;
        // console.log('Interval stopped on beforeunload');
    });

    // Khởi tạo
    loadDiscounts();
    startInterval();
});