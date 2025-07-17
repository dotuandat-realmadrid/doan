$(document).ready(function() {
    $('#login').click(function(e) {
        e.preventDefault(); // Ngăn form reload lại trang

        const username = $('#yourUsername').val();
        const password = $('#yourPassword').val();

        if (!username || !password) {
            alert('Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu');
            return;
        }

        $.ajax({
            url: 'http://localhost:8080/doan/auth/login',
            method: 'POST',
            contentType: 'application/json',
            xhrFields: {
                withCredentials: true // Gửi cookie/token trong request
            },
            data: JSON.stringify({
                username: username,
                password: password
            }),
            success: function(response) {
                window.location.href = 'index.html'; // Chuyển đến trang chính sau khi login
            },
            error: function(xhr) {
                const message = xhr.responseJSON?.message || 'Đăng nhập thất bại. Vui lòng kiểm tra lại!';
                alert(message);
            }
        });
    });

    $('#register').click(function(e) {
        e.preventDefault(); // Ngăn form reload lại trang

        // Lấy giá trị các trường
        const fullName = document.querySelector('#fullName').value;
        const email = document.querySelector('#email').value;
        const phone = document.querySelector('#phone').value;
        const password = document.querySelector('#password').value;
        const renewPassword = document.querySelector('#renewPassword').value;

        // Danh sách các trường cần validate
        const fields = ['#fullName', '#email', '#phone', '#password', '#renewPassword', '#acceptTerms'];

        // Xóa class invalid cũ
        fields.forEach(field => {
            const element = document.querySelector(field);
            if (element) element.classList.remove('is-invalid');
        });

        // Kiểm tra trường rỗng
        if (!fullName || !phone || !email || !password || !renewPassword || !document.querySelector('#acceptTerms').checked) {
            alert('Vui lòng nhập đầy đủ thông tin!');

            // Thêm class invalid cho từng trường rỗng
            if (!fullName) document.querySelector('#fullName').classList.add('is-invalid');
            if (!email) document.querySelector('#email').classList.add('is-invalid');
            if (!phone) document.querySelector('#phone').classList.add('is-invalid');

            return;
        }

        // Kiểm tra mật khẩu khớp
        if (password !== renewPassword) {
            alert('Mật khẩu không khớp!');
            document.querySelector('#re-enterPassword').classList.add('is-invalid');
            return;
        }

        // Gửi yêu cầu đăng ký
        $.ajax({
            url: 'http://localhost:8080/doan/users',
            method: 'POST',
            xhrFields: {
                withCredentials: true // Gửi cookie/token trong request
            },
            contentType: 'application/json',
            data: JSON.stringify({
                fullName: fullName,
                username: email,
                phone: phone,
                password: password,
                roles: ["CUSTOMER"]
            }),
            success: function(response) {
                // Đăng ký thành công, tự động đăng nhập
                $.ajax({
                    url: 'http://localhost:8080/doan/auth/login',
                    method: 'POST',
                    xhrFields: {
                        withCredentials: true // Gửi cookie/token trong request
                    },
                    contentType: 'application/json',
                    data: JSON.stringify({
                        username: email,
                        password: password
                    }),
                    success: function(loginResponse) {
                        window.location.href = 'index.html'; // Chuyển đến trang chính sau khi đăng nhập
                    },
                    error: function(xhr) {
                        const message = xhr.responseJSON?.message || 'Đăng nhập tự động thất bại. Vui lòng đăng nhập thủ công!';
                        alert(message);
                        window.location.href = 'login.html'; // Chuyển đến trang đăng nhập nếu đăng nhập thất bại
                    }
                });
            },
            error: function(xhr) {
                let message = 'Đăng ký thất bại. Vui lòng kiểm tra lại!';
                if (xhr.responseJSON) {
                    if (xhr.responseJSON.message) {
                        message = xhr.responseJSON.message;
                    } else if (xhr.responseJSON.errors) {
                        message = xhr.responseJSON.errors.map(err => `${err.field}: ${err.defaultMessage}`).join('\n');
                    }
                }
                alert(message);
            }
        });
    });
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