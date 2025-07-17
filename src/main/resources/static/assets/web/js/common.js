/**
 * 
 */
$(document).ready(function() {
	const tabButtons = $('#custom-tab .nav-link');

	tabButtons.on('shown.bs.tab', function() {
		tabButtons.removeClass('text-primary text-muted');
		tabButtons.addClass('text-muted');
		$(this).removeClass('text-muted').addClass('text-primary');
	});

	const userId = localStorage.getItem('id');

	$('#profile-edit form').on('submit', function(e) {
		e.preventDefault(); // Ngăn reload trang
		updateProfile(userId);
	});

	$('#profile-change-password form').on('submit', function(e) {
		e.preventDefault(); // Ngăn reload trang
		changePassword();
	});

	/*// Load từ localStorage khi trang được tải
	const settings = JSON.parse(localStorage.getItem('userSettings'));
	if (settings) {
		$('#changesMade').prop('checked', settings.changesMade);
		$('#newProducts').prop('checked', settings.newProducts);
		$('#proOffers').prop('checked', settings.proOffers);
		$('#securityNotify').prop('checked', settings.securityNotify);
	}

	// Bắt sự kiện submit form
	$('#profile-settings form').on('submit', function(e) {
		e.preventDefault();

		const changesMade = $('#changesMade').is(':checked');
		const newProducts = $('#newProducts').is(':checked');
		const proOffers = $('#proOffers').is(':checked');
		const securityNotify = $('#securityNotify').is(':checked');

		// Lưu vào localStorage
		const userSettings = {
			changesMade,
			newProducts,
			proOffers,
			securityNotify
		};

		localStorage.setItem('userSettings', JSON.stringify(userSettings));

		alert('Cài đặt đã được lưu!');
	});*/

	// Gọi hàm khi mở offcanvas
	$('#offcanvasCart').on('show.bs.offcanvas', function() {
		const userId = localStorage.getItem("id");
		loadCart(userId);
	});

	// Kiểm tra trạng thái đăng nhập ***** All *****
	checkLoginStatus();

	// Xử lý sự kiện đăng xuất ***** All *****
	$('#logout').on('click', function(e) {
		e.preventDefault();
		logout();
	});
});

// Hàm cập nhật thông tin người dùng
function updateProfile(userId) {

	const formData = {
		fullName: $('#fullName').val(),
		username: $('#email').val(),
		dob: $('#dob').val(),
		phone: $('#phone').val(),
		roles: [$('#roles').val()]
	};

	if (confirm('Bạn có chắc chắn muốn cập nhật thông tin này không?')) {
		$.ajax({
			url: `/doan/users/${userId}`,
			type: 'PUT',
			contentType: 'application/json',
			xhrFields: {
				withCredentials: true  // bắt buộc nếu muốn gửi cookie/token trong request
			},
			data: JSON.stringify(formData),
			success: function(response) {
				alert('Cập nhật thông tin thành công!');
				location.reload();
			},
			error: function(xhr) {
				alert('Cập nhật thất bại!');
				console.error(xhr.responseText);
			}
		});
	}
}

// Hàm thay đổi mật khẩu
function changePassword() {
	const oldPassword = $('#currentPassword').val();
	const newPassword = $('#newPassword').val();
	const renewPassword = $('#renewPassword').val();

	if (!oldPassword || !newPassword || !renewPassword) {
		alert("Vui lòng điền đầy đủ mật khẩu!");
		return;
	}

	if (newPassword !== renewPassword) {
		alert('Mật khẩu không khớp!');
		return;
	}

	if (confirm('Bạn có chắc chắn thay đổi mật khẩu không?')) {
		$.ajax({
			url: `/doan/password/change`,
			type: 'PUT',
			contentType: 'application/json',
			xhrFields: {
				withCredentials: true  // bắt buộc nếu muốn gửi cookie/token trong request
			},
			data: JSON.stringify({
				oldPassword: oldPassword,
				newPassword: newPassword
			}),
			success: function(response) {
				alert('Cập nhật mật khẩu thành công!');
				location.reload();
			},
			error: function(xhr) {
				alert('Cập nhật mật khẩu thất bại!');
				console.error(xhr.responseText);
			}
		});
	}
}

