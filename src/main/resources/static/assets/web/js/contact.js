$(document).ready(function() {
    // Xử lý sự kiện submit của form
    $('#contactForm').on('submit', function(e) {
        e.preventDefault(); // Ngăn chặn hành vi submit mặc định của trình duyệt

        // Thu thập dữ liệu từ form
        const contactData = {
            fullName: $('#FullName').val().trim(),
            email: $('#Email').val().trim(),
            phone: $('#Phone').val().trim(),
            message: $('#Message').val().trim()
        };

        // Kiểm tra dữ liệu đầu vào
        if (!contactData.fullName || !contactData.email || !contactData.phone || !contactData.message) {
            alert('Vui lòng điền đầy đủ tất cả các trường!');
            return;
        }

        // Gửi yêu cầu AJAX
        $.ajax({
            url: 'http://localhost:8080/doan/contacts',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(contactData),
            xhrFields: { withCredentials: true },
            success: function(response) {
                console.log('Contact API response:', response);
                if (response.code === 1000 && response.result) {
                    alert('Gửi thông tin liên hệ thành công!');
                    // Reset form sau khi gửi thành công
                    $('#contactForm')[0].reset();
                } else {
                    throw new Error('Invalid response format');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error submitting contact form:', status, error, xhr.responseText);
                if (xhr.status === 401) {
                    alert('Phiên đăng nhập hết hạn. Vui lòng đăng nhập lại.');
                    window.location.href = 'login.html';
                } else {
                    alert('Không thể gửi thông tin liên hệ. Vui lòng thử lại.');
                }
            }
        });
    });
});