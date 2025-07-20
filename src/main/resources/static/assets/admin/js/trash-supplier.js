$(document).ready(function() {
	// Khai báo biến toàn cục
	let currentPage = 1;
	let pageSize = 5;
	let intervalId = null;

	// Tải nhà cung cấp khi trang tải
	fetchSuppliers(currentPage, pageSize);

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

	// Xử lý nút khôi phục nhiều nhà cung cấp
	$('#restoreSelected').text('Khôi phục 0 nhà cung cấp').on('click', function() {
		if (confirm('Bạn có chắc chắn muốn khôi phục các nhà cung cấp đã chọn?')) {
			restoreSelectedSuppliers();
		}
	});

	// Hàm hiển thị/ẩn nút khôi phục và cập nhật văn bản
	function toggleRestoreButton() {
		const checkedCount = $('table tbody input[type="checkbox"]:checked').length;
		$('#restoreSelected').toggle(checkedCount > 0);
		$('#restoreSelected').text(`Khôi phục ${checkedCount} nhà cung cấp`);
	}

	// Hàm khôi phục nhiều nhà cung cấp
	function restoreSelectedSuppliers() {
		const selectedIds = [];
		$('table tbody input[type="checkbox"]:checked').each(function() {
			const row = $(this).closest('tr');
			const trashBinId = row.data('trashbin-id');
			if (trashBinId && trashBinId !== 'undefined') {
				selectedIds.push(trashBinId);
			}
		});

		if (selectedIds.length === 0) {
			alert('Vui lòng chọn ít nhất một nhà cung cấp hợp lệ để khôi phục!');
			return;
		}

		$.ajax({
			url: `http://localhost:8080/doan/suppliers/restore/${selectedIds.join(',')}`,
			method: 'PUT',
			xhrFields: { withCredentials: true },
			success: function() {
				alert('Khôi phục nhà cung cấp thành công!');
				$('#selectAll').prop('checked', false);
				$('table tbody input[type="checkbox"]').prop('checked', false);
				toggleRestoreButton();
				fetchSuppliers(currentPage, pageSize);
				location.reload();
			},
			error: function(xhr) {
				const errorMsg = xhr.responseJSON?.message || xhr.responseText || 'Lỗi không xác định';
				if (xhr.responseJSON?.code === 'NO_RESTORABLE') {
					alert('Một hoặc nhiều nhà cung cấp đã hết hạn khôi phục (quá 60 ngày).');
				} else {
					alert(`Lỗi khi khôi phục nhà cung cấp: ${errorMsg}`);
				}
			}
		});
	}

	// Hàm render danh sách nhà cung cấp
	function renderTable(suppliers) {
		$('table tbody').empty();
		$('h5 span').text('0 nhà cung cấp');

		if (suppliers && suppliers.length > 0) {
			const totalItems = suppliers.length;
			$('h5 span').text(`${totalItems} nhà cung cấp`);

			suppliers.forEach((item, index) => {
				// Kiểm tra dữ liệu trước khi render
				if (!item.id || !item.supplier) {
					console.warn(`Dữ liệu nhà cung cấp không hợp lệ tại index ${index}:`, item);
					return;
				}

				const deletedDate = item.deletedDate || '';

				const row = `
                    <tr data-trashbin-id="${item.id}">
                        <td class="text-center"><input type="checkbox" class="supplier-checkbox"></td>
                        <th class="text-center" scope="row">${(currentPage - 1) * pageSize + index + 1}</th>
                        <td>${item.supplier.code || 'Không có mã'}</td>
                        <td>${item.supplier.name || 'Không có tên'}</td>
                        <td class="text-center">
                            <span class="btn btn-sm btn-secondary remaining-time" data-deleted-date="${deletedDate}"></span>
                        </td>
                        <td class="text-center">
                            <button class="btn btn-sm btn-outline-success border-0 restore-supplier" data-trashbin-id="${item.id}" title="Khôi phục">
                                <i class="bi bi-arrow-counterclockwise"></i>
                            </button>
                        </td>
                    </tr>
                `;
				$('table tbody').append(row);
			});

			// Xử lý sự kiện khôi phục cho từng nhà cung cấp
			$('.restore-supplier').on('click', function() {
				const trashBinId = $(this).data('trashbin-id');
				if (!trashBinId || trashBinId === 'undefined') {
					alert('Không tìm thấy ID nhà cung cấp trong thùng rác!');
					return;
				}
				if (confirm('Bạn có chắc chắn muốn khôi phục nhà cung cấp này?')) {
					$.ajax({
						url: `http://localhost:8080/doan/suppliers/restore/${trashBinId}`,
						method: 'PUT',
						xhrFields: { withCredentials: true },
						success: function() {
							alert('Khôi phục nhà cung cấp thành công!');
							fetchSuppliers(currentPage, pageSize);
						},
						error: function(xhr) {
							const errorMsg = xhr.responseJSON?.message || xhr.responseText || 'Lỗi không xác định';
							if (xhr.responseJSON?.code === 'NO_RESTORABLE') {
								alert('Nhà cung cấp đã hết hạn khôi phục (quá 60 ngày).');
							} else {
								alert(`Lỗi khi khôi phục nhà cung cấp: ${errorMsg}`);
							}
						}
					});
				}
			});

			// Cập nhật thời gian còn lại ngay sau khi render
			updateRemainingTime();
		} else {
			$('table tbody').html('<tr><td colspan="6" class="text-center">Không có dữ liệu nhà cung cấp</td></tr>');
		}
	}

	// Hàm cập nhật thời gian còn lại
	function updateRemainingTime() {
		const vietnamTime = moment().tz("Asia/Ho_Chi_Minh");
		console.log("Updating time at:", vietnamTime.format("YYYY-MM-DD HH:mm:ss Z"));

		$('.remaining-time').each(function() {
			const deletedDateStr = $(this).data('deleted-date');
			let buttonClass = 'btn-secondary';
			let remainingTimeText = 'Hết hạn';

			if (deletedDateStr) {
				const deletedDate = moment.tz(deletedDateStr, 'Asia/Ho_Chi_Minh');
				if (!deletedDate.isValid()) {
					console.warn(`Định dạng deletedDate không hợp lệ: ${deletedDateStr}`);
				} else {
					const expiryDate = deletedDate.clone().add(60, 'days');
					const totalMinutes = Math.max(0, Math.floor(vietnamTime.diff(expiryDate, 'minutes') * -1));

					console.log(`Supplier ${$(this).closest('tr').data('trashbin-id')}: deletedDate=${deletedDate.format('YYYY-MM-DD HH:mm:ss Z')}, expiryDate=${expiryDate.format('YYYY-MM-DD HH:mm:ss Z')}, totalMinutes=${totalMinutes}`);

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
			console.log('Interval triggered');
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
			console.log('Interval restarted: tab visible');
		}
	});

	// Dừng interval khi rời trang
	$(window).on('beforeunload', () => {
		clearInterval(intervalId);
		intervalId = null;
		console.log('Interval stopped on beforeunload');
	});

	// Khởi động interval
	updateRemainingTime();
	startInterval();

	// Hàm tải nhà cung cấp
	function fetchSuppliers(page, size) {
		$.ajax({
			url: `http://localhost:8080/doan/suppliers/trash?page=${page}&size=${size}`,
			method: 'GET',
			xhrFields: { withCredentials: true },
			success: function(response) {
				console.log('API response:', response); // Debug cấu trúc dữ liệu
				if (response.code === 1000) {
					const suppliers = response.result.data || [];
					const totalPages = response.result.totalPage || 1;
					const current = response.result.currentPage || 1;
					const totalElements = response.result.totalElements || 0;

					renderTable(suppliers);
					renderPagination(current, totalPages);
					$('h5 span').text(`${totalElements} nhà cung cấp`);
				} else if (response.code === 1012) {
					if (confirm('Bạn cần đăng nhập để xem danh sách nhà cung cấp. Bạn có muốn đăng nhập ngay không?')) {
						window.location.href = 'login.html';
					}
				} else {
					alert('Có lỗi xảy ra khi tải nhà cung cấp!');
				}
			},
			error: function(xhr) {
				if (xhr.status === 401) {
					alert('Bạn chưa đăng nhập!');
					window.location.href = 'login.html';
				} else if (xhr.status === 403) {
					alert('Bạn không có quyền!');
					window.location.href = 'home.html';
				} else {
					alert('Lỗi: ' + (xhr.responseJSON?.message || 'Không thể tải danh sách nhà cung cấp.'));
				}
			}
		});
	}

	// Hàm render phân trang
	function renderPagination(current, totalPages) {
		const pagination = $('.pagination');
		pagination.empty();

		const prevClass = current === 1 ? 'disabled' : '';
		pagination.append(`
            <li class="page-item ${prevClass}">
                <a class="page-link" href="#" data-page="${current - 1}">«</a>
            </li>
        `);

		const addPageItem = (i, isActive = false) => {
			const activeClass = isActive ? 'active' : '';
			pagination.append(`
                <li class="page-item ${activeClass}">
                    <a class="page-link" href="#" data-page="${i}">${i}</a>
                </li>
            `);
		};

		const addEllipsis = () => {
			pagination.append(`
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
			} else if (current >= totalPages - 2) {
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

		const nextClass = current === totalPages ? 'disabled' : '';
		pagination.append(`
            <li class="page-item ${nextClass}">
                <a class="page-link" href="#" data-page="${current + 1}">»</a>
            </li>
        `);

		$(document).off('click', '.pagination a').on('click', '.pagination a', function(e) {
			e.preventDefault();
			const selectedPage = $(this).data('page');
			if (selectedPage >= 1 && selectedPage <= totalPages) {
				currentPage = selectedPage;
				fetchSuppliers(currentPage, pageSize);
			}
		});
	}
});