function loadCart(userId) {
	$.ajax({
		url: `/doan/cart/${userId}`,
		method: 'GET',
		success: function(response) {
			console.log('Cart API response:', response);
			const cartItemsContainer = $('#cart-items');
			const cartCountBadge = $('#cart-count');
			const $viewCartButton = $('.btn-view-cart');
			const $checkoutButton = $('.btn-view-order');

			// Kiểm tra phản hồi API
			if (!response || !response.result || !Array.isArray(response.result.items)) {
				console.error('Giỏ hàng không hợp lệ:', response);
				cartItemsContainer.find('li:not(:last)').remove();
				cartItemsContainer.find('li:last strong').text('0 VNĐ');
				cartCountBadge.text('0');
				cartItemsContainer.prepend('<li class="list-group-item text-center text-muted">Chưa có sản phẩm nào</li>');
				$viewCartButton.hide();
				$checkoutButton.hide();
				return;
			}

			const items = response.result.items;
			let total = 0;

			// Xóa tất cả trừ dòng Total (dòng cuối)
			cartItemsContainer.find('li:not(:last)').remove();

			// Kiểm tra nếu không có sản phẩm
			if (items.length === 0) {
				cartItemsContainer.find('li:last strong').text('0 VNĐ');
				cartCountBadge.text('0');
				cartItemsContainer.prepend('<li class="list-group-item text-center text-muted">Chưa có sản phẩm nào</li>');
				$viewCartButton.hide();
				$checkoutButton.hide();
				return;
			}

			// Hiển thị các nút khi có sản phẩm
			$viewCartButton.show();
			$checkoutButton.show();

			items.forEach(item => {
				const name = item.productName;
				const price = item.discountPrice !== null ? item.discountPrice : item.price;
				const quantity = item.quantity;
				const productId = item.productId; // Giả sử API trả về productId
				const itemTotal = price * quantity;
				total += itemTotal;

				const cartItem = `
                    <li class="list-group-item d-flex justify-content-between lh-sm" data-product-id="${productId}">
                        <div style="width: 60%;">
                            <h6 class="my-0">${name}</h6>
                            <div class="quantity-input">
                                <button class="minus">−</button>
                                <input type="text" min="1" value="${quantity}" class="quantity">
                                <button class="plus">+</button>
                            </div>
                        </div>
                        <span class="text-body-secondary">${itemTotal.toLocaleString()} VNĐ</span>
                    </li>
                `;
				$(cartItem).insertBefore(cartItemsContainer.find('li:last'));
			});

			// Cập nhật tổng tiền
			cartItemsContainer.find('li:last strong').text(`${total.toLocaleString()} VNĐ`);

			// Cập nhật badge số lượng
			$('#cart-count').text(items.length);

			// Gán sự kiện cho các nút plus và minus
			$('.plus').off('click').on('click', function() {
				const $li = $(this).closest('li');
				const productId = $li.data('product-id');
				const $input = $li.find('.quantity');
				let currentQuantity = parseInt($input.val());
				const newQuantity = currentQuantity + 1;

				$.ajax({
					url: 'http://localhost:8080/doan/cart/items',
					method: 'POST',
					contentType: 'application/json',
					data: JSON.stringify({
						userId: userId,
						productId: productId,
						quantity: 1,
						updatedQuantity: 1
					}),
					success: function() {
						loadCart(userId); // Làm mới giỏ hàng
					},
					error: function() {
						alert('Không thể cập nhật số lượng.');
					}
				});
			});

			$('.minus').off('click').on('click', function() {
				const $li = $(this).closest('li');
				const productId = $li.data('product-id');
				const $input = $li.find('.quantity');
				let currentQuantity = parseInt($input.val());
				if (currentQuantity > 0) {
					$.ajax({
						url: 'http://localhost:8080/doan/cart/items',
						method: 'POST',
						contentType: 'application/json',
						data: JSON.stringify({
							userId: userId,
							productId: productId,
							quantity: 1,
							deletedQuantity: 1
						}),
						success: function() {
							loadCart(userId); // Làm mới giỏ hàng
						},
						error: function() {
							alert('Không thể cập nhật số lượng.');
						}
					});
				}
			});
		},
		error: function(xhr, status, error) {
			if (xhr.status === 401) {
				window.location.href = "login.html";
			} else {
				alert("Không thể tải giỏ hàng.");
				console.log(xhr.responseText, status, error);
			}

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
			if (response && response.code === 1000 && response.result) {
				const user = response.result;
				localStorage.setItem("id", user.id);
				$('#email').val(user.username); // Điền email từ username
				$('#user-name').text(user.fullName || 'Unknown User');
				$('#user-role').text(user.roles && user.roles.length > 0 ? user.roles.join(', ') : 'User');
				$(".full-name").text(user.fullName || 'Unknown User');
				$('.user-role').text(user.roles && user.roles.length > 0 ? user.roles.join(', ') : 'User');
				$(".fullName").text(user.fullName || 'Unknown User');
				$('.email').text(user.username || 'Unknown User');
				$(".dob").text(user.dob || 'Unknown User');
				$(".phone").text(user.phone || 'Unknown User');
				$('.roles').text(user.roles && user.roles.length > 0 ? user.roles.join(', ') : 'User');
				$('.createdDate').text(formatVietnamTime(user.createdDate) || 'Unknown User');
				$('.createdBy').text(user.createdBy || 'Unknown User');
				$('.modifiedDate').text(formatVietnamTime(user.modifiedDate) || 'Unknown User');
				$('.modifiedBy').text(user.modifiedBy || 'Unknown User');
				$("#fullName").val(user.fullName || 'Unknown User');
				$('#email').val(user.username || 'Unknown User');
				$("#dob").val(user.dob || 'Unknown User');
				$("#phone").val(user.phone || 'Unknown User');
				$('#roles').val(user.roles && user.roles.length > 0 ? user.roles.join(', ') : 'User');
				$('#createdDate').val(formatVietnamTime(user.createdDate) || 'Unknown User');
				$('#createdBy').val(user.createdBy || 'Unknown User');
				$('#modifiedDate').val(formatVietnamTime(user.modifiedDate) || 'Unknown User');
				$('#modifiedBy').val(user.modifiedBy || 'Unknown User');

				// Kiểm tra vai trò ADMIN hoặc STAFF_INVENTORY
				if (user.roles && (user.roles.includes('ADMIN') || user.roles.includes('STAFF_INVENTORY'))) {
					$('#admin-link').show();
					$('#admin-menu').show();
				} else {
					$('#admin-link').hide();
					$('#admin-menu').hide();
				}

				// Hiển thị profile menu, ẩn login link
				$('#profile-menu').show();
				$('#login-link').hide();
			} else {
				showLoginLink();
			}
		},
		error: function(xhr, status, error) {
			console.error('Error checking login status:', status, error, xhr.responseText);
			showLoginLink();
		}
	});
}

