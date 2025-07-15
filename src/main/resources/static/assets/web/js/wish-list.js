/**
 * Hàm lấy query parameter từ URL
 */
function getQueryParam(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}

/**
 * Hàm kiểm tra trạng thái yêu thích của một sản phẩm
 */
function checkWishlistStatus(userId, productId, callback) {
    if (!userId) {
        callback(false);
        return;
    }
    $.ajax({
        url: `http://localhost:8080/doan/wish-list/${userId}/check/${productId}`,
        method: 'GET',
        xhrFields: { withCredentials: true },
        success: function(response) {
            if (response.code === 1000) {
                callback(response.result || false);
            } else {
                callback(false);
            }
        },
        error: function(xhr, status, error) {
            console.error(`Error checking wishlist status for product ${productId}: ${status} - ${error} - ${xhr.responseText}`);
            callback(false);
        }
    });
}

$(document).ready(function() {
    const userId = localStorage.getItem("id");
    const page = getQueryParam('page') || 1;
    
    // Lấy danh sách sản phẩm yêu thích
    if (userId) {
        loadWishlist(userId, page);
    } else {
        $('.row.g-4').empty().append('<p class="w-100 text-center text-muted py-4">Vui lòng đăng nhập để xem danh sách yêu thích.</p>');
        $('#pagination-container').hide();
    }

    // Hàm tìm kiếm sản phẩm
    $('#search-form').submit(function(e) {
        e.preventDefault();
        const name = $('#search-input').val().trim();
        if (name !== '') {
            window.location.href = `search.html?name=${encodeURIComponent(name)}`;
        }
    });
});

// Hàm lấy danh sách sản phẩm yêu thích
function loadWishlist(userId, page) {
    $.ajax({
        url: `http://localhost:8080/doan/wish-list/${userId}`,
        type: 'GET',
        data: {
            page: page,
            size: 12
        },
        xhrFields: { withCredentials: true },
        success: function(response) {
            // Kiểm tra phản hồi từ API
            if (!response || !response.result || !Array.isArray(response.result.data)) {
                console.error('Invalid API response:', response);
                $('.row.g-4').empty().append('<h1 class="w-100 text-center text-muted py-4">Không tìm thấy sản phẩm nào trong danh sách yêu thích.</h1>');
                $('#pagination-container').hide();
                return;
            }

            const products = response.result.data;
            const totalPages = response.result.totalPage || 1;
            const currentPage = response.result.currentPage || 1;
            const container = $('.row.g-4');
            container.empty();

            if (products.length === 0) {
                console.log('No products found in wishlist.');
                $('#pagination-container').hide();
                container.append('<h1 class="w-100 text-center text-muted py-4">Không tìm thấy sản phẩm nào trong danh sách yêu thích.</h1>');
            } else {
                console.log('Showing wishlist products:', products.length);
                $('#pagination-container').show();

                // Kiểm tra trạng thái yêu thích (mặc định true vì đây là danh sách yêu thích)
                let checkPromises = products.map(product =>
                    new Promise(resolve => {
                        checkWishlistStatus(userId, product.id, isFavorited => {
                            resolve({ product, isFavorited });
                        });
                    })
                );

                Promise.all(checkPromises).then(results => {
                    results.forEach(({ product, isFavorited }, index) => {
                        const delay = (0.1 + index * 0.15).toFixed(2);
                        const inventoryQuantity = product.inventoryQuantity || 0;
                        const initialValue = inventoryQuantity > 0 ? 1 : 0;

                        const html = `
                            <div class="col-xl-3 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="${delay}s">
                                <div class="product-item" data-product="${product.code}" data-product-id="${product.id}">
                                    <figure>
                                        <a href="product-detail.html?code=${encodeURIComponent(product.code)}" title="${product.name}">
                                            <img src="/doan/uploads/${product.images?.[0] || 'assets/web/img/product-thumb-7.png'}" alt="${product.name}" class="tab-image">
                                        </a>
                                    </figure>
                                    <div class="d-flex flex-column text-center">
                                        <h3 class="fs-6 fw-normal">${product.name}</h3>
                                        <div>
                                            <span class="rating">
                                                ${generateStars(product.avgRating || 0)}
                                            </span>
                                            <span>(${product.reviewCount || 0})</span>
                                        </div>
                                        ${product.discountName ? `
                                        <div>
                                            <span class="badge border border-dark-subtle rounded-0 fw-normal px-1 fs-7 lh-1 text-muted">
                                                ${product.discountName}
                                            </span>
                                        </div>` : ''}
                                        <div class="d-flex justify-content-center align-items-center gap-2">
                                            ${product.discountPrice == null ?
                                                `<span class="text-dark fw-semibold">$${(product.price / 1000).toFixed(2)}K</span>` :
                                                `<del>$${(product.price / 1000).toFixed(2)}K</del>
                                                 <span class="text-dark fw-semibold">$${(product.discountPrice / 1000).toFixed(2)}K</span>`
                                            }
                                        </div>
                                        <div class="button-area p-3 pt-0">
                                            <div class="row g-1 mt-2">
                                                <div class="col-3">
                                                    <input type="number" name="quantity" 
                                                           class="form-control border-dark-subtle input-number quantity" 
                                                           value="${initialValue}" 
                                                           min="0" 
                                                           max="${inventoryQuantity}"
                                                           ${inventoryQuantity <= 0 ? 'readonly' : ''}>
                                                </div>
                                                <div class="col-7">
                                                    <a href="#" class="btn btn-primary rounded-1 p-2 fs-7 btn-cart ${inventoryQuantity <= 0 ? 'disabled' : ''}">
                                                        <svg width="18" height="18"><use xlink:href="#cart"></use></svg> Add to Cart
                                                    </a>
                                                </div>
                                                <div class="col-2">
                                                    <a href="#" class="btn rounded-1 p-2 fs-6 btn-wishlist">
                                                        <i class="bi ${isFavorited ? 'bi-heart-fill text-danger' : 'bi-heart'}" style="font-size: 18px;"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>`;

                        // Tạo jQuery element và gắn sự kiện
                        const $element = $(html);
                        attachAddToCartHandler($element);
                        attachWishlistHandler($element);
                        container.append($element);
                    });

                    renderPagination(currentPage, totalPages, { userId });
                    handleQuantityInputs();
                });
            }
        },
        error: function(xhr, status, error) {
            console.error('API error:', status, error, xhr.responseText);
            $('.row.g-4').empty().append('<p class="w-100 text-center text-muted py-4">Lỗi khi tải danh sách yêu thích. Vui lòng thử lại.</p>');
            $('#pagination-container').hide();
        }
    });
}

