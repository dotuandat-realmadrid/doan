/**
 * 
 */

$(document).ready(function() {

	// Kiểm tra trạng thái đăng nhập ***** All *****
	checkLoginStatus();

	// Xử lý sự kiện đăng xuất ***** All *****
	$('#logout').on('click', function(e) {
		e.preventDefault();
		logout();
	});

	let currentPage = 1;
	let pageSize = 5;
	let currentFilters = {}; // <- Thêm biến lưu filters toàn cục

	function fetchUsers(page = 1, size = 5, filters = {}) {
		let queryParams = `page=${page}&size=${size}`;

		if (filters.userId) queryParams += `&id=${filters.userId}`;
		if (filters.email) queryParams += `&username=${filters.email}`;
		if (filters.role) queryParams += `&role=${filters.role}`;
		if (filters.fullName) queryParams += `&fullName=${filters.fullName}`;
		if (filters.phone) queryParams += `&phone=${filters.phone}`;
		if (filters.accountType !== null && filters.accountType !== undefined) queryParams += `&isGuest=${filters.accountType}`;

		$.ajax({
			url: `http://localhost:8080/doan/users?${queryParams}`,
			method: "GET",
			xhrFields: {
				withCredentials: true  // bắt buộc nếu muốn gửi cookie/token trong request
			},
			success: function(response) {
				const users = response.result?.data || [];
				const totalPages = response.result?.totalPage || 1;
				const current = response.result?.currentPage || 1;
				const totalElements = response.result?.totalElements || 0;

				renderTable(users);
				renderPagination(current, totalPages);
				$("#totalUsers").text(` ${totalElements} người dùng`);
			},
			error: function(xhr) {
				if (xhr.status === 401) {
					alert("Bạn chưa đăng nhập!");
					window.location.href = "login.html";
				} else if (xhr.status === 400) {
					console.log(xhr.responseText);
				} else if (xhr.status === 403) {
					alert("Bạn không có quyền!");
					window.location.href = "home.html";
				} else {
					const message = xhr.responseJSON?.message || "Không thể tải danh sách người dùng.";
					console.log(message);
					console.log(xhr.responseText);
				}
			}
		});
	}

	$("#filterForm form").submit(function(e) {
		e.preventDefault();

		let selectedRole = $("#role").val();
		let mappedRole = null;

		// Mapping vai trò
		switch (selectedRole) {
			case "Nhân viên kiểm kho": mappedRole = "STAFF_INVENTORY"; break;
			case "Khách hàng": mappedRole = "CUSTOMER"; break;
			case "Nhân viên bán hàng": mappedRole = "STAFF_SALE"; break;
			case "Admin": mappedRole = "ADMIN"; break;
			case "Nhân viên chăm sóc khách hàng": mappedRole = "STAFF_CUSTOMER_SERVICE"; break;
			default: mappedRole = null;
		}

		const accountTypeId = $("input[name='accountType']:checked").attr("id");
		let mappedAccountType = null;
		if (accountTypeId === "systemUser") {
			mappedAccountType = 0;
		} else if (accountTypeId === "guest") {
			mappedAccountType = 1;
		}

		currentFilters = { // <- Cập nhật biến toàn cục
			userId: $("#userId").val(),
			email: $("#email").val(),
			role: mappedRole,
			fullName: $("#fullName").val(),
			phone: $("#phone").val(),
			accountType: mappedAccountType
		};

		currentPage = 1;
		fetchUsers(currentPage, pageSize, currentFilters);
	});

	function renderTable(users) {
		$(".table-hover tbody").empty();
		users.forEach((user, index) => {
			let status = '';
			if (user.isGuest === 1) {
				status = '<a class="btn btn-sm btn-outline-warning btn-buttons me-1 mb-1">Khách</a>';
			} else if (user.isActive === 0) {
				status = '<a class="btn btn-sm btn-outline-danger btn-buttons mb-1">Không hoạt động</a>';
			}

			const roles = user.roles.map(role => {
				switch (role) {
					case "STAFF_INVENTORY": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Nhân viên kiểm kho</a><br>`;
					case "CUSTOMER": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Khách hàng</a><br>`;
					case "STAFF_SALE": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Nhân viên bán hàng</a><br>`;
					case "ADMIN": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Admin</a><br>`;
					case "STAFF_CUSTOMER_SERVICE": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Nhân viên chăm sóc khách hàng</a><br>`;
					default: return `<span class="text-muted me-1 mb-1">Chưa phân quyền</span><br>`;
				}
			}).join(''); // XÓA <br> đi, để flex tự xuống dòng đẹp

			const stt = (currentPage - 1) * pageSize + index + 1;

			const row = `
	                <tr>
	                    <th scope="row" class="text-center align-middle">${stt}</th>
	                    <td class="align-middle">
	                        <div class="d-flex">
		                        <div class="text-center align-middle">
		                        	<i class="bi bi-person-circle text-primary" style="font-size: 30px;"></i>
		                        </div>
		                        <div class="ps-3">
		                            <div>${user.fullName}</div>
		                            <div class="text-muted font_size">ID: ${user.id}</div>
		                        </div>
		                        <div class="align-middle ps-2 w-auto">${status}</div>
	                        </div>
	                    </td>
	                    <td class="align-middle w-auto">${roles}</td>
	                    <td class="align-middle">
	                        <div><i class="bi bi-envelope text-primary"></i> ${user.username}</div>
	                        <div><i class="bi bi-telephone text-success"></i> ${user.phone || "xxxxxxxxxx"}</div>
	                    </td>
	                    <td class="align-middle">${user.dob || "N/A"}</td>
	                    <td class="text-center align-middle">
		                    <button class="btn btn-sm btn-outline-secondary border-0 view-details" data-user-id="${user.id}" title="Xem chi tiết">
			                    <i class="bi bi-eye"></i>
			                </button>
	                    </td>
	                </tr>
	            `;
			$(".table-hover tbody").append(row);
		});
		// Sự kiện "Xem chi tiết" tài khoản người dùng
		$(".view-details").on("click", function() {
			const userId = $(this).data("user-id");
			if (!userId) {
				alert("Không tìm thấy userId");
				return;
			}
			window.location.href = `detail-account.html?id=${userId}`;
		});
	}

	function renderPagination(current, totalPages) {
		const pagination = $(".pagination");
		pagination.empty();

		const prevClass = current === 1 ? "disabled" : "";
		pagination.append(`
	            <li class="page-item ${prevClass}">
	                <a class="page-link" href="#" data-page="${current - 1}">Previous</a>
	            </li>
	        `);

		const addPageItem = (i, isActive = false) => {
			const activeClass = isActive ? "active" : "";
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
			} else if (current >= totalPages - 3) {
				if (current >= totalPages - 2) {
					// Giữ nguyên như cũ nếu đang ở cuối
					for (let i = 1; i <= 3; i++) addPageItem(i);
					addEllipsis();
					for (let i = totalPages - 2; i <= totalPages; i++) addPageItem(i, i === current);
				} else {
					// Trường hợp như trang 7 trong 10 → 1 ... 6 7 8 ... 10
					addPageItem(1);
					addEllipsis();
					for (let i = current - 1; i <= current + 1; i++) addPageItem(i, i === current);
					addEllipsis();
					addPageItem(totalPages);
				}
			} else {
				addPageItem(1);
				addEllipsis();
				for (let i = current - 1; i <= current + 1; i++) addPageItem(i, i === current);
				addEllipsis();
				addPageItem(totalPages);
			}
		}

		const nextClass = current === totalPages ? "disabled" : "";
		pagination.append(`
	            <li class="page-item ${nextClass}">
	                <a class="page-link" href="#" data-page="${current + 1}">Next</a>
	            </li>
	        `);
	}

	// Sự kiện chuyển trang
	$(document).on("click", ".pagination a", function(e) {
		e.preventDefault();
		const selectedPage = $(this).data("page");

		if (selectedPage >= 1) {
			currentPage = selectedPage;
			fetchUsers(currentPage, pageSize, currentFilters); // <- dùng currentFilters
		}
	});

	// 
	$(".form-select").on("change", function() {
		pageSize = parseInt($(this).val());

		// Kiểm tra giá trị của pageSize trước khi gửi yêu cầu
		if (isNaN(pageSize) || pageSize <= 0) {
			pageSize = 5; // Gán giá trị mặc định nếu không phải là số hợp lệ
		}

		currentPage = 1;
		fetchUsers(currentPage, pageSize, currentFilters); // <- dùng currentFilters
	});

	// Sự kiện XÓA BỘ LỌC
	$("#filterForm form").on("reset", function(e) {

		// Xóa bộ lọc hiện tại
		currentFilters = {};

		// Reset currentPage về 1
		currentPage = 1;

		// Gọi lại hàm fetchUsers để load tất cả dữ liệu mặc định
		fetchUsers(currentPage, pageSize, currentFilters);
	});


	// Gọi lần đầu
	fetchUsers(currentPage, pageSize, currentFilters);

	// Thêm tài khoản
	$("#addUserForm").submit(function(event) {
		event.preventDefault();

		const fullName = $("#addFullName").val().trim();
		const username = $("#addUsername").val().trim();
		const password = $("#addPassword").val().trim();
		const confirmPassword = $("#addConfirmPassword").val().trim();
		const phone = $("#addPhone").val().trim();
		const dob = $("#addDob").val();

		if (password !== confirmPassword) {
			alert("Mật khẩu nhập lại không khớp!");
			return;
		}

		const roles = [];
		if ($("#kho").is(":checked")) roles.push("STAFF_INVENTORY");
		if ($("#banhang").is(":checked")) roles.push("STAFF_SALE");
		if ($("#khachhang").is(":checked")) roles.push("CUSTOMER");
		if ($("#admin").is(":checked")) roles.push("ADMIN");
		if ($("#chamsoc").is(":checked")) roles.push("STAFF_CUSTOMER_SERVICE");

		const requestData = {
			username: username,
			fullName: fullName,
			password: password,
			phone: phone,
			dob: dob,
			roles: roles
		};

		$.ajax({
			url: "http://localhost:8080/doan/users",
			type: "POST",
			xhrFields: {
				withCredentials: true  // bắt buộc nếu muốn gửi cookie/token trong request
			},
			contentType: "application/json",
			data: JSON.stringify(requestData),
			success: function(response) {
				alert("Thêm người dùng thành công!");
				$("#addUserModal").modal('hide');
				$("#addUserForm")[0].reset();
				// Gọi lại danh sách người dùng
				fetchUsers(currentPage, pageSize, currentFilters);
			},
			error: function(xhr) {
				alert('Lỗi: ' + xhr.responseText);
				console.log("Thêm thất bại: " + xhr.responseText);
			}
		});
	});
});

// Hàm kiểm tra đăng nhập ***** All *****
function checkLoginStatus() {
	$.ajax({
		url: 'http://localhost:8080/doan/users/myInfo',
		type: 'GET',
		xhrFields: {
			withCredentials: true
		},
		success: function(response) {
			console.log('myInfo API response:', response); // Debug phản hồi API myInfo
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
			}
		}
	});
}

// Hàm đăng xuất ***** All *****
function logout() {
	$.ajax({
		url: 'http://localhost:8080/doan/auth/logout',
		type: 'POST',
		contentType: 'application/json',
		data: null,
		xhrFields: {
			withCredentials: true // Gửi cookie cùng yêu cầu
		},
		success: function(response) {
			localStorage.removeItem("id");
			console.log('Logout successful:', response);
			// Xóa cookie token phía client
			document.cookie = 'token=; Max-Age=0; path=/;';
			window.location.href = 'login.html';
		},
		error: function(xhr, status, error) {
			console.error('Logout error:', status, error, xhr.responseText);
			localStorage.removeItem("id");
			// Xóa cookie và chuyển hướng để đảm bảo đăng xuất
			document.cookie = 'token=; Max-Age=0; path=/;';
			window.location.href = 'login.html';
		}
	});
}