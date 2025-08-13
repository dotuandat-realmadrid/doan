$(document).ready(function() {
    let currentPage = 1;
    let pageSize = 5;
    let currentTab = 'unread';
    let totalPages = 0;

    function loadUnreadCount() {
        $.ajax({
            url: 'http://localhost:8080/doan/contacts/messages/unread/count',
            type: 'GET',
            xhrFields: { withCredentials: true },
            success: function(response) {
                const count = response.result || 0;
                $('#unread-tab .badge').text(count);
            },
            error: function(xhr, status, error) {
                console.error('Error loading unread count:', status, error);
            }
        });
    }

    function loadContacts(isRead, page) {
        $.ajax({
            url: `http://localhost:8080/doan/contacts`,
            type: 'GET',
            data: { isRead, page, size: pageSize },
            xhrFields: { withCredentials: true },
            success: function(response) {
                if (response.code === 1000) {
                    const data = response.result || { totalPage: 0, pageSize: 5, currentPage: 1, totalElements: 0, data: [] };
                    totalPages = data.totalPage || 0;
                    renderContacts(data.data || [], isRead);
                    renderPagination(data.currentPage || 1, data.totalPage || 0);
                    toggleTabAndPagination(isRead, (data.data && data.data.length > 0));
                    updateTabStyles();
                } else {
                    console.error('Unexpected response code:', response.code);
                    const $tabPane = isRead ? $('#read') : $('#unread');
                    $tabPane.find('.card-body').html('<p class="text-center">Lỗi tải dữ liệu</p>');
                    toggleTabAndPagination(isRead, false);
                }
            },
            error: function(xhr, status, error) {
                console.error('Error loading contacts:', status, error);
                const $tabPane = isRead ? $('#read') : $('#unread');
                $tabPane.find('.card-body').html('<p class="text-center">Lỗi tải dữ liệu</p>');
                toggleTabAndPagination(isRead, false);
            }
        });
    }

    function renderContacts(contacts, isRead) {
        const $tabPane = isRead ? $('#read') : $('#unread');
        const $cardBody = $tabPane.find('.card-body');
        $cardBody.empty();

        if (contacts.length > 0) {
            contacts.forEach(contact => {
                $cardBody.append(`
                    <div class="card mb-4 rounded-4 ${isRead ? 'border-primary' : ''}">
                        <div class="card-body">
                            <div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <h5 class="card-title fw-bold mb-3">${contact.fullName}</h5>
                                    <div class="text-muted small">
                                        <i class="bi bi-clock me-1"></i>${formatDate(contact.createdDate)}
                                    </div>
                                </div>
                                <div class="text-muted mb-2">
                                    <i class="bi bi-envelope me-2"></i>${contact.email}
                                </div>
                                <div class="text-muted mb-3">
                                    <i class="bi bi-phone me-2"></i>${contact.phone}
                                </div>
                                <div class="bg-light p-3 rounded mb-3" style="word-break: break-word;">
                                    ${contact.message}
                                </div>
                            </div>
                            ${!isRead ? `
                                <div class="d-flex justify-content-end">
                                    <button class="btn btn-primary mark-as-read" data-id="${contact.id}">
                                        <i class="bi bi-check me-2"></i>Đánh dấu đã đọc
                                    </button>
                                </div>
                            ` : ''}
                        </div>
                    </div>
                `);
            });
        } else {
            $cardBody.html('<p class="text-center">Không có dữ liệu</p>');
        }
    }

    function formatDate(dateStr) {
        const date = new Date(dateStr);
        return `${padZero(date.getHours())}:${padZero(date.getMinutes())}:${padZero(date.getSeconds())} ${padZero(date.getDate())}/${padZero(date.getMonth() + 1)}/${date.getFullYear()}`;
    }

    function padZero(num) {
        return num < 10 ? '0' + num : num;
    }

    function renderPagination(current, totalPagesParam) {
        const pagination = $(`#${currentTab} .pagination`);
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

        if (totalPagesParam <= 6) {
            for (let i = 1; i <= totalPagesParam; i++) {
                addPageItem(i, i === current);
            }
        } else {
            if (current <= 3) {
                for (let i = 1; i <= 3; i++) addPageItem(i, i === current);
                addEllipsis();
                for (let i = totalPagesParam - 2; i <= totalPagesParam; i++) addPageItem(i);
            } else if (current >= totalPagesParam - 2) {
                for (let i = 1; i <= 3; i++) addPageItem(i);
                addEllipsis();
                for (let i = totalPagesParam - 2; i <= totalPagesParam; i++) addPageItem(i, i === current);
            } else {
                addPageItem(1);
                addEllipsis();
                for (let i = current - 1; i <= current + 1; i++) addPageItem(i, i === current);
                addEllipsis();
                addPageItem(totalPagesParam);
            }
        }

        const nextClass = current === totalPagesParam || totalPagesParam === 0 ? "disabled" : "";
        pagination.append(`
            <li class="page-item ${nextClass}">
                <a class="page-link" href="#" data-page="${current + 1}">»</a>
            </li>
        `);

        pagination.find('.page-link').on('click', function(e) {
            e.preventDefault();
            const page = $(this).data('page');
            if (page && page >= 1 && page <= totalPagesParam) {
                currentPage = page;
                loadContacts(currentTab === 'read', currentPage);
            }
        });
    }

    function toggleTabAndPagination(isRead, hasData) {
        const $activeTabPane = isRead ? $('#read') : $('#unread');
        const $inactiveTabPane = isRead ? $('#unread') : $('#read');
        const $activeCardBody = $activeTabPane.find('.card-body');
        const $activePagination = $activeTabPane.find('.pagination-container');

        if (hasData) {
            $activeCardBody.show();
            $activePagination.show();
        } else {
            $activeCardBody.hide();
            $activePagination.hide();
        }

        $inactiveTabPane.find('.card-body').hide();
        $inactiveTabPane.find('.pagination-container').hide();
    }

    function updateTabStyles() {
        if (currentTab === 'unread') {
            $('#unread-tab').removeClass('tab-text-dark').addClass('tab-text-primary');
            $('#read-tab').removeClass('tab-text-primary').addClass('tab-text-dark');
        } else {
            $('#unread-tab').removeClass('tab-text-primary').addClass('tab-text-dark');
            $('#read-tab').removeClass('tab-text-dark').addClass('tab-text-primary');
        }
    }

    $('#contactTabs button').on('click', function() {
        currentTab = $(this).data('bsTarget').substring(1);
        currentPage = 1;
        loadContacts(currentTab === 'read', currentPage);
        loadUnreadCount();
        updateTabStyles();
    });

    $(document).on('click', '.mark-as-read', function() {
        const id = $(this).data('id');
        if (confirm('Bạn có chắc chắn muốn đánh dấu đã đọc?')) {
            $.ajax({
                url: `http://localhost:8080/doan/contacts/${id}/mark-as-read`,
                type: 'PATCH',
                xhrFields: { withCredentials: true },
                success: function(response) {
                    loadContacts(false, currentPage);
                    loadContacts(true, 1);
                    loadUnreadCount();
                    alert('Đánh dấu đã đọc thành công!');
                },
                error: function(xhr, status, error) {
                    console.error('Error marking as read:', status, error);
                    alert('Đánh dấu đã đọc thất bại!');
                }
            });
        }
    });

    loadContacts(false, currentPage);
    loadUnreadCount();
    updateTabStyles();
});