function getQueryParam(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}

$(document).ready(function() {
    const code = getQueryParam("code");
    // Gọi load lần đầu cho tab đầu tiên
    loadProductByCategory("rau-an-la", "#tab-1");

    // Lắng nghe sự kiện click để chuyển tab
    $(".nav-pills .nav-item a").on("click", function(e) {
        e.preventDefault();

        let $this = $(this);
        let categoryCode = $this.data("category");
        let tabId = $this.attr("href");

        loadProductByCategory(categoryCode, tabId);
    });

    // Gọi hàm sắp xếp sản phẩm
    loadProductBySortBy();

    // Hàm tìm kiếm sản phẩm
    $('#search-form').submit(function(e) {
        e.preventDefault();
        const name = $('#search-input').val().trim();
        if (name !== '') {
            window.location.href = `search.html?name=${encodeURIComponent(name)}`;
        }
    });
});

// Hàm kiểm tra trạng thái yêu thích của một sản phẩm
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

// Hàm gọi danh sách product theo categoryCode
function loadProductByCategory(categoryCode, tabId) {
    const userId = localStorage.getItem("id");
    console.log('Loading products for category:', categoryCode, 'userId:', userId);

    $.ajax({
        url: `http://localhost:8080/doan/products`,
        method: "GET",
        data: {
            categoryCode: categoryCode,
            page: 1,
            size: 8,
            sortBy: "point",
            direction: "DESC"
        },
        success: function(response) {
            console.log('Products response:', response);
            const container = $(`${tabId} .row.g-4`);
            container.empty();

            let products = response.result.data || [];
            console.log('Products:', products);

            if (products.length === 0) {
                container.html('<p class="text-center">Không có sản phẩm nào.</p>');
                return;
            }

            // Kiểm tra trạng thái yêu thích cho từng sản phẩm
            let checkPromises = products.map(product =>
                new Promise(resolve => {
                    checkWishlistStatus(userId, product.id, isFavorited => {
                        resolve({ product, isFavorited });
                    });
                })
            );

            Promise.all(checkPromises).then(results => {
                console.log('Wishlist status results:', results);
                let html = "";
                results.forEach(({ product, isFavorited }, index) => {
                    const delay = (0.1 + index * 0.15).toFixed(1);
                    const inventoryQuantity = product.inventoryQuantity || 0;
                    const initialValue = inventoryQuantity > 0 ? 1 : 0;

                    html += `
                        <div class="col-xl-3 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="${delay}s">
                            <div class="product-item" data-product-id="${product.id}">
                                <figure>
                                    <a href="product-detail.html?code=${product.code}" title="${product.name}">
                                        <img src="/doan/uploads/${product.images?.[0] || 'assets/web/img/product-thumb-7.png'}" alt="${product.name}" class="tab-image">
                                    </a>
                                </figure>
                                <div class="d-flex flex-column text-center">
                                    <h3 class="fs-6 fw-normal">${product.name}</h3>
                                    <div>
                                        <span class="rating">${generateStars(product.avgRating)}</span>
                                        <span>(${product.reviewCount})</span>
                                    </div>
                                    <div>
                                        <span class="badge border border-dark-subtle rounded-0 fw-normal px-1 fs-7 lh-1 text-muted">${product.discountName || ''}</span>
                                    </div>
                                    <div class="d-flex justify-content-center align-items-center gap-2">
                                        ${product.discountName == null ? `<span class="text-dark fw-semibold">$${(product.price / 1000).toFixed(2)}K</span>` :
                                        `<del>$${(product.price / 1000).toFixed(2)}K</del>
                                         <span class="text-dark fw-semibold">$${(product.discountPrice / 1000).toFixed(2)}K</span>`}
                                    </div>
                                    <div class="button-area p-3 pt-0">
                                        <div class="row g-1 mt-2">
                                            <div class="col-3">
                                                <input type="number" name="quantity" 
                                                       class="form-control border-dark-subtle input-number quantity" 
                                                       value="${initialValue}" min="0" max="${inventoryQuantity}"
                                                       ${inventoryQuantity <= 0 ? 'readonly' : ''}>
                                            </div>
                                            <div class="col-7">
                                                <a href="#" class="btn btn-primary rounded-1 p-2 fs-7 btn-cart ${inventoryQuantity <= 0 ? 'disabled' : ''}">
                                                    <svg width="18" height="18"><use xlink:href="#cart"></use></svg> Thêm vào giỏ
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
                        </div>
                    `;
                });

                // Thêm nút "Xem tất cả" vào chuỗi html
                html += `
                    <div class="col-12 text-center wow fadeInUp" data-wow-delay="0.1s">
                        <a class="btn btn-primary rounded-pill py-3 mt-3 px-5 btn-view-all" 
                           href="search.html?categoryCode=${categoryCode}">Xem tất cả</a>
                    </div>
                `;

                // Render toàn bộ HTML vào container
                container.html(html);

                // Gán sự kiện cho các nút "Thêm vào giỏ" và "Yêu thích" sau khi render
                container.find('.product-item').each(function() {
                    const $productItem = $(this);
                    attachAddToCartHandler($productItem);
                    attachWishlistHandler($productItem);
                });

                // Thêm sự kiện cho input số lượng
                handleQuantityInputs();
            });
        },
        error: function(xhr, status, error) {
            console.error('Error loading products:', status, error, xhr.responseText);
            alert("Không thể tải danh sách sản phẩm.");
        }
    });
}