// Hàm phân trang
function renderPagination(currentPage, totalPages, data) {
    const paginationContainer = $('#pagination-container');
    paginationContainer.empty();

    const createPageItem = (page, text, active = false, disabled = false) => {
        return `<li class="page-item ${active ? 'active' : ''} ${disabled ? 'disabled' : ''}">
                    <a class="page-link" href="#" data-page="${page}">${text}</a>
                </li>`;
    };

    paginationContainer.append(createPageItem(currentPage - 1, '«', false, currentPage === 1));

    if (totalPages <= 6) {
        for (let i = 1; i <= totalPages; i++) {
            paginationContainer.append(createPageItem(i, i, i === currentPage));
        }
    } else {
        if (currentPage <= 3) {
            for (let i = 1; i <= 3; i++) {
                paginationContainer.append(createPageItem(i, i, i === currentPage));
            }
            paginationContainer.append(createPageItem(null, '...', false, true));
            for (let i = totalPages - 2; i <= totalPages; i++) {
                paginationContainer.append(createPageItem(i, i, i === currentPage));
            }
        } else if (currentPage >= totalPages - 2) {
            for (let i = 1; i <= 3; i++) {
                paginationContainer.append(createPageItem(i, i, i === currentPage));
            }
            paginationContainer.append(createPageItem(null, '...', false, true));
            for (let i = totalPages - 2; i <= totalPages; i++) {
                paginationContainer.append(createPageItem(i, i, i === currentPage));
            }
        } else {
            paginationContainer.append(createPageItem(1, 1, 1 === currentPage));
            paginationContainer.append(createPageItem(null, '...', false, true));
            for (let i = currentPage - 1; i <= currentPage + 1; i++) {
                paginationContainer.append(createPageItem(i, i, i === currentPage));
            }
            paginationContainer.append(createPageItem(null, '...', false, true));
            paginationContainer.append(createPageItem(totalPages, totalPages, totalPages === currentPage));
        }
    }

    paginationContainer.append(createPageItem(currentPage + 1, '»', false, currentPage === totalPages));

    paginationContainer.find('.page-link').click(function(e) {
        e.preventDefault();
        const page = parseInt($(this).data('page'));
        if (!isNaN(page) && page >= 1 && page <= totalPages) {
            loadWishlist(data.userId, page);
        }
    });
}

// Hàm xử lý sự kiện cho các input số lượng
function handleQuantityInputs() {
    $('.input-number').each(function() {
        const $input = $(this);
        const max = parseInt($input.attr('max')) || 0;

        // Kiểm tra khi thay đổi giá trị
        $input.on('change input', function() {
            let value = parseInt($input.val()) || 0;

            if (value < 0) {
                $input.val(0);
            } else if (value > max) {
                $input.val(max);
            }
        });
    });
}

