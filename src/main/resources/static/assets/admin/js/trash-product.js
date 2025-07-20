$(document).ready(function() {
	// Khai báo biến toàn cục
	let currentPage = 1;
	let pageSize = 5;
	let intervalId = null;

	// Tải sản phẩm khi trang tải
	fetchProducts(currentPage, pageSize);

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

	// Xử lý nút khôi phục nhiều sản phẩm
	$('#restoreSelected').text('Khôi phục 0 sản phẩm').on('click', function() {
		if (confirm('Bạn có chắc chắn muốn khôi phục các sản phẩm đã chọn?')) {
			restoreSelectedProducts();
		}
	});

	// Hàm hiển thị/ẩn nút khôi phục và cập nhật văn bản
	function toggleRestoreButton() {
		const checkedCount = $('table tbody input[type="checkbox"]:checked').length;
		$('#restoreSelected').toggle(checkedCount > 0);
		$('#restoreSelected').text(`Khôi phục ${checkedCount} sản phẩm`);
	}

	// Hàm khôi phục nhiều sản phẩm
	function restoreSelectedProducts() {
		const selectedIds = [];
		$('table tbody input[type="checkbox"]:checked').each(function() {
			const row = $(this).closest('tr');
			const productId = row.data('product-id');
			if (productId && productId !== 'undefined') {
				selectedIds.push(productId);
			}
		});

		if (selectedIds.length === 0) {
			alert('Vui lòng chọn ít nhất một sản phẩm hợp lệ để khôi phục!');
			return;
		}

		$.ajax({
			url: `http://localhost:8080/doan/products/restore/${selectedIds.join(',')}`,
			method: 'PUT',
			xhrFields: { withCredentials: true },
			success: function() {
				alert('Khôi phục sản phẩm thành công!');
				$('#selectAll').prop('checked', false);
				$('table tbody input[type="checkbox"]').prop('checked', false);
				toggleRestoreButton();
				fetchProducts(currentPage, pageSize);
				location.reload();
			},
			error: function(xhr) {
				const errorMsg = xhr.responseJSON?.message || xhr.responseText || 'Lỗi không xác định';
				if (xhr.responseJSON?.code === 'NO_RESTORABLE') {
					alert('Một hoặc nhiều sản phẩm đã hết hạn khôi phục (quá 60 ngày).');
				} else {
					alert(`Lỗi khi khôi phục sản phẩm: ${errorMsg}`);
				}
			}
		});
	}

	// Hàm render danh sách sản phẩm
	function renderTable(products) {
		$('table tbody').empty();
		$('#totalProducts').text('0 sản phẩm');

		if (products && products.length > 0) {
			const totalItems = products.length;
			$('#totalProducts').text(`${totalItems} sản phẩm`);

			products.forEach((item, index) => {
				// Kiểm tra dữ liệu trước khi render
				if (!item.product || !item.product.id) {
					console.warn(`Dữ liệu sản phẩm không hợp lệ tại index ${index}:`, item);
					return;
				}

				const price = item.product.price || 0;
				const discountPrice = item.product.discountPrice || 0;
				const imageSrc = item.product.images && item.product.images.length > 0 ? item.product.images[0] : '';
				const deletedDate = item.deletedDate || '';

				let priceHtml = '';
				if (item.product.discountName || discountPrice > 0) {
					priceHtml = `
                        <span style="text-decoration: line-through;">${price.toLocaleString()}đ</span><br>
                        <span class="text-danger">${discountPrice.toLocaleString()}đ</span>
                    `;
				} else {
					priceHtml = `${price.toLocaleString()}đ`;
				}

				const row = `
                    <tr style="font-size: 14px;" data-product-id="${item.product.id}">
                        <td class="align-middle"><input type="checkbox" class="product-checkbox"></td>
                        <th class="align-middle" scope="row">${(currentPage - 1) * pageSize + index + 1}</th>
                        <td>
                            <div class="d-flex align-items-center">
                                <img src="/doan/uploads/${imageSrc}" width="50" height="50" class="me-2">
                                <div class="d-block ms-2">
                                    ${item.product.name || ''}<br>
                                    <span class="text-muted">Mã: ${item.product.code || ''}</span><br>
                                    <span class="badge bg-warning">${item.product.discountName || ''}</span>
                                </div>
                            </div>
                        </td>
                        <td class="align-middle">
                            <span class="badge bg-primary">${item.product.categoryCode || ''}</span><br>
                            <span class="badge bg-success">${item.product.supplierCode || ''}</span>
                        </td>
                        <td class="align-middle text-center">${priceHtml}</td>
                        <td class="align-middle text-center">${item.product.soldQuantity || 0}</td>
                        <td class="align-middle text-center">${item.product.inventoryQuantity || 0}</td>
                        <td class="align-middle text-center">
                            <span class="text-warning">★★★★★</span><br>
                            <span>(${item.product.reviewCount || 0} đánh giá)</span>
                        </td>
                        <td class="align-middle text-center">
                            <span class="btn btn-sm btn-secondary font_size remaining-time" data-deleted-date="${deletedDate}"></span>
                        </td>
                        <td class="align-middle text-center">
                            <button class="btn btn-sm btn-outline-success border-0 restore-product" data-product-id="${item.product.id}" title="Khôi phục">
                                <i class="bi bi-arrow-counterclockwise"></i>
                            </button>
                        </td>
                    </tr>
                `;
				$('table tbody').append(row);
			});

			// Xử lý sự kiện khôi phục cho từng sản phẩm
			$('.restore-product').on('click', function() {
				const productId = $(this).data('product-id');
				if (!productId || productId === 'undefined') {
					alert('Không tìm thấy ID sản phẩm!');
					return;
				}
				if (confirm('Bạn có chắc chắn muốn khôi phục sản phẩm này?')) {
					$.ajax({
						url: `http://localhost:8080/doan/products/restore/${productId}`,
						method: 'PUT',
						xhrFields: { withCredentials: true },
						success: function() {
							alert('Khôi phục sản phẩm thành công!');
							fetchProducts(currentPage, pageSize);
						},
						error: function(xhr) {
							const errorMsg = xhr.responseJSON?.message || xhr.responseText || 'Lỗi không xác định';
							if (xhr.responseJSON?.code === 'NO_RESTORABLE') {
								alert('Sản phẩm đã hết hạn khôi phục (quá 60 ngày).');
							} else {
								alert(`Lỗi khi khôi phục sản phẩm: ${errorMsg}`);
							}
						}
					});
				}
			});

			// Cập nhật thời gian còn lại ngay sau khi render
			updateRemainingTime();
		} else {
			$('table tbody').html('<tr><td colspan="10" class="text-center">Không có dữ liệu sản phẩm</td></tr>');
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

					console.log(`Product ${$(this).closest('tr').data('product-id')}: deletedDate=${deletedDate.format('YYYY-MM-DD HH:mm:ss Z')}, expiryDate=${expiryDate.format('YYYY-MM-DD HH:mm:ss Z')}, totalMinutes=${totalMinutes}`);

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

	// Hàm tải sản phẩm
	function fetchProducts(page, size) {
		$.ajax({
			url: `http://localhost:8080/doan/products/trash?page=${page}&size=${size}`,
			method: 'GET',
			xhrFields: { withCredentials: true },
			success: function(response) {
				if (response.code === 1000) {
					const products = response.result.data || [];
					const totalPages = response.result.totalPage || 1;
					const current = response.result.currentPage || 1;
					const totalElements = response.result.totalElements || 0;

					renderTable(products);
					renderPagination(current, totalPages);
					$('#totalProducts').text(`${totalElements} sản phẩm`);
				} else if (response.code === 1012) {
					if (confirm('Bạn cần đăng nhập để xem danh sách sản phẩm. Bạn có muốn đăng nhập ngay không?')) {
						window.location.href = 'login.html';
					}
				} else {
					alert('Có lỗi xảy ra khi tải sản phẩm!');
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
					alert('Lỗi: ' + (xhr.responseJSON?.message || 'Không thể tải danh sách sản phẩm.'));
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
				fetchProducts(currentPage, pageSize);
			}
		});
	}
});