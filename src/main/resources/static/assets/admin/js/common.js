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

	// Lấy số lượng tin nhắn chưa đọc
	$.ajax({
		url: 'http://localhost:8080/doan/contacts/messages/unread/count',
		method: 'GET',
		success: function(response) {
			if (response.code === 1000) {
				$('.badge-number.contact').text(response.result);
				$('.dropdown-header.contact').html(
					`Bạn có ${response.result} tin nhắn mới ` +
					'<a href="list-contact.html"><span class="badge rounded-pill bg-primary p-2 ms-2">Xem tất cả</span></a>'
				);
			}
		},
		error: function() {
			console.error('Lỗi khi lấy số lượng tin nhắn chưa đọc');
		}
	});

	// Lấy 5 tin nhắn chưa đọc mới nhất
	$.ajax({
		url: 'http://localhost:8080/doan/contacts',
		method: 'GET',
		data: {
			isRead: false,
			page: 1,
			size: 5
		},
		success: function(response) {
			if (response.code === 1000 && response.result.data.length > 0) {
				let messagesContainer = $('.messages');
				messagesContainer.find('.message-item').remove();
				messagesContainer.find('.dropdown-divider').remove();

				response.result.data.forEach((contact, index) => {
					let timeAgo = timeDiff(contact.createdDate);
					let messageItem = `
	                        <li class="message-item" data-created-date="${contact.createdDate}">
	                            <a href="#">
	                                <img src="assets/admin/img/messages-${index + 1}.jpg" alt="" class="rounded-circle">
	                                <div>
	                                    <h4>${contact.fullName}</h4>
	                                    <p>${contact.message.substring(0, 50)}${contact.message.length > 50 ? '...' : ''}</p>
	                                    <p>${timeAgo}</p>
	                                </div>
	                            </a>
	                        </li>
	                        <li><hr class="dropdown-divider"></li>
	                    `;
					messagesContainer.find('.dropdown-footer').before(messageItem);
				});

				// Bắt đầu cập nhật thời gian mỗi 10 giây
				setInterval(updateTimeDisplay, 10000);
			}
		},
		error: function() {
			console.error('Lỗi khi lấy danh sách tin nhắn');
		}
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

// Hàm tính thời gian chênh lệch
function timeDiff(createdDate) {
	const now = new Date();
	const created = new Date(createdDate);
	const diffMs = now - created;

	const diffSec = Math.floor(diffMs / 1000);
	if (diffSec < 60) return `${diffSec} giây trước`;

	const diffMin = Math.floor(diffSec / 60);
	if (diffMin < 60) return `${diffMin} phút trước`;

	const diffHr = Math.floor(diffMin / 60);
	if (diffHr < 24) return `${diffHr} giờ trước`;

	const diffDays = Math.floor(diffHr / 24);
	if (diffDays < 30) return `${diffDays} ngày trước`;

	// Tính số tháng gần đúng (dựa trên 30.42 ngày/tháng trung bình)
	const diffMonths = Math.floor(diffDays / 30.42);
	if (diffMonths < 12) return `${diffMonths} tháng trước`;

	// Tính số năm
	const diffYears = Math.floor(diffMonths / 12);
	return `${diffYears} năm trước`;
}

// Hàm cập nhật thời gian hiển thị
function updateTimeDisplay() {
	$('.message-item').each(function() {
		const createdDate = $(this).data('createdDate');
		if (createdDate) {
			$(this).find('p:last-child').text(timeDiff(createdDate));
		}
	});
}