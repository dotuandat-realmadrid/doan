/**
 * 
 */
let refreshCount = 0;

function refresh() {
    if (refreshCount === 0) {
        refreshCount = 1; // Tăng counter
        
        $.ajax({
            url: 'http://localhost:8080/doan/auth/refresh',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({}),
            xhrFields: { withCredentials: true },
            success: function(response) {
                alert("Bạn đã refresh thành công!");
                refreshCount = 0; // Reset khi thành công
            },
            error: function(xhr, status, error) {
                console.log('Refresh failed, logging out...');
                localStorage.removeItem("id");
                document.cookie = 'token=; Max-Age=0; path=/;';
                window.location.href = 'login.html';
            }
        });
    } else {
        console.log('Already refreshed once, logging out...');
        localStorage.removeItem("id");
        document.cookie = 'token=; Max-Age=0; path=/;';
        window.location.href = 'login.html';
    }
}

// Tự động gọi khi có lỗi 401
$(document).ajaxError(function(event, xhr, settings) {
    if (xhr.status === 401) {
        refresh();
    }
});