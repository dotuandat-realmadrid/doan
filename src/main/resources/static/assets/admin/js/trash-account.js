$(document).ready(function() {
    let currentPage = 1;
    let pageSize = 5;
    let intervalId = null;

    function fetchUsers(page = 1, size = 5) {
        $.ajax({
            url: `http://localhost:8080/doan/users/trash?page=${page}&size=${size}`,
            method: "GET",
            xhrFields: { withCredentials: true },
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
                } else if (xhr.status === 403) {
                    alert("Bạn không có quyền!");
                    window.location.href = "home.html";
                } else {
                    const message = xhr.responseJSON?.message || "Không thể tải danh sách người dùng.";
                    console.error(message);
                }
            }
        });
    }

    function renderTable(users) {
        $(".table-hover tbody").empty();
        users.forEach((user, index) => {
            let guest = user.user.isGuest === 1 ? '<a class="btn btn-sm btn-outline-warning btn-buttons me-1 mb-1">Khách</a>' : '';
            let active = user.user.isActive === 0 ? '<a class="btn btn-sm btn-outline-danger btn-buttons mb-1">Không hoạt động</a>' : '';

            const roles = user.user.roles.map(role => {
                switch (role) {
                    case "STAFF_INVENTORY": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Nhân viên kiểm kho</a>`;
                    case "CUSTOMER": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Khách hàng</a>`;
                    case "STAFF_SALE": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Nhân viên bán hàng</a>`;
                    case "ADMIN": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Admin</a>`;
                    case "STAFF_CUSTOMER_SERVICE": return `<a class="btn btn-sm btn-outline-primary btn-buttons me-1 mb-1">Nhân viên chăm sóc khách hàng</a>`;
                    default: return `<span class="text-muted me-1 mb-1">Chưa phân quyền</span>`;
                }
            }).join('');

            const stt = (currentPage - 1) * pageSize + index + 1;
            const deletedDate = user.deletedDate || '';

            const row = `
                <tr data-user-id="${user.user.id}">
                    <th scope="row" class="text-center align-middle">${stt}</th>
                    <td class="align-middle">
                        <div class="d-flex">
                            <div class="text-center align-middle">
                                <i class="bi bi-person-circle text-primary" style="font-size: 30px;"></i>
                            </div>
                            <div class="ps-3">
                                <div>${user.user.fullName}</div>
                                <div class="text-muted font_size">ID: ${user.user.id}</div>
                            </div>
                            <div class="align-middle ps-2 w-auto">${guest} ${active}</div>
                        </div>
                    </td>
                    <td class="align-middle w-auto">
                        <div class="d-flex flex-wrap">${roles}</div>
                    </td>
                    <td class="align-middle">
                        <div><i class="bi bi-envelope text-primary"></i> ${user.user.username}</div>
                        <div><i class="bi bi-telephone text-success"></i> ${user.user.phone || "xxxxxxxxxx"}</div>
                    </td>
                    <td class="align-middle">${user.user.dob || "N/A"}</td>
                    <td class="align-middle font_size">
                        <span class="btn btn-sm btn-secondary remaining-time" data-deleted-date="${deletedDate}"></span>
                    </td>
                    <td class="text-center align-middle">
                        <button class="btn btn-sm btn-outline-success border-0 restore-user" data-user-id="${user.user.id}" title="Khôi phục">
                            <i class="bi bi-arrow-counterclockwise"></i>
                        </button>
                    </td>
                </tr>
            `;
            $(".table-hover tbody").append(row);
        });

        updateRemainingTime();
        
        $(".restore-user").on("click", function() {
            const userId = $(this).data("user-id");
            if (!userId) {
                alert("Không tìm thấy userId");
                return;
            }
            if (confirm("Bạn có chắc chắn muốn khôi phục tài khoản này?")) {
                $.ajax({
                    url: `http://localhost:8080/doan/users/restore/${userId}`,
                    method: "PUT",
                    xhrFields: { withCredentials: true },
                    success: function() {
                        alert("Khôi phục tài khoản thành công!");
                        fetchUsers(currentPage, pageSize);
                    },
                    error: function(xhr) {
                        const message = xhr.responseJSON?.message || "Không thể khôi phục tài khoản.";
                        if (xhr.responseJSON?.code === "NO_RESTORABLE_USERS") {
                            alert("Tài khoản đã hết hạn khôi phục (quá 60 ngày).");
                        } else {
                            alert(message);
                        }
                    }
                });
            }
        });
    }

    function updateRemainingTime() {
        const vietnamTime = moment().tz("Asia/Ho_Chi_Minh");
        console.log("Updating time at:", vietnamTime.format("YYYY-MM-DD HH:mm:ss Z"));

        $(".remaining-time").each(function() {
            const deletedDateStr = $(this).data("deleted-date");
            let buttonClass = "btn-secondary";
            let remainingTimeText = "Hết hạn";

            if (deletedDateStr) {
                const deletedDate = moment.tz(deletedDateStr, "Asia/Ho_Chi_Minh");
                if (!deletedDate.isValid()) {
                    console.warn(`Định dạng deletedDate không hợp lệ: ${deletedDateStr}`);
                } else {
                    const expiryDate = deletedDate.clone().add(60, 'days');
                    const totalMinutes = Math.max(0, Math.floor(vietnamTime.diff(expiryDate, 'minutes') * -1));

                    console.log(`User ${$(this).closest("tr").data("user-id")}: deletedDate=${deletedDate.format("YYYY-MM-DD HH:mm:ss Z")}, expiryDate=${expiryDate.format("YYYY-MM-DD HH:mm:ss Z")}, totalMinutes=${totalMinutes}`);

                    if (totalMinutes > 0) {
                        const days = Math.floor(totalMinutes / (24 * 60));
                        const hours = Math.floor((totalMinutes % (24 * 60)) / 60);
                        const minutes = totalMinutes % 60;
                        remainingTimeText = `${days} ngày ${hours} giờ ${minutes} phút`;

                        const threshold20Days = 20 * 24 * 60;
                        const threshold40Days = 40 * 24 * 60;
                        if (totalMinutes <= threshold20Days) {
                            buttonClass = "btn-danger";
                        } else if (totalMinutes <= threshold40Days) {
                            buttonClass = "btn-warning";
                        } else {
                            buttonClass = "btn-success";
                        }
                    }
                }
            }

            $(this).text(remainingTimeText).removeClass("btn-danger btn-warning btn-success btn-secondary").addClass(buttonClass);
        });
    }

    function startInterval() {
        if (intervalId !== null) {
            clearInterval(intervalId);
            console.log("Cleared previous interval");
        }
        intervalId = setInterval(() => {
            updateRemainingTime();
            console.log("Interval triggered");
        }, 60 * 1000);
    }

    updateRemainingTime();
    startInterval();

    document.addEventListener("visibilitychange", () => {
        if (document.visibilityState === "hidden") {
            clearInterval(intervalId);
            intervalId = null;
            console.log("Interval stopped: tab hidden");
        } else {
            startInterval();
            updateRemainingTime(); // Cập nhật ngay khi tab hiển thị
            console.log("Interval restarted: tab visible");
        }
    });

    $(window).on("beforeunload", () => {
        clearInterval(intervalId);
        intervalId = null;
        console.log("Interval stopped on beforeunload");
    });

    function renderPagination(current, totalPages) {
        const pagination = $(".pagination");
        pagination.empty();

        const prevClass = current === 1 ? "disabled" : "";
        pagination.append(`
            <li class="page-item ${prevClass}">
                <a class="page-link" href="#" data-page="${current - 1}">«</a>
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

        const nextClass = current === totalPages ? "disabled" : "";
        pagination.append(`
            <li class="page-item ${nextClass}">
                <a class="page-link" href="#" data-page="${current + 1}">»</a>
            </li>
        `);
    }

    $(document).on("click", ".pagination a", function(e) {
        e.preventDefault();
        const selectedPage = $(this).data("page");
        if (selectedPage >= 1) {
            currentPage = selectedPage;
            fetchUsers(currentPage, pageSize);
        }
    });

    fetchUsers(currentPage, pageSize);
});