// Hàm lấy danh sách sản phẩm có sắp xếp
function loadProductBySortBy() {
    const sections = [
        { id: '#best-selling-products', sortBy: 'soldQuantity', direction: 'DESC' },
        { id: '#latest-products', sortBy: 'createdDate', direction: 'DESC' },
        { id: '#featured-products', sortBy: 'avgRating', direction: 'DESC' },
        { id: '#popular-products', sortBy: 'reviewCount', direction: 'DESC' }
    ];

    const userId = localStorage.getItem("id");
    sections.forEach(section => {
        $.ajax({
            url: 'http://localhost:8080/doan/products',
            method: 'GET',
            data: {
                page: 1,
                size: 10,
                sortBy: section.sortBy,
                direction: section.direction
            },
            success: function(response) {
                let products = response.result.data || [];
                console.log('Products for', section.id, ':', products);
                const $container = $(section.id).find('.product-grid, .swiper-wrapper');
                $container.empty();

                // Kiểm tra trạng thái yêu thích cho từng sản phẩm
                let checkPromises = products.map(product =>
                    new Promise(resolve => {
                        checkWishlistStatus(userId, product.id, isFavorited => {
                            resolve({ product, isFavorited });
                        });
                    })
                );

                Promise.all(checkPromises).then(results => {
                    console.log('Wishlist status for', section.id, ':', results);
                    results.forEach(({ product, isFavorited }, index) => {
                        const delay = (0.1 + index * 0.15).toFixed(1);
                        const inventoryQuantity = product.inventoryQuantity || 0;
                        const initialValue = inventoryQuantity > 0 ? 1 : 0;

                        const html = `
                            <div class="col-xl-3 col-lg-4 col-md-6 ${section.id.includes('best-selling') ? 'col' : 'swiper-slide'} wow fadeInUp" data-wow-delay="${delay}s">
                                <div class="product-item" data-product-code="${product.code}" data-product-id="${product.id}">
                                    <figure>
                                        <a href="product-detail.html?code=${product.code}" title="${product.name}">
                                            <img src="/doan/uploads/${product.images?.[0] || 'assets/web/img/product-thumb-7.png'}" alt="${product.name}" class="tab-image">
                                        </a>
                                    </figure>
                                    <div class="d-flex flex-column text-center">
                                        <h3 class="fs-6 fw-normal">${product.name}</h3>
                                        <div>
                                            <span class="rating">${generateStars(product.avgRating)}</span>
                                            <span>(${product.reviewCount})</span>
                                        </div>
                                        <div>
                                            <span class="badge border border-dark-subtle rounded-0 fw-normal px-1 fs-7 lh-1 text-muted">${product.discountName || ''}</span>
                                        </div>
                                        <div class="d-flex justify-content-center align-items-center gap-2">
                                            ${product.discountName == null ? `<span class="text-dark fw-semibold">$${(product.price / 1000).toFixed(2)}K</span>` :
                                            `<del>$${(product.price / 1000).toFixed(2)}K</del>
                                             <span class="text-dark fw-semibold">$${(product.discountPrice / 1000).toFixed(2)}K</span>`}
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
                                                        <svg width="18" height="18"><use xlink:href="#cart"></use></svg> Thêm vào giỏ
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
                            </div>
                        `;

                        // Tạo jQuery element và gắn sự kiện
                        const $element = $(html);
                        attachAddToCartHandler($element);
                        attachWishlistHandler($element);
                        $container.append($element);
                    });

                    // Thêm sự kiện cho input số lượng
                    handleQuantityInputs();
                });
            },
            error: function(xhr, status, error) {
                console.error(`Error loading products for ${section.id}:`, status, error, xhr.responseText);
            }
        });
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
            },
            error: function(xhr, status, error) {
                console.error('Error adding to cart:', status, error, xhr.responseText);
                if (xhr.status === 401) {
                    if (confirm("Bạn cần đăng nhập để thêm vào giỏ hàng. Bạn có muốn đăng nhập ngay không?")) {
                        window.location.href = "login.html";
                    }
                } else {
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
                    } else {
                        $heartIcon.removeClass('bi-heart').addClass('bi-heart-fill text-danger');
                        alert('Đã thêm vào danh sách yêu thích!');
                    }
                    // Cập nhật lại trạng thái yêu thích sau khi toggle
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