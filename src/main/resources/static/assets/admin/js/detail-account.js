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
	const urlParams = new URLSearchParams(window.location.search);
	const userId = urlParams.get('id'); // Lấy ID người dùng từ URL

	if (userId) {
		getUser(userId);
		getAddress(userId);
	} else {
		alert("Không tìm thấy thông tin người dùng.");
	}

	// Sự kiện cập nhật tài khoản
	$(".save-btn").click(function(e) {
		e.preventDefault(); // Ngăn chặn hành động mặc định của nút

		// Lấy giá trị của các checkbox đã chọn và đưa vào mảng roles
		var roles = [];
		if ($("#kho").prop('checked')) roles.push("STAFF_INVENTORY");
		if ($("#khachhang").prop('checked')) roles.push("CUSTOMER");
		if ($("#banhang").prop('checked')) roles.push("STAFF_SALE");
		if ($("#admin").prop('checked')) roles.push("ADMIN");
		if ($("#chamsoc").prop('checked')) roles.push("STAFF_CUSTOMER_SERVICE");

		const username = $("#Username").val().trim();
		const fullName = $("#FullName").val().trim();
		const phone = $("#Phone").val().trim();
		const dob = $("#Dob").val().trim() || null;
		let isGuest; // Khai báo biến isGuest một lần

		if ($("#IsGuest").val().trim() === "Người dùng hệ thống") {
			isGuest = 0;  // Gán giá trị 0 nếu là "Người dùng hệ thống"
		} else {
			isGuest = 1;  // Gán giá trị 1 nếu là "Khách"
		}


		// Thu thập dữ liệu từ các trường trong form
		var formData = {
			username: username,
			fullName: fullName,
			phone: phone,
			dob: dob, // Nếu không có giá trị ngày sinh thì gán là null
			isGuest: isGuest,
			roles: roles
		};

		// Hiển thị dữ liệu để kiểm tra
		console.log(JSON.stringify(formData, null, 2));

		// Lấy userId từ trường #Id
		var userId = $("#Id").val().trim();
		if (!userId) {
			alert("User ID không hợp lệ!");
			return;
		}

		// Gửi dữ liệu qua AJAX
		if (confirm('Bạn có chắc chắn muốn cập nhật tài khoản này không? Hành động này không thể hoàn tác!')) {
			$.ajax({
				url: `http://localhost:8080/doan/users/${userId}`, // Đảm bảo URL đúng
				method: 'PUT',
				credentials: 'include',
				contentType: 'application/json', // Đảm bảo gửi dữ liệu dưới dạng JSON
				data: JSON.stringify(formData),
				success: function(response) {
					// Xử lý thành công
					alert("Tài khoản đã được lưu!");
					console.log(response);
					// Có thể thêm các thao tác khác như đóng form hoặc cập nhật UI
					document.getElementById('editCard').classList.add('d-none');
					document.getElementById('viewCard').classList.remove('d-none');
					getUser(userId);
				},
				error: function(xhr, status, error) {
					// Xử lý lỗi
					alert(xhr.responseText);
					console.error(xhr, status, error);
				}
			});
		}
	});

	// Sự kiện
	$(".edit-btn").click(function(e) {
		e.preventDefault(); // Ngăn chặn hành động mặc định của nút
		document.getElementById('viewCard').classList.add('d-none');
		document.getElementById('editCard').classList.remove('d-none');
	});

	// Sự kiện
	$(".remove-btn").click(function(e) {
		e.preventDefault(); // Ngăn hành động mặc định của nút
		document.getElementById('editCard').classList.add('d-none');
		document.getElementById('viewCard').classList.remove('d-none');
	});

	// Sự kiện 
	$(".btn-remove").click(function(e) {
		e.preventDefault(); // Ngăn hành động mặc định của nút

		// 1. Reset toàn bộ input trong form
		$("#addAddressForm")[0].reset();

		// 2. Ẩn (đóng) Modal
		$("#addAddressModal").modal('hide');
	});

	// Hàm thêm địa chỉ
	$(document).on("click", ".btn-save", function(e) {
		e.preventDefault(); // Ngăn hành động mặc định của nút

		const userId = $("#id").val().trim() || $("#Id").val().trim();
		const fullName = $("#addFullName").val().trim();
		const phone = $("#addPhone").val().trim();
		const ward = $("#addWard").val().trim();
		const district = $("#addDistrict").val().trim();
		const province = $("#addProvince").val().trim();
		const detail = $("#addDetail").val().trim();
		const createdDate = getLocalDateTimeNow();
		const createdBy = $("#username").val().trim() || $("#Username").val().trim();
		const modifiedDate = getLocalDateTimeNow();
		const modifiedBy = $("#username").val().trim() || $("#Username").val().trim();

		const requestData = {
			userId: userId,
			fullName: fullName,
			ward: ward,
			phone: phone,
			district: district,
			province: province,
			detail: detail,
			createdDate: createdDate,
			createdBy: createdBy,
			modifiedDate: modifiedDate,
			modifiedBy: modifiedBy
		};

		if (confirm('Bạn có chắc chắn muốn thêm địa chỉ này không? Hành động này không thể hoàn tác!')) {
			$.ajax({
				url: `http://localhost:8080/doan/addresses?userId=${userId}`,
				type: "POST",
				credentials: 'include',
				contentType: "application/json",
				data: JSON.stringify(requestData),
				success: function(response) {
					alert("Thêm địa chỉ thành công!");
					// Ẩn (đóng) Modal
					$("#addAddressModal").modal('hide');
					$('#addAddressModal input').val('');
					getUser(userId);
					getAddress(userId);
					console.log(response);
				},
				error: function(xhr) {
					console.log("Thêm thất bại: " + xhr.responseText);
				}
			});
		}
	});

	// Hàm xem chi tiết địa chỉ của người dùng
	$(document).on("click", ".update-btn", function(e) {
		e.preventDefault(); // Ngăn reload

		const addressId = $(this).data("address-id"); // lấy id từ data-address-id

		if (!addressId) {
			alert("Không tìm thấy addressId");
			return;
		}

		$.ajax({
			url: `http://localhost:8080/doan/addresses/${addressId}`, // Đúng rồi, dùng addressId
			method: "GET",
			success: function(response) {
				const address = response.result;  // Bạn chắc chắn response.result là 1 object chứ không phải list nhé
				console.log("address object:", address);
				// Gán dữ liệu vào form
				$("#updateId").val(address.id);
				$("#updateFullName").val(address.fullName);
				$("#updatePhone").val(address.phone);
				$("#updateProvince").val(address.province);
				$("#updateDistrict").val(address.district);
				$("#updateWard").val(address.ward);
				$("#updateDetail").val(address.detail);
				$("#updateCreatedDate").val(address.createdDate || "Không có");
				$("#updateCreatedBy").val(address.createdBy || "Không có");
				$("#updateModifiedDate").val(address.modifiedDate || "Không có");
				$("#updateModifiedBy").val(address.modifiedBy || "Không có");
			},
			error: function(xhr) {
				alert("Lỗi khi lấy thông tin địa chỉ: " + xhr.responseText);
			}
		});
	});

	// Hàm cập nhật địa chỉ người dùng
	$(document).on("click", "#btn-save", function(e) {
		e.preventDefault(); // Ngăn reload
		const id = $("#updateId").val().trim();
		const fullName = $("#updateFullName").val().trim();
		const phone = $("#updatePhone").val().trim();
		const province = $("#updateProvince").val().trim();
		const district = $("#updateDistrict").val().trim();
		const ward = $("#updateWard").val().trim();
		const detail = $("#updateDetail").val().trim();

		const requestData = {
			fullName: fullName,
			ward: ward,
			phone: phone,
			district: district,
			province: province,
			detail: detail
		};
		
		if (confirm('Bạn có chắc chắn muốn cập nhật địa chỉ này không? Hành động này không thể hoàn tác!')) {
			$.ajax({
				url: `http://localhost:8080/doan/addresses/${id}`,
				type: "PUT",
				/* credentials: 'include', */
				contentType: "application/json",
				data: JSON.stringify(requestData),
				success: function(response) {
					alert("Cập nhật địa chỉ thành công!");
					// Ẩn (đóng) Modal
					$("#updateAddressModal").modal('hide');
					getUser(userId);
					getAddress(userId);
					console.log(response);
				},
				error: function(xhr) {
					console.log("Thêm thất bại: " + xhr.responseText);
				}
			});
		}
	});

	// Xóa tài khoản người dùng
	$(document).on("click", ".delete-btn", function(e) {
		e.preventDefault();

		if (!userId) {
			alert('Không tìm thấy userId');
			return;
		}

		// Thêm thông báo xác nhận trước khi xóa
		if (confirm('Bạn có chắc chắn muốn xóa tài khoản này không? Hành động này không thể hoàn tác!')) {
			$.ajax({
				url: `http://localhost:8080/doan/users/${userId}`, // Sửa từ {userId} thành ${userId}
				type: "DELETE",
				success: function(response) {
					alert("Bạn đã xóa tài khoản người dùng thành công!");
					window.location.href = "list-account.html"; // Sửa từ window.href.location
				},
				error: function(xhr) {
					console.log("Lỗi xóa tài khoản người dùng: " + xhr.responseText); // Sửa từ xhr.reponseText
				}
			});
		}
	});

	// Hàm xóa địa chỉ người dùng
	$(document).on("click", ".btn-delete", function(e) {
		e.preventDefault(); // Ngăn reload

		const addressId = $(this).data("address-id"); // lấy id từ data-address-id

		if (!addressId) {
			alert("Không tìm thấy addressId");
			return;
		}

		if (confirm('Bạn có chắc chắn muốn xóa địa chỉ này không? Hành động này không thể hoàn tác!')) {
			$.ajax({
				url: `http://localhost:8080/doan/addresses/${addressId}`,
				type: "DELETE",
				success: function(response) {
					alert("Xóa địa chỉ thành công!");
					getUser(userId);
					getAddress(userId);
				},
				error: function(xhr) {
					console.log("Xóa thất bại: " + xhr.responseText);
				}
			});
		}
	});

	$("#btn-remove").click(function(e) {
		e.preventDefault(); // Ngăn reload
		$("#updateAddressModal").modal('hide');
	});

	function getLocalDateTimeNow() {
		const now = new Date();
		now.setHours(now.getHours() + 7); // Cộng thêm 7 tiếng cho đúng giờ Việt Nam
		return now.toISOString().slice(0, 19);
	}

	$('#addAddressModal').on('hidden.bs.modal', function() {
		$('body').focus();
	});
});

