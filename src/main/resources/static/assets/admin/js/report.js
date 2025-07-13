$(document).ready(function() {
    // Hàm định dạng số tiền sang triệu VND
    function formatCurrency(amount) {
        return (amount / 1000000).toFixed(2) + ' triệu VND';
    }

    // Hàm kiểm tra trạng thái đăng nhập
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

                // Gọi các hàm lấy dữ liệu
                fetchOrderSummary();
                fetchOrderType();
                fetchWeeklyTrend();
                fetchCategoryReport();
                fetchSupplierReport();
                fetchTopRevenueChart();
                fetchLowestRevenueChart();
				fetchUserGrowth();
            },
            error: function(xhr, status, error) {
                console.error('Error checking login status:', status, error, xhr.responseText);
                if (xhr.status === 401) {
                    if (confirm('Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?')) {
                        localStorage.removeItem("id");
                        window.location.href = 'login.html';
                    }
                } else {
                    alert('Không thể kiểm tra trạng thái đăng nhập. Vui lòng thử lại.');
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

    // Hàm lấy dữ liệu tổng quan đơn hàng
    function fetchOrderSummary() {
        $.ajax({
            url: 'http://localhost:8080/doan/reports/order-summary',
            type: 'GET',
            xhrFields: { withCredentials: true },
            success: function(response) {
                console.log('Order Summary API response:', response);
                if (response.code === 1000 && response.result) {
                    const data = response.result;
                    $('#total-orders').text(data.totalOrders || 0);
                    $('#total-revenue').text(formatCurrency(data.totalRevenue || 0));
                    $('#total-purchase').text(formatCurrency(data.totalInventoryPrice || 0));
                    const profit = (data.totalRevenue || 0) - (data.totalInventoryPrice || 0);
                    $('#profit').text(formatCurrency(profit));
                } else {
                    throw new Error('Invalid response format');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error fetching order summary:', status, error, xhr.responseText);
                $('#total-orders, #total-revenue, #total-purchase, #profit').text('N/A');
                alert('Không thể lấy dữ liệu tổng quan đơn hàng. Vui lòng thử lại.');
            }
        });
    }

    // Hàm lấy dữ liệu phân bổ đơn hàng và cập nhật biểu đồ
    function fetchOrderType() {
        $.ajax({
            url: 'http://localhost:8080/doan/reports/order-type',
            type: 'GET',
            xhrFields: { withCredentials: true },
            success: function(response) {
                console.log('Order Type API response:', response);
                if (response.code === 1000 && response.result) {
                    const data = response.result;
                    const labels = data.map(item => item.orderType === 'ONLINE' ? 'Trực tuyến' : 'Tại cửa hàng');
                    const revenueData = data.map(item => (item.totalRevenue || 0) / 1000000);
                    const orderData = data.map(item => item.totalOrders || 0);

                    orderChart.data.labels = labels;
                    orderChart.data.datasets[0].data = revenueData;
                    orderChart.data.datasets[1].data = orderData;
                    orderChart.update();
                } else {
                    throw new Error('Invalid response format');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error fetching order type:', status, error, xhr.responseText);
                alert('Không thể lấy dữ liệu phân bổ đơn hàng. Vui lòng thử lại.');
            }
        });
    }

    // Hàm lấy dữ liệu xu hướng doanh thu hàng tuần và cập nhật biểu đồ
    function fetchWeeklyTrend() {
        $.ajax({
            url: 'http://localhost:8080/doan/reports/weekly-trend',
            type: 'GET',
            xhrFields: { withCredentials: true },
            success: function(response) {
                console.log('Weekly Trend API response:', response);
                if (response.code === 1000 && response.result) {
                    const data = response.result;
                    const labels = data.map(item => `Tuần ${item.weekOfYear}/${item.year}`);
                    const orderData = data.map(item => item.totalOrders || 0);
                    const revenueData = data.map(item => (item.totalRevenue || 0) / 1000000);

                    weeklyChart.data.labels = labels;
                    weeklyChart.data.datasets[0].data = orderData;
                    weeklyChart.data.datasets[1].data = revenueData;
                    weeklyChart.update();
                } else {
                    throw new Error('Invalid response format');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error fetching weekly trend:', status, error, xhr.responseText);
                alert('Không thể lấy dữ liệu xu hướng hàng tuần. Vui lòng thử lại.');
            }
        });
    }

	// Hàm lấy dữ liệu doanh thu theo danh mục và cập nhật biểu đồ ApexCharts
	function fetchCategoryReport() {
	    $.ajax({
	        url: 'http://localhost:8080/doan/reports/category-report',
	        type: 'GET',
	        xhrFields: { withCredentials: true },
	        success: function(response) {
	            console.log('Category Report API response:', response);
	            if (response.code === 1000 && response.result) {
	                const data = response.result;
	                // Lọc dữ liệu để loại bỏ các mục có totalRevenue <= 0
	                const filteredData = data.filter(item => item.totalRevenue > 0);
	                console.log('Filtered Category Data:', filteredData);
	                
	                // Tính tổng doanh thu từ dữ liệu đã lọc
	                const totalRevenue = filteredData.reduce((sum, item) => sum + (item.totalRevenue || 0), 0);
	                console.log('Total Revenue (Filtered):', totalRevenue);
	                
	                const labels = filteredData.map(item => item.categoryName);
	                const revenueData = filteredData.map(item => (item.totalRevenue || 0) / 1000000);
	                const quantities = filteredData.map(item => item.totalSoldQuantity || 0);
	                
	                // Tạo mảng dữ liệu gốc (không chia cho 1000000) để tính phần trăm
	                const originalRevenueData = filteredData.map(item => item.totalRevenue || 0);

	                if (totalRevenue === 0) {
	                    console.warn('Warning: Total Revenue is 0 for Category Report');
	                    return;
	                }

	                const categoryChart = new ApexCharts(document.querySelector("#categoryChart"), {
	                    series: revenueData,
	                    chart: { height: 350, type: 'pie', toolbar: { show: true } },
	                    labels: labels,
	                    dataLabels: {
	                        enabled: true,
	                        formatter: function(val, opts) {
	                            // Sử dụng dữ liệu thực tế để tính phần trăm
	                            const index = opts.seriesIndex;
	                            const currentRevenue = originalRevenueData[index];
	                            const percentage = (currentRevenue / totalRevenue * 100).toFixed(2);
	                            return `${percentage}%`;
	                        },
	                        style: {
	                            fontSize: '12px',
	                            fontFamily: 'Helvetica, Arial, sans-serif',
	                            fontWeight: 400
	                        }
	                    },
	                    tooltip: {
	                        y: {
	                            formatter: function(val, opts) {
	                                const index = opts.dataPointIndex;
	                                const quantity = quantities[index];
	                                const revenue = originalRevenueData[index];
	                                return `Số lượng bán: ${quantity}<br>Doanh thu: ${formatCurrency(revenue)}`;
	                            }
	                        }
	                    }
	                });
	                categoryChart.render();
	            } else {
	                throw new Error('Invalid response format');
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('Error fetching category report:', status, error, xhr.responseText);
	            alert('Không thể lấy dữ liệu doanh thu theo danh mục. Vui lòng thử lại.');
	        }
	    });
	}

	// Hàm lấy dữ liệu doanh thu theo nhà cung cấp và cập nhật biểu đồ ApexCharts
	function fetchSupplierReport() {
	    $.ajax({
	        url: 'http://localhost:8080/doan/reports/supplier-report',
	        type: 'GET',
	        xhrFields: { withCredentials: true },
	        success: function(response) {
	            console.log('Supplier Report API response:', response);
	            if (response.code === 1000 && response.result) {
	                const data = response.result;
	                // Lọc dữ liệu để loại bỏ các mục có totalRevenue <= 0
	                const filteredData = data.filter(item => item.totalRevenue > 0);
	                console.log('Filtered Supplier Data:', filteredData);

	                // Tính tổng doanh thu từ dữ liệu đã lọc
	                const totalRevenue = filteredData.reduce((sum, item) => sum + (item.totalRevenue || 0), 0);
	                console.log('Total Revenue (Filtered):', totalRevenue);

	                const labels = filteredData.map(item => item.supplierName);
	                const revenueData = filteredData.map(item => (item.totalRevenue || 0) / 1000000);
	                const quantities = filteredData.map(item => item.totalSoldQuantity || 0);

	                // Tạo mảng dữ liệu gốc (không chia cho 1000000) để tính phần trăm
	                const originalRevenueData = filteredData.map(item => item.totalRevenue || 0);

	                if (totalRevenue === 0) {
	                    console.warn('Warning: Total Revenue is 0 for Supplier Report');
	                    return;
	                }

	                const supplierChart = new ApexCharts(document.querySelector("#supplierChart"), {
	                    series: revenueData,
	                    chart: { height: 350, type: 'pie', toolbar: { show: true } },
	                    labels: labels,
	                    dataLabels: {
	                        enabled: true,
	                        formatter: function(val, opts) {
	                            // Sử dụng dữ liệu thực tế để tính phần trăm
	                            const index = opts.seriesIndex;
	                            const currentRevenue = originalRevenueData[index];
	                            const percentage = (currentRevenue / totalRevenue * 100).toFixed(2);
	                            return `${percentage}%`;
	                        },
	                        style: {
	                            fontSize: '12px',
	                            fontFamily: 'Helvetica, Arial, sans-serif',
	                            fontWeight: 400
	                        }
	                    },
	                    tooltip: {
	                        y: {
	                            formatter: function(val, opts) {
	                                const index = opts.dataPointIndex;
	                                const quantity = quantities[index];
	                                const revenue = originalRevenueData[index];
	                                return `Số lượng bán: ${quantity}<br>Doanh thu: ${formatCurrency(revenue)}`;
	                            }
	                        }
	                    }
	                });
	                supplierChart.render();
	            } else {
	                throw new Error('Invalid response format');
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('Error fetching supplier report:', status, error, xhr.responseText);
	            alert('Không thể lấy dữ liệu doanh thu theo nhà cung cấp. Vui lòng thử lại.');
	        }
	    });
	}

    // Hàm lấy và vẽ biểu đồ Top 5 sản phẩm có doanh thu cao nhất
    function fetchTopRevenueChart() {
        $.ajax({
            url: 'http://localhost:8080/doan/reports/products/top-revenue',
            type: 'GET',
            xhrFields: { withCredentials: true },
            success: function(response) {
                if (response.code === 1000 && response.result) {
                    const data = response.result;
                    const labels = data.map(item => item.name);
                    const revenueData = data.map(item => (item.totalRevenue / 1000000).toFixed(2));
                    const soldQuantityData = data.map(item => item.totalSoldQuantity || 0);

                    const ctx = document.getElementById('topRevenueChart').getContext('2d');
                    if (window.topRevenueChart instanceof Chart) {
                        window.topRevenueChart.destroy();
                    }
                    window.topRevenueChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [
                                {
                                    label: 'Doanh thu (triệu VND)',
                                    data: revenueData,
                                    backgroundColor: 'rgba(25, 135, 84, 0.6)',
                                    borderColor: 'rgba(25, 135, 84, 1)',
                                    borderWidth: 1,
                                    yAxisID: 'y'
                                },
                                {
                                    label: 'Số lượng bán',
                                    data: soldQuantityData,
                                    backgroundColor: 'rgba(111, 66, 193, 0.5)',
                                    borderColor: 'rgba(111, 66, 193, 1)',
                                    borderWidth: 1,
                                    yAxisID: 'y1'
                                }
                            ]
                        },
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    position: 'left',
                                    title: { display: true, text: 'Doanh thu (triệu VND)' }
                                },
                                y1: {
                                    beginAtZero: true,
                                    position: 'right',
                                    title: { display: true, text: 'Số lượng bán' },
                                    grid: { drawOnChartArea: false }
                                }
                            },
                            plugins: {
                                legend: { display: true, position: 'bottom' }
                            }
                        }
                    });
                }
            },
            error: function(xhr, status, error) {
                console.error('Error fetching top revenue data:', error);
            }
        });
    }

    // Hàm lấy và vẽ biểu đồ Top 5 sản phẩm có doanh thu thấp nhất
    function fetchLowestRevenueChart() {
        $.ajax({
            url: 'http://localhost:8080/doan/reports/products/lowest-revenue',
            type: 'GET',
            xhrFields: { withCredentials: true },
            success: function(response) {
                if (response.code === 1000 && response.result) {
                    const data = response.result;
                    const labels = data.map(item => item.name);
                    const revenueData = data.map(item => (item.totalRevenue / 1000000).toFixed(2));
                    const soldQuantityData = data.map(item => item.totalSoldQuantity || 0);

                    const ctx = document.getElementById('lowestRevenueChart').getContext('2d');
                    if (window.bottomRevenueChart instanceof Chart) {
                        window.bottomRevenueChart.destroy();
                    }
                    window.bottomRevenueChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [
                                {
                                    label: 'Doanh thu (triệu VND)',
                                    data: revenueData,
                                    backgroundColor: 'rgba(25, 135, 84, 0.6)',
                                    borderColor: 'rgba(25, 135, 84, 1)',
                                    borderWidth: 1,
                                    yAxisID: 'y'
                                },
                                {
                                    label: 'Số lượng bán',
                                    data: soldQuantityData,
                                    backgroundColor: 'rgba(111, 66, 193, 0.5)',
                                    borderColor: 'rgba(111, 66, 193, 1)',
                                    borderWidth: 1,
                                    yAxisID: 'y1'
                                }
                            ]
                        },
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    position: 'left',
                                    title: { display: true, text: 'Doanh thu (triệu VND)' }
                                },
                                y1: {
                                    beginAtZero: true,
                                    position: 'right',
                                    title: { display: true, text: 'Số lượng bán' },
                                    grid: { drawOnChartArea: false }
                                }
                            },
                            plugins: {
                                legend: { display: true, position: 'bottom' }
                            }
                        }
                    });
                }
            },
            error: function(xhr, status, error) {
                console.error('Error fetching lowest revenue data:', error);
            }
        });
    }

	// Hàm lấy dữ liệu tăng trưởng người dùng và cập nhật biểu đồ
	function fetchUserGrowth() {
	    $.ajax({
	        url: 'http://localhost:8080/doan/reports/user-growth',
	        type: 'GET',
	        xhrFields: { withCredentials: true },
	        success: function(response) {
	            console.log('User Growth API response:', response);
	            if (response.code === 1000 && response.result) {
	                const data = response.result;

	                // Sắp xếp dữ liệu theo thứ tự thời gian (tuần/năm)
	                const sortedData = data.sort((a, b) => {
	                    if (a.year !== b.year) {
	                        return a.year - b.year;
	                    }
	                    return a.weekOfYear - b.weekOfYear;
	                });

	                // Tạo nhãn cho trục x
	                const labels = sortedData.map(item => `Tuần ${item.weekOfYear}/${item.year}`);

	                // Dữ liệu người dùng mới mỗi tuần
	                const newUsersData = sortedData.map(item => item.newUsers || 0);

	                // Tính tổng tích lũy người dùng
	                let totalUsers = 0;
	                const totalUsersData = sortedData.map(item => {
	                    totalUsers += item.newUsers || 0;
	                    return totalUsers;
	                });

	                // Cập nhật biểu đồ
	                userGrowthChart.data.labels = labels;
	                userGrowthChart.data.datasets[0].data = newUsersData; // Người dùng mới (bar)
	                userGrowthChart.data.datasets[1].data = totalUsersData; // Tổng người dùng (line)
	                userGrowthChart.update();

	                console.log('Dữ liệu tăng trưởng người dùng đã được cập nhật:', {
	                    labels: labels,
	                    newUsers: newUsersData,
	                    totalUsers: totalUsersData
	                });
	            } else {
	                throw new Error('Định dạng phản hồi không hợp lệ');
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('Lỗi khi lấy dữ liệu tăng trưởng người dùng:', status, error, xhr.responseText);
	            alert('Không thể lấy dữ liệu tăng trưởng người dùng. Vui lòng thử lại.');
	        }
	    });
	}

    // Khởi tạo biểu đồ phân bổ đơn hàng với tính năng tương tác
    const ctxOrder = document.getElementById('orderChart').getContext('2d');
    const orderChart = new Chart(ctxOrder, {
        type: 'bar',
        data: {
            labels: ['Trực tuyến', 'Tại cửa hàng'],
            datasets: [
                {
                    label: 'Doanh thu (triệu VNĐ)',
                    data: [0, 0],
                    backgroundColor: 'rgba(25, 135, 84, 0.6)',
                    borderColor: 'rgba(25, 135, 84, 1)',
                    borderWidth: 1,
                    yAxisID: 'y'
                },
                {
                    label: 'Số đơn hàng',
                    data: [0, 0],
                    backgroundColor: 'rgba(111, 66, 193, 0.5)',
                    borderColor: 'rgba(111, 66, 193, 1)',
                    borderWidth: 1,
                    yAxisID: 'y1'
                }
            ]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    position: 'left',
                    title: { display: true, text: 'Doanh thu (triệu VND)' },
                    beginAtZero: true
                },
                y1: {
                    position: 'right',
                    title: { display: true, text: 'Số đơn hàng' },
                    grid: { drawOnChartArea: false },
                    beginAtZero: true
                }
            },
            plugins: {
                legend: {
                    display: true,
                    position: 'bottom',
                    onClick: (e, legendItem, legend) => {
                        const index = legendItem.datasetIndex;
                        const ci = legend.chart;
                        const meta = ci.getDatasetMeta(index);

                        // Toggle visibility
                        meta.hidden = meta.hidden === null ? !ci.data.datasets[index].hidden : null;
                        ci.update();
                    }
                }
            }
        }
    });

    // Khởi tạo biểu đồ xu hướng doanh thu hàng tuần
    const ctxWeekly = document.getElementById('weeklyChart').getContext('2d');
    const weeklyChart = new Chart(ctxWeekly, {
        data: {
            labels: [],
            datasets: [
                {
                    type: 'bar',
                    label: 'Số đơn hàng',
                    data: [],
                    yAxisID: 'y1',
                    backgroundColor: 'rgba(255, 105, 180, 0.6)',
                    borderRadius: 4,
                    barThickness: 40,
                    categoryPercentage: 0.8,
                    barPercentage: 0.9
                },
                {
                    type: 'line',
                    label: 'Doanh thu (triệu VNĐ)',
                    data: [],
                    yAxisID: 'y',
                    borderColor: 'orange',
                    backgroundColor: 'orange',
                    fill: false,
                    tension: 0.4,
                    pointBorderColor: 'white',
                    pointBackgroundColor: 'orange',
                    pointRadius: 5,
                    pointHoverRadius: 6
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                x: {
                    offset: true,
                    ticks: { maxRotation: 0, minRotation: 0 },
                    grid: { borderColor: 'transparent', display: true, drawOnChartArea: true, color: '#ddd', offset: false }
                },
                y: {
                    type: 'linear',
                    position: 'left',
                    beginAtZero: true,
                    title: { display: true, text: 'Doanh thu (triệu VND)' },
                    grid: { borderDash: [4, 4], color: '#ddd' }
                },
                y1: {
                    type: 'linear',
                    position: 'right',
                    beginAtZero: true,
                    title: { display: true, text: 'Số đơn hàng' },
                    grid: { drawOnChartArea: false }
                }
            },
            plugins: {
                legend: { position: 'bottom', labels: { usePointStyle: true } },
                tooltip: { mode: 'index', intersect: false }
            }
        }
    });
	
	// Khởi tạo biểu đồ tăng trưởng người dùng
	const ctxUserGrowth = document.getElementById('userGrowthChart').getContext('2d');
	const userGrowthChart = new Chart(ctxUserGrowth, {
	    data: {
	        labels: [],
	        datasets: [
	            {
	                type: 'bar',
	                label: 'Người dùng mới',
	                data: [],
	                backgroundColor: 'rgba(72, 187, 120, 0.7)',
	                borderColor: 'rgba(72, 187, 120, 1)',
	                borderWidth: 1,
	                borderRadius: 4,
	                barThickness: 30,
	                categoryPercentage: 0.8,
	                barPercentage: 0.6,
	                yAxisID: 'y1'
	            },
	            {
	                type: 'line',
	                label: 'Tổng người dùng',
	                data: [],
	                borderColor: 'rgba(99, 102, 241, 1)',
	                backgroundColor: 'rgba(99, 102, 241, 0.1)',
	                fill: false,
	                tension: 0.4,
	                pointBorderColor: 'white',
	                pointBackgroundColor: 'rgba(99, 102, 241, 1)',
	                pointRadius: 4,
	                pointHoverRadius: 6,
	                pointBorderWidth: 2,
	                yAxisID: 'y'
	            }
	        ]
	    },
	    options: {
	        responsive: true,
	        maintainAspectRatio: false,
	        scales: {
	            x: {
	                offset: true,
	                ticks: { 
	                    maxRotation: 45, 
	                    minRotation: 45,
	                    font: { size: 11 }
	                },
	                grid: { 
	                    borderColor: 'transparent', 
	                    display: true, 
	                    drawOnChartArea: true, 
	                    color: 'rgba(0,0,0,0.1)', 
	                    offset: false 
	                }
	            },
	            y: {
	                type: 'linear',
	                position: 'left',
	                beginAtZero: true,
	                title: { 
	                    display: true, 
	                    text: 'Tổng người dùng',
	                    font: { size: 12, weight: 'bold' }
	                },
	                grid: { 
	                    borderDash: [2, 2], 
	                    color: 'rgba(0,0,0,0.1)' 
	                }
	            },
	            y1: {
	                type: 'linear',
	                position: 'right',
	                beginAtZero: true,
	                title: { 
	                    display: true, 
	                    text: 'Người dùng mới',
	                    font: { size: 12, weight: 'bold' }
	                },
	                grid: { 
	                    drawOnChartArea: false 
	                }
	            }
	        },
	        plugins: {
	            legend: { 
	                position: 'bottom', 
	                labels: { 
	                    usePointStyle: true,
	                    padding: 20,
	                    font: { size: 12 }
	                }
	            },
	            tooltip: { 
	                mode: 'index', 
	                intersect: false,
	                backgroundColor: 'rgba(0,0,0,0.8)',
	                titleColor: 'white',
	                bodyColor: 'white',
	                cornerRadius: 6,
	                displayColors: true,
	                callbacks: {
	                    label: function(context) {
	                        let label = context.dataset.label || '';
	                        if (label) {
	                            label += ': ';
	                        }
	                        label += context.parsed.y;
	                        if (context.dataset.type === 'bar') {
	                            label += ' người dùng mới';
	                        } else {
	                            label += ' tổng người dùng';
	                        }
	                        return label;
	                    }
	                }
	            }
	        },
	        interaction: {
	            mode: 'nearest',
	            axis: 'x',
	            intersect: false
	        }
	    }
	});

    // Xử lý sự kiện đăng xuất
    $('#logout').on('click', function(e) {
        e.preventDefault();
        logout();
    });

    // Gọi kiểm tra trạng thái đăng nhập
    checkLoginStatus();
});