function formatVietnamTime(dateString) {
	if (!dateString) return 'Unknown User';

	try {
		const vietnamTime = new Date(dateString).toLocaleString('vi-VN', {
			timeZone: 'Asia/Ho_Chi_Minh',
			hour12: false
		});
		return vietnamTime;
	} catch (error) {
		console.error('Lỗi khi chuyển đổi ngày giờ:', error);
		return 'Invalid Date';
	}
}

// Hàm hiển thị đăng nhập hoặc chưa đăng nhập ***** All *****
function showLoginLink() {
	$('#profile-menu').hide();
	$('#login-link').show();
	$('#admin-link').hide();
	$('#admin-menu').hide();
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
			window.location.href = 'index.html';
		},
		error: function(xhr, status, error) {
			console.error('Logout error:', status, error, xhr.responseText);
			// Xóa cookie và chuyển hướng để đảm bảo đăng xuất
			document.cookie = 'token=; Max-Age=0; path=/;';
			window.location.href = 'login.html';
		}
	});
}

// Chuyển trang cart - order
$('.btn-lg.btn-view-cart').on('click', function(e) {
	e.preventDefault();
	checkLoginStatus();
	const userId = localStorage.getItem("id");
	if (!userId) {
		alert("Bạn chưa đăng nhập!");
		if (confirm("Bạn cần đăng nhập để xem giỏ hàng. Bạn có muốn đăng nhập ngay không?")) {
			window.location.href = "login.html";
		}
		return;
	}
	window.location.href = "cart.html";
});

$('.btn-view-order').on('click', function(e) {
	e.preventDefault();
	checkLoginStatus();
	const userId = localStorage.getItem("id");
	if (!userId) {
		alert("Bạn chưa đăng nhập!");
		if (confirm("Bạn cần đăng nhập để đặt hàng. Bạn có muốn đăng nhập ngay không?")) {
			window.location.href = "login.html";
		}
		return;
	}
	window.location.href = "order.html";
});

document.addEventListener("DOMContentLoaded", function() {
	window.togglePassword = function(inputId, iconEl) {
		const input = document.getElementById(inputId);
		const isPassword = input.type === "password";

		input.type = isPassword ? "text" : "password";

		// Đổi icon class
		iconEl.classList.toggle("bi-eye");
		iconEl.classList.toggle("bi-eye-slash");
	};
});