// Hàm tính sao đánh giá
function generateStars(rating) {
    let fullStars = Math.floor(rating);
    let halfStar = rating % 1 >= 0.5;
    let starsHtml = "";

    for (let i = 0; i < fullStars; i++) {
        starsHtml += `<svg width="18" height="18" class="text-warning"><use xlink:href="#star-full"></use></svg>`;
    }
    if (halfStar) {
        starsHtml += `<svg width="18" height="18" class="text-warning"><use xlink:href="#star-half"></use></svg>`;
    }

    // Thêm sao rỗng nếu cần
    const emptyStars = 5 - fullStars - (halfStar ? 1 : 0);
    for (let i = 0; i < emptyStars; i++) {
        starsHtml += `<svg width="18" height="18" class="text-warning"><use xlink:href="#star-empty"></use></svg>`;
    }

    return starsHtml;
}

// Hàm thêm vào giỏ hàng
function attachAddToCartHandler($element) {
    $element.find('.btn-cart').on('click', function(e) {
        e.preventDefault();

        const $productItem = $(this).closest('.product-item');
        const productId = $productItem.data('product-id');
        const quantity = parseInt($productItem.find('.quantity').val());
        const userId = localStorage.getItem("id");

        if (quantity <= 0) {
            alert('Vui lòng chọn số lượng hợp lệ.');
            return;
        }

        $.ajax({
            url: 'http://localhost:8080/doan/cart/items',
            method: 'POST',
            contentType: 'application/json',
            xhrFields: {
                withCredentials: true
            },
            data: JSON.stringify({
                userId: userId,
                productId: productId,
                quantity: quantity,
                updatedQuantity: quantity
            }),
            success: function() {
                alert('Thêm vào giỏ hàng thành công!');
                loadCart(userId);
            },
            error: function(xhr, status, error) {
                if (xhr.status === 401) {
                    if (confirm("Bạn cần đăng nhập để thêm vào giỏ hàng. Bạn có muốn đăng nhập ngay không?")) {
                        window.location.href = "login.html";
                    }
                } else {
                    console.error('Error adding to cart:', status, error, xhr.responseText);
                    alert('Không thể thêm vào giỏ hàng. Vui lòng thử lại.');
                }
            }
        });
    });
}

// Hàm toggle sản phẩm trong danh sách yêu thích
function attachWishlistHandler($element) {
    $element.find('.btn-wishlist').on('click', function(e) {
        e.preventDefault();

        const $productItem = $(this).closest('.product-item');
        const productId = $productItem.data('product-id');
        const userId = localStorage.getItem("id");
        const $heartIcon = $(this).find('i');

        if (!userId) {
            if (confirm("Bạn cần đăng nhập để thêm/xóa danh sách yêu thích. Bạn có muốn đăng nhập ngay không?")) {
                window.location.href = "login.html";
            }
            return;
        }

        const isFavorited = $heartIcon.hasClass('bi-heart-fill');
        console.log(`Toggling wishlist for product ${productId}, user ${userId}, currently favorited: ${isFavorited}`);

        $.ajax({
            url: `http://localhost:8080/doan/wish-list/${userId}/${productId}`,
            method: 'POST',
            contentType: 'application/json',
            xhrFields: {
                withCredentials: true
            },
            success: function(response) {
                console.log('Toggle wishlist response:', response);
                if (response.code === 1000) {
                    // Toggle biểu tượng heart
                    if (isFavorited) {
                        $heartIcon.removeClass('bi-heart-fill text-danger').addClass('bi-heart');
                        alert('Đã xóa khỏi danh sách yêu thích!');
                        // Tải lại danh sách yêu thích sau khi xóa
                        const page = getQueryParam('page') || 1;
                        loadWishlist(userId, page);
                    } else {
                        $heartIcon.removeClass('bi-heart').addClass('bi-heart-fill text-danger');
                        alert('Đã thêm vào danh sách yêu thích!');
                    }
                    // Cập nhật lại trạng thái yêu thích
                    checkWishlistStatus(userId, productId, isFavorited => {
                        $heartIcon.toggleClass('bi-heart', !isFavorited);
                        $heartIcon.toggleClass('bi-heart-fill text-danger', isFavorited);
                    });
                } else {
                    throw new Error('Invalid response format');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error toggling wishlist:', status, error, xhr.responseText);
                if (xhr.status === 401) {
                    if (confirm("Phiên đăng nhập hết hạn. Bạn có muốn đăng nhập lại?")) {
                        window.location.href = "login.html";
                    }
                } else {
                    alert('Không thể cập nhật danh sách yêu thích. Vui lòng thử lại.');
                }
            }
        });
    });
}