$(document).ready(function() {
	// --- Logic cho Sales Card, Revenue Card, Customers Card ---
	let saleData = null;

	function loadSaleData() {
		$.ajax({
			url: '/doan/home/sales',
			type: 'GET',
			xhrFields: {
				withCredentials: true
			},
			success: function(response) {
				saleData = response.result;
				//console.log('Sale data loaded:', saleData); // Gỡ lỗi
				updateSalesCard('today');
				updateRevenueCard('thisMonth');
				updateCustomersCard('thisYear');
			},
			error: function(xhr, status, error) {
				console.error('Error fetching sale data:', error);
				alert('Không thể tải dữ liệu thống kê.');
			}
		});
	}

	function getStatisticByPeriod(period) {
		if (!saleData) return null;
		return saleData.find(stat => stat.period === period);
	}

	function updateSalesCard(period) {
		const stat = getStatisticByPeriod(period);
		if (!stat) return;
		var totalProductsSold = stat.totalProductsSold.toLocaleString('vi-VN');
		var growthPercent = stat.salesGrowthPercent.toFixed(2);
		var periodLabel = stat.periodLabel;

		//console.log('Updating Sales Card:', { period, totalProductsSold, growthPercent, periodLabel });

		$('.sales-card .card-title span').text('| ' + periodLabel);
		$('.sales-card .ps-3 p.fw-bold.fs-5').text(totalProductsSold);
		$('.sales-card .ps-3 .text-muted').text(growthPercent >= 0 ? 'Tăng' : 'Giảm');
		$('.sales-card .ps-3 .small.pt-1.fw-bold')
			.removeClass('text-success text-danger')
			.addClass(growthPercent >= 0 ? 'text-success' : 'text-danger')
			.text(Math.abs(growthPercent) + '%');
	}

	function updateRevenueCard(period) {
		const stat = getStatisticByPeriod(period);
		if (!stat) return;
		var totalRevenue = stat.totalRevenue.toLocaleString('vi-VN');
		var growthPercent = stat.revenueGrowthPercent.toFixed(2);
		var periodLabel = stat.periodLabel;

		//console.log('Updating Revenue Card:', { period, totalRevenue, growthPercent, periodLabel });

		$('.revenue-card .card-title span').text('| ' + periodLabel);
		$('.revenue-card .ps-2 p.fw-bold.fs-5').text(totalRevenue);
		$('.revenue-card .ps-2 .text-muted').text(growthPercent >= 0 ? 'Tăng' : 'Giảm');
		$('.revenue-card .ps-2 .small.pt-1.fw-bold')
			.removeClass('text-success text-danger')
			.addClass(growthPercent >= 0 ? 'text-success' : 'text-danger')
			.text(Math.abs(growthPercent) + '%');
	}

	function updateCustomersCard(period) {
		const stat = getStatisticByPeriod(period);
		if (!stat) return;
		var totalCustomers = stat.totalCustomers.toLocaleString('vi-VN');
		var growthPercent = stat.customersGrowthPercent.toFixed(2);
		var periodLabel = stat.periodLabel;

		//console.log('Updating Customers Card:', { period, totalCustomers, growthPercent, periodLabel });

		$('.customers-card .card-title span').text('| ' + periodLabel);
		$('.customers-card .ps-3 p.fw-bold.fs-5').text(totalCustomers);
		$('.customers-card .ps-3 .text-muted').text(growthPercent >= 0 ? 'Tăng' : 'Giảm');
		$('.customers-card .ps-3 .small.pt-1.fw-bold')
			.removeClass('text-success text-danger')
			.addClass(growthPercent >= 0 ? 'text-success' : 'text-danger')
			.text(Math.abs(growthPercent) + '%');
	}

	// --- Logic cho Reports Card (biểu đồ) ---
	let chart = null;

	function loadChartData(period) {
		$.ajax({
			url: '/doan/home/time-series',
			type: 'GET',
			data: { period: period },
			xhrFields: {
				withCredentials: true
			},
			success: function(response) {
				const data = response.result;
				const revenueUnit = period === 'today' ? 'nghìn VNĐ' :
					period === 'thisMonth' ? 'triệu VNĐ' : 'tỷ VNĐ';
				const series = [
					{
						name: 'Bán hàng',
						data: data.map(item => Number(item.totalProductsSold).toFixed(2))
					},
					{
						name: 'Doanh thu',
						data: data.map(item => Number(item.totalRevenue).toFixed(2))
					},
					{
						name: 'Khách hàng',
						data: data.map(item => Number(item.totalCustomers).toFixed(2))
					}
				];
				const categories = data.map(item => item.timestamp);
				const periodLabel = period === 'today' ? 'Hôm nay' :
					period === 'thisMonth' ? 'Tháng này' : 'Năm nay';

				$('.card:has(#reportsChart) .card-title span').text('/' + periodLabel);

				const datetimeFormat = period === 'today' ? 'HH:mm' :
					period === 'thisMonth' ? 'dd/MM' : 'MM/yyyy';
				const xaxisLabels = {
					type: 'datetime',
					categories: categories,
					labels: {
						format: datetimeFormat
					}
				};

				if (chart) {
					chart.updateOptions({
						series: series,
						xaxis: xaxisLabels,
						tooltip: {
							x: {
								format: datetimeFormat
							},
							y: [
								{
									formatter: function(value) {
										return value + ' sản phẩm';
									}
								},
								{
									formatter: function(value) {
										return value + ' ' + revenueUnit;
									}
								},
								{
									formatter: function(value) {
										return value + ' người';
									}
								}
							]
						}
					});
				} else {
					chart = new ApexCharts(document.querySelector("#reportsChart"), {
						series: series,
						chart: {
							height: 350,
							type: 'area',
							toolbar: {
								show: false
							}
						},
						markers: {
							size: 4
						},
						colors: ['#4154f1', '#2eca6a', '#ff771d'],
						fill: {
							type: "gradient",
							gradient: {
								shadeIntensity: 1,
								opacityFrom: 0.3,
								opacityTo: 0.4,
								stops: [0, 90, 100]
							}
						},
						dataLabels: {
							enabled: false
						},
						stroke: {
							curve: 'smooth',
							width: 2
						},
						xaxis: xaxisLabels,
						tooltip: {
							x: {
								format: datetimeFormat
							},
							y: [
								{
									formatter: function(value) {
										return value + ' sản phẩm';
									}
								},
								{
									formatter: function(value) {
										return value + ' ' + revenueUnit;
									}
								},
								{
									formatter: function(value) {
										return value + ' người';
									}
								}
							]
						}
					});
					chart.render();
				}
			},
			error: function(xhr, status, error) {
				console.error('Error fetching time-series data:', error);
				alert('Không thể tải dữ liệu biểu đồ.');
			}
		});
	}

	// Hàm gọi API và cập nhật bảng Recent Sales
	function loadRecentSales(filter) {
		$.ajax({
			url: '/doan/home/recent-revenue',
			type: 'GET',
			data: { filter: filter },
			xhrFields: {
				withCredentials: true
			},
			success: function(response) {
				if (response.code === 1000) {
					let tbody = $('#recent-sales-body');
					tbody.empty(); // Xóa nội dung cũ

					response.result.forEach(function(order, index) {
						// Lấy tối đa 3 sản phẩm
						let productDetails = order.details.map(detail =>
							`${detail.productName}`
						).join('<br>');

						// Tạo div với thanh cuộn nếu có nhiều sản phẩm
						let productDetailsHtml = `
                          <div class="scroll-scroll" style="max-height: 64px; overflow-y: auto;">
                            ${productDetails}
                          </div>
                        `;

						// Xác định màu sắc cho trạng thái
						let statusColor;
						switch (order.status) {
							case 'PENDING': statusColor = 'warning'; break;    // Đang chờ xử lý - Vàng
							case 'CANCELLED': statusColor = 'danger'; break;   // Đã hủy - Đỏ
							case 'CONFIRMED': statusColor = 'info'; break;     // Đã xác nhận - Xanh lam
							case 'SHIPPING': statusColor = 'primary'; break;   // Đang giao hàng - Xanh dương
							case 'COMPLETED': statusColor = 'success'; break;  // Đã hoàn thành - Xanh lá
							case 'FAILED': statusColor = 'secondary'; break;   // Giao hàng thất bại - Xám
							default: statusColor = 'warning';
						}

						let row = `
                            <tr>
                                <th class="text-center align-middle" scope="row"><a href="#">${index + 1}</a></th>
                                <td class="align-middle">${order.fullName}</td>
                                <td class="align-middle">${productDetailsHtml}</td>
                                <td class="align-middle">${order.totalPrice.toLocaleString('vi-VN')} VNĐ</td>
                                <td class="text-center align-middle"><span class="badge bg-${statusColor}">${order.status}</span></td>
                            </tr>
                        `;
						tbody.append(row);
					});

					// Cập nhật tiêu đề
					let title;
					switch (filter) {
						case 'today': title = 'Hôm nay'; break;
						case 'thisMonth': title = 'Tháng này'; break;
						case 'thisYear': title = 'Năm nay'; break;
						default: title = 'Tất cả';
					}
					$('#filter-title').text(`| ${title}`);
				} else {
					alert('Lỗi khi lấy dữ liệu: ' + response.message);
				}
			},
			error: function() {
				alert('Không thể kết nối đến server.');
			}
		});
	}

	// Hàm gọi API và cập nhật bảng Top Selling
	function loadTopProducts(filter) {
		$.ajax({
			url: '/doan/home/top-products',
			type: 'GET',
			data: { filter: filter },
			xhrFields: {
				withCredentials: true
			},
			success: function(response) {
				if (response.code === 1000) {
					let tbody = $('.top-selling table tbody');
					tbody.empty(); // Xóa nội dung cũ

					response.result.forEach(function(product) {
						// Lấy ảnh đầu tiên từ danh sách images, hoặc ảnh mặc định nếu không có
						let imageSrc = product.images && product.images.length > 0
							? '/doan/uploads/' + product.images[0]
							: 'assets/admin/img/product-1.jpg';

						// Tính giá hiển thị: ưu tiên discountPrice nếu có
						let effectivePrice = product.discountPrice !== null ? product.discountPrice : product.price;

						// Tính doanh thu: effectivePrice * soldQuantity
						let revenue = effectivePrice * product.soldQuantity;

						let row = `
                            <tr>
                                <th class="text-center" scope="row"><a href=""><img src="${imageSrc}" alt="${product.name}"></a></th>
                                <td>${product.name}</td>
                                <td>${effectivePrice.toLocaleString('vi-VN')} VNĐ</td>
                                <td class="text-center fw-bold">${product.soldQuantity.toLocaleString('vi-VN')}</td>
                                <td>${revenue.toLocaleString('vi-VN')} VNĐ</td>
                            </tr>
                        `;
						tbody.append(row);
					});

					// Cập nhật tiêu đề
					let title;
					switch (filter) {
						case 'today': title = 'Hôm nay'; break;
						case 'thisMonth': title = 'Tháng này'; break;
						case 'thisYear': title = 'Năm nay'; break;
						default: title = 'Tháng này';
					}
					$('.top-selling .card-title span').text(`| ${title}`);
				} else {
					console.error('Error fetching top products:', response.message);
					alert('Lỗi khi lấy dữ liệu top sản phẩm: ' + response.message);
				}
			},
			error: function(xhr, status, error) {
				console.error('Error fetching top products:', error);
				alert('Không thể kết nối đến server khi lấy dữ liệu top sản phẩm.');
			}
		});
	}

	// Biến lưu trữ danh sách hoạt động và interval
	let recentActivities = [];
	let updateInterval = null;

	// Hàm tính thời gian tương đối từ timestamp
	function getRelativeTime(timestamp) {
		const now = new Date();
		const activityTime = new Date(timestamp);
		const diffMs = now - activityTime; // Khoảng cách thời gian (milliseconds)
		const diffSeconds = Math.floor(diffMs / 1000);
		const diffMinutes = Math.floor(diffSeconds / 60);
		const diffHours = Math.floor(diffMinutes / 60);
		const diffDays = Math.floor(diffHours / 24);
		const diffWeeks = Math.floor(diffDays / 7);

		if (diffMinutes < 1) return `${diffSeconds} giây`;
		if (diffHours < 1) return `${diffMinutes} phút`;
		if (diffDays < 1) return `${diffHours} giờ`;
		if (diffWeeks < 1) return `${diffDays} ngày`;
		if (diffWeeks < 4) return `${diffWeeks} tuần`;
		return `${Math.floor(diffWeeks / 4)} tháng`;
	}

	// Hàm cập nhật thời gian tương đối cho danh sách hoạt động
	function updateActivityTimes() {
		let activityItems = $('.activity .activity-item');
		activityItems.each(function(index) {
			if (recentActivities[index]) {
				let relativeTime = getRelativeTime(recentActivities[index].timestamp);
				$(this).find('.activite-label').text(relativeTime);
			}
		});
	}

	// Hàm gọi API và cập nhật Recent Activity
	function loadRecentActivities(filter) {
		// Xóa interval cũ nếu có
		if (updateInterval) {
			clearInterval(updateInterval);
		}

		$.ajax({
			url: '/doan/home/recent-activities',
			type: 'GET',
			data: { filter: filter },
			xhrFields: {
				withCredentials: true
			},
			success: function(response) {
				if (response.code === 1000) {
					let activityContainer = $('.activity');
					activityContainer.empty(); // Xóa nội dung cũ

					// Lưu danh sách hoạt động
					recentActivities = response.result;

					// Sử dụng vòng lặp for để xử lý danh sách hoạt động
					for (let i = 0; i < recentActivities.length; i++) {
						let activity = recentActivities[i];

						// Tính thời gian tương đối
						let relativeTime = getRelativeTime(activity.timestamp);

						// Xác định màu sắc và biểu tượng cho hành động
						let badgeClass, iconClass;
						switch (activity.actionType) {
							case 'LOGIN':
								badgeClass = 'text-success';
								iconClass = 'bi bi-box-arrow-in-right';
								break;
							case 'CREATE':
								badgeClass = 'text-info';
								iconClass = 'bi bi-plus-circle';
								break;
							case 'UPDATE':
								badgeClass = 'text-primary';
								iconClass = 'bi bi-pencil-square';
								break;
							case 'DELETE':
								badgeClass = 'text-danger';
								iconClass = 'bi bi-trash';
								break;
							case 'RESTORE':
								badgeClass = 'text-warning';
								iconClass = 'bi bi-arrow-counterclockwise';
								break;
							default:
								badgeClass = 'text-muted';
								iconClass = 'bi bi-activity';
						}

						let activityItem = `
                            <div class="activity-item d-flex">
                                <div class="activite-label">${relativeTime}</div>
                                <i class='bi bi-circle-fill activity-badge ${badgeClass} align-self-start'></i>
                                <div class="activity-content">
                                    ${activity.description} <a href="" class="fw-bold text-dark">${activity.username}</a>
                                </div>
                            </div>
                        `;
						activityContainer.append(activityItem);
					}

					// Cập nhật tiêu đề
					let title;
					switch (filter) {
						case 'today': title = 'Hôm nay'; break;
						case 'thisMonth': title = 'Tháng này'; break;
						case 'thisYear': title = 'Năm nay'; break;
						default: title = 'Hôm nay';
					}
					$('.card:has(.activity) .card-title span').text(`| ${title}`);

					// Bắt đầu interval để tự động cập nhật thời gian
					updateInterval = setInterval(updateActivityTimes, 10000); // Cập nhật mỗi 10 giây
				} else {
					console.error('Error fetching recent activities:', response.message);
					alert('Lỗi khi lấy dữ liệu hoạt động gần đây: ' + response.message);
				}
			},
			error: function(xhr, status, error) {
				console.error('Error fetching recent activities:', error);
				alert('Không thể kết nối đến server khi lấy dữ liệu hoạt động gần đây.');
			}
		});
	}

	// Xử lý khi rời trang để xóa interval
	$(window).on('unload', function() {
		if (updateInterval) {
			clearInterval(updateInterval);
		}
	});
	
	// Hàm load dữ liệu sản phẩm sắp hết hàng
    function loadLowStock(threshold) {
        $.ajax({
            url: 'http://localhost:8080/doan/home/low-stock',
            type: 'GET',
            data: { threshold: threshold },
            success: function(response) {
                if (response.code === 1000) {
                    let html = '';
                    response.result.forEach(item => {
                        html += `
                            <tr>
                                <td>${item.name}</td>
                                <td>${item.inventoryQuantity}</td>
                                <td>${item.soldQuantity}</td>
                                <td>${item.price.toLocaleString('vi-VN')} VNĐ</td>
                            </tr>
                        `;
                    });
                    $('#lowStockProducts').html(html);
                } else {
                    $('#lowStockProducts').html('<tr><td colspan="4">Không có dữ liệu</td></tr>');
                }
            },
            error: function(error) {
                console.error('Error loading low stock products:', error);
                $('#lowStockProducts').html('<tr><td colspan="4">Lỗi khi tải dữ liệu</td></tr>');
            }
        });
    }

    // Hàm load dữ liệu sản phẩm sắp hết hạn (giữ nguyên từ code cũ)
    function loadExpiringProducts(filter) {
        $.ajax({
            url: 'http://localhost:8080/doan/home/expiring-receipts',
            type: 'GET',
            data: { filter: filter },
            success: function(response) {
                if (response.code === 1000) {
                    let html = '';
                    response.result.forEach(receipt => {
                        receipt.detailResponses.forEach(item => {
                            html += `
                                <tr>
                                    <td>${item.productCode}</td>
                                    <td>${item.quantity}</td>
                                    <td class="text-center">${new Date(item.manufacturedDate).toLocaleDateString('vi-VN')}</td>
                                    <td>${new Date(item.expiryDate).toLocaleDateString('vi-VN')}</td>
                                </tr>
                            `;
                        });
                    });
                    $('#expiringProducts').html(html);
                } else {
                    $('#expiringProducts').html('<tr><td colspan="4">Không có dữ liệu</td></tr>');
                }
            },
            error: function(error) {
                console.error('Error loading expiring products:', error);
                $('#expiringProducts').html('<tr><td colspan="4">Lỗi khi tải dữ liệu</td></tr>');
            }
        });
    }

	// Khởi tạo dữ liệu khi trang tải
	loadSaleData();
	loadChartData('thisMonth');
	loadRecentSales('thisMonth');
	loadTopProducts('thisMonth');
	loadRecentActivities('today');
	loadLowStock(30);
	loadExpiringProducts('today');

	// Xử lý sự kiện dropdown cho Sales Card
	$('.sales-card .dropdown-item').click(function(e) {
		e.preventDefault();
		var periodText = $(this).text();
		var period = periodText === 'Hôm nay' ? 'today' :
			periodText === 'Tháng này' ? 'thisMonth' : 'thisYear';
		//console.log('Sales Card dropdown clicked:', period);
		updateSalesCard(period);
	});

	// Xử lý sự kiện dropdown cho Revenue Card
	$('.revenue-card .dropdown-item').click(function(e) {
		e.preventDefault();
		var periodText = $(this).text();
		var period = periodText === 'Hôm nay' ? 'today' :
			periodText === 'Tháng này' ? 'thisMonth' : 'thisYear';
		//console.log('Revenue Card dropdown clicked:', period);
		updateRevenueCard(period);
	});

	// Xử lý sự kiện dropdown cho Customers Card
	$('.customers-card .dropdown-item').click(function(e) {
		e.preventDefault();
		var periodText = $(this).text();
		var period = periodText === 'Hôm nay' ? 'today' :
			periodText === 'Tháng này' ? 'thisMonth' : 'thisYear';
		//console.log('Customers Card dropdown clicked:', period);
		updateCustomersCard(period);
	});

	// Xử lý sự kiện dropdown cho Reports Card
	$('.card:has(#reportsChart) .dropdown-item').click(function(e) {
		e.preventDefault();
		var periodText = $(this).text();
		var period = periodText === 'Hôm nay' ? 'today' :
			periodText === 'Tháng này' ? 'thisMonth' : 'thisYear';
		//console.log('Reports dropdown clicked:', period);
		loadChartData(period);
	});

	// Xử lý sự kiện dropdown cho Recent Sales
	$('.recent-sales .dropdown-item').click(function(e) {
		e.preventDefault();
		let filter = $(this).data('filter');
		//console.log('Recent Sales dropdown clicked:', filter);
		loadRecentSales(filter);
	});

	// Xử lý sự kiện dropdown cho Top Selling
	$('.top-selling .dropdown-item').click(function(e) {
		e.preventDefault();
		var periodText = $(this).text();
		var period = periodText === 'Hôm nay' ? 'today' :
			periodText === 'Tháng này' ? 'thisMonth' : 'thisYear';
		//console.log('Top Selling dropdown clicked:', period);
		loadTopProducts(period);
	});

	// Xử lý sự kiện dropdown cho Recent Activity
	$('.card:has(.activity) .dropdown-item').click(function(e) {
		e.preventDefault();
		var periodText = $(this).text();
		var period = periodText === 'Hôm nay' ? 'today' :
			periodText === 'Tháng này' ? 'thisMonth' : 'thisYear';
		//console.log('Recent Activity dropdown clicked:', period);
		loadRecentActivities(period);
	});

	// Xử lý filter cho sản phẩm sắp hết hàng
	$('.low-stock-products .dropdown-item').click(function(e) {
	    e.preventDefault();
	    let threshold = $(this).text();
	    $('.low-stock-products .card-title span').text(`| Số lượng: ${threshold}`);
	    loadLowStock(threshold);
	});

	// Xử lý filter cho sản phẩm sắp hết hạn
	$('.expiring-products .dropdown-item').click(function(e) {
	    e.preventDefault();
	    let filter = $(this).text();
	    let filterValue = filter === 'Hôm nay' ? 'today' : filter === 'Tháng này' ? 'thismonth' : 'thisyear';
	    $('.expiring-products .card-title span').text(`| ${filter}`);
	    loadExpiringProducts(filterValue);
	});
});