function getUser(userId) {
	// Gọi API để lấy thông tin chi tiết người dùng
	$.ajax({
		url: `http://localhost:8080/doan/users/${userId}`, // Địa chỉ API, thay thế bằng URL thực tế của bạn
		method: 'GET',
		credentials: 'include',
		success: function(response) {
			const user = response.result;
			// Điền dữ liệu vào các ô input
			$("#id").val(user.id);
			$("#username").val(user.username); // Sửa lại từ `user(username)`
			$("#fullName").val(user.fullName);
			$("#phone").val(user.phone);
			$("#dob").val(user.dob || "N/A");
			$("#createdDate").val(user.createdDate);
			$("#modifiedDate").val(user.modifiedDate);
			$("#modifiedBy").val(user.modifiedBy);
			$(".fullName").text(user.fullName);
			$(".username").text(user.username);
			$("#Id").val(user.id);
			$("#Username").val(user.username); // Sửa lại từ `user(username)`
			$("#FullName").val(user.fullName);
			$("#Phone").val(user.phone);
			$("#Dob").val(user.dob);
			user.isGuest === 0 ? $("#IsGuest").val("Người dùng hệ thống") : $("#IsGuest").val("Khách");
			// === Tích check các checkbox dựa trên roles ===
			if (user.roles && Array.isArray(user.roles)) {
				user.roles.forEach(function(role) {
					$(`input.form-check-input[value='${role}']`).prop('checked', true);
				});
			}

			const roles = user.roles.map(role => {
				switch (role) {
					case "STAFF_INVENTORY": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Nhân viên kiểm kho</a>`;
					case "CUSTOMER": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Khách hàng</a>`;
					case "STAFF_SALE": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Nhân viên bán hàng</a>`;
					case "ADMIN": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Admin</a>`;
					case "STAFF_CUSTOMER_SERVICE": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Nhân viên chăm sóc khách hàng</a>`;
					default: return `<span class="text-muted me-1 mb-1">Không có vai trò</span>`;
				}
			}).join(' ');

			// Sử dụng .html() để hiển thị các vai trò dưới dạng HTML
			$("#roles").html(roles);

			// Hiển thị các trạng thái người dùng
			if (user.isActive) {
				$(".isActive").html('<i class="bi bi-circle-fill text-success text-opacity-75 me-2" style="font-size: 6px;"></i> Hoạt động');
			} else {
				$(".isActive").html('<i class="bi bi-circle-fill text-danger me-2" style="font-size: 6px;"></i> Đã xóa');
				// Ẩn hoặc disable 2 nút
				$(".edit-btn").hide();
				$(".delete-btn").hide();
			}

			if (user.isGuest) {
				$(".isGuest").html('<i class="bi bi-circle-fill text-warning mx-2" style="font-size: 6px;"></i> Khách');
			} else {
				$(".isGuest").html('<i class="bi bi-circle-fill text-info mx-2" style="font-size: 6px;"></i> Người dùng hệ thống');
			}
		},
		error: function(xhr, status, error) {
			if (xhr.status === 401) {
				alert('Bạn chưa đăng nhập');
				window.href.location = "login.html";
			} else {
				alert("Lỗi khi lấy thông tin người dùng: " + xhr.responseText);
			}
		}
	});
}

// Hàm lấy danh sách address
function getAddress(userId) {
	let queryParams = `userId=${userId}`;  // Sửa lại cú pháp cho đúng

	// Gọi API khi trang tải xong
	$.ajax({
		url: `http://localhost:8080/doan/addresses?${queryParams}`,
		method: "GET",
		success: function(response) {
			// Giả sử response trả về một danh sách các địa chỉ trong trường result
			const addresses = response.result;  // Lấy danh sách địa chỉ từ response.result

			// Xử lý và chèn từng địa chỉ vào danh sách
			let row = '';
			addresses.forEach(address => {
				row += `
                <div class="col-12 mb-2">
                  <div class="card shadow-sm">
                    <div class="card-body d-block">
                      <div class="me-3 d-flex align-items-center">
                        <div class="justify-content-center align-items-center mb-2 me-2">
                          <i class="bi bi-person-circle text-primary" style="font-size: 20px;"></i>
                        </div>
                        <h6 class="mb-1 fw-bold d-flex align-items-center">
                          ${address.fullName}
                          <i class="bi bi-telephone ms-3 me-1 font_size fw-bold"></i>
                          <span class="fw-normal">${address.phone}</span>
                        </h6>
                      </div>
                      <div class="col-12">
                        <p class="mb-0 d-flex align-items-start"><i class="bi bi-house-door me-1 ms-1"></i> ${address.detail}</p>
                        <small class="d-flex align-items-start mt-1 ms-4">
                          ${address.ward}, ${address.district}, ${address.province}
                        </small>
                      </div>
                    </div>
                    <div class="card-footer bg-white d-flex justify-content-around">
                      <button class="btn btn-link text-decoration-none text-muted update-btn" data-bs-toggle="modal" data-bs-target="#updateAddressModal" data-address-id="${address.id}" title="Cập nhật">
                        <i class="bi bi-pencil-square"></i>
                      </button>
                      <button class="btn btn-link text-danger text-decoration-none btn-delete" data-address-id="${address.id}" title="Xóa">
                        <i class="bi bi-trash"></i>
                      </button>
                    </div>
                  </div>
                </div>
              `;
			});

			// Chèn vào container danh sách địa chỉ
			$('#address-list-container').html(row);
		},
		error: function() {
			alert('Lỗi khi tải danh sách địa chỉ!');
		}
	});
}

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