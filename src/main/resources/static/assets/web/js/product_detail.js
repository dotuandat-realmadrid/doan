function getQueryParam(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}

$(document).ready(function() {
    const code = getQueryParam("code");

    // Hàm tìm kiếm sản phẩm
    $('#search-form').submit(function(e) {
        e.preventDefault();
        const name = $('#search-input').val().trim();
        if (name !== '') {
            window.location.href = `search.html?name=${encodeURIComponent(name)}`;
        }
    });

    // Lấy chi tiết sản phẩm theo code
    loadProductDetail(code);
});

// Hàm lấy chi tiết sản phẩm theo code
function loadProductDetail(code) {
    $.ajax({
        url: `http://localhost:8080/doan/products/${code}`,
        method: 'GET',
        success: function(response) {
            const product = response.result;
            const userId = localStorage.getItem("id");

            // Cập nhật tên sản phẩm
            $('.product__details__text h3').text(product.name);

            // Cập nhật mô tả sản phẩm
            $('#tabs-1 .product__details__tab__desc p').text(product.description || 'Không có mô tả');
            $('.product__details__text p').text(product.description || 'Không có mô tả');
            
            // Cập nhật mô tả trong tab Information
            $('#tabs-2 .product__details__tab__desc p').text(product.description || 'Không có mô tả');

            // Cập nhật giá sản phẩm
            if (product.discountPrice) {
                $('.product__details__price').html(`<del>$${(product.price / 1000).toFixed(2)}K</del> <span>$${(product.discountPrice / 1000).toFixed(2)}K</span>`);
            } else {
                $('.product__details__price').text(`$${(product.price / 1000).toFixed(2)}K`);
            }

            // Sao đánh giá
            const rating = product.avgRating || 0;
            const reviewCount = product.reviewCount || 0;
            const stars = generateStars(rating);
            $('.product__details__rating').html(`${stars} <span>(${reviewCount} reviews)</span>`);

            // Cập nhật số lượng review trong tab "Reviews"
            $('.nav-link[href="#tabs-3"] span').text(`(${reviewCount})`);

            // Khả dụng
            const availability = product.inventoryQuantity > 0 ? "Còn hàng" : "Hết hàng";
            $("li:contains('Khả dụng') span").text(availability);

            // Nhà cung cấp
            $("li:contains('Nhà cung cấp') span").text(product.supplierCode || "Không xác định");

            // Phiếu giảm giá
            const discountLabel = product.discountName ? product.discountName : "0% OFF";
            $("li:contains('Phiếu giảm giá') span").html(` <samp>${discountLabel}</samp>`);

            // ========== PHẦN XỬ LÝ HÌNH ẢNH ĐÃ ĐƯỢC SỬA ==========
            const images = product.images || [];
            const $mainImage = $('.product__details__pic__item--large');
            const $slider = $('.product__details__pic__slider');
            
            // Hủy Owl Carousel cũ trước khi xóa nội dung
            if ($slider.hasClass('owl-loaded')) {
                $slider.trigger('destroy.owl.carousel');
            }
            $slider.empty(); // Xóa slider cũ

            if (images.length > 0) {
                // Cập nhật hình ảnh chính (ảnh đầu tiên)
                $mainImage.attr('src', `/doan/uploads/${images[0]}`).attr('alt', product.name);

                // Cập nhật slider hình ảnh phụ
                images.forEach((image, index) => {
                    $slider.append(`
                        <img data-imgbigurl="/doan/uploads/${image}"
                             src="/doan/uploads/${image}"
                             alt="${product.name} ${index + 1}">
                    `);
                });

                // Khởi tạo lại Owl Carousel
                $slider.owlCarousel({
                    loop: images.length > 1,
                    margin: 10,
                    nav: true,
                    items: 4,
                    dots: false,
                    responsive: {
                        0: {
                            items: 2
                        },
                        600: {
                            items: 3
                        },
                        1000: {
                            items: 4
                        }
                    }
                });

                // Thêm sự kiện click cho các ảnh nhỏ để thay đổi ảnh lớn
                $slider.on('click', 'img', function() {
                    const newSrc = $(this).attr('data-imgbigurl');
                    $mainImage.attr('src', newSrc);
                });

            } else {
                // Hình ảnh mặc định nếu không có dữ liệu
                $mainImage.attr('src', 'assets/web/img/product-thumbnail-1.jpg').attr('alt', product.name);
                $slider.append(`
                    <img data-imgbigurl="assets/web/img/product-thumbnail-2.jpg" 
                         src="assets/web/img/category-thumb-1.jpg" 
                         alt="${product.name}">
                    <img data-imgbigurl="assets/web/img/product-thumbnail-3.jpg" 
                         src="assets/web/img/category-thumb-2.jpg" 
                         alt="${product.name}">
                    <img data-imgbigurl="assets/web/img/product-thumbnail-4.jpg" 
                         src="assets/web/img/category-thumb-3.jpg" 
                         alt="${product.name}">
                    <img data-imgbigurl="assets/web/img/product-thumbnail-5.jpg" 
                         src="assets/web/img/category-thumb-4.jpg" 
                         alt="${product.name}">
                `);
                $slider.owlCarousel({
                    loop: true,
                    margin: 10,
                    nav: true,
                    items: 4,
                    dots: false,
                    responsive: {
                        0: {
                            items: 2
                        },
                        600: {
                            items: 3
                        },
                        1000: {
                            items: 4
                        }
                    }
                });

                // Thêm sự kiện click cho ảnh mặc định
                $slider.on('click', 'img', function() {
                    const newSrc = $(this).attr('data-imgbigurl');
                    $mainImage.attr('src', newSrc);
                });
            }

            // Kiểm tra trạng thái yêu thích của sản phẩm
            checkWishlistStatus(userId, product.id, isFavorited => {
                const $heartIcon = $('.heart-icon i');
                $heartIcon.removeClass('bi-heart bi-heart-fill text-danger')
                    .addClass(isFavorited ? 'bi-heart-fill text-danger' : 'bi-heart');
            });

            // ======= Quản lý số lượng theo tồn kho =======
            const inventoryQuantity = product.inventoryQuantity || 0;
            const $qtyInput = $('.pro-qty input');

            // Gán giá trị mặc định
            $qtyInput.val(inventoryQuantity > 0 ? 1 : 0);

            // Gỡ sự kiện cũ
            $('.pro-qty').off('click', '.qtybtn');
            $qtyInput.off('input');

            // Gắn sự kiện tăng giảm
            $('.pro-qty').on('click', '.qtybtn', function() {
                let oldValue = parseInt($qtyInput.val()) || 0;
                if ($(this).hasClass('inc')) {
                    if (oldValue < inventoryQuantity) {
                        $qtyInput.val(oldValue + 1);
                    } else {
                        $qtyInput.val(inventoryQuantity);
                    }
                } else {
                    if (oldValue > 1) {
                        $qtyInput.val(oldValue - 1);
                    }
                }
            });

            // Xử lý nhập tay
            $qtyInput.on('input', function() {
                let currentValue = parseInt($(this).val());
                if (isNaN(currentValue) || currentValue <= 0) {
                    $(this).val(1);
                }
                if (currentValue > inventoryQuantity) {
                    $(this).val(inventoryQuantity);
                }
            });

            // Nếu hết hàng, disable input và nút
            if (inventoryQuantity === 0) {
                $('.pro-qty .qtybtn').css({
                    'pointer-events': 'none',
                    'opacity': '0.5'
                });
                $qtyInput.val(0).prop('readonly', true);
                $('.primary-btn.btn-add-cart').addClass('disabled').css({
                    'pointer-events': 'none',
                    'opacity': '0.5'
                });
            } else {
                $('.primary-btn.btn-add-cart').removeClass('disabled').css({
                    'pointer-events': 'auto',
                    'opacity': '1'
                });
            }

            // Gắn sự kiện "Thêm vào giỏ hàng"
            $('.primary-btn.btn-add-cart').off('click').on('click', function(e) {
                e.preventDefault();

                const productId = product.id;
                const quantity = parseInt($qtyInput.val());
                const userId = localStorage.getItem("id");

                if (isNaN(quantity) || quantity <= 0) {
                    alert('Vui lòng chọn số lượng hợp lệ.');
                    return;
                }

                if (!userId) {
                    alert("Bạn chưa đăng nhập!");
                    if (confirm("Bạn cần đăng nhập để thêm vào giỏ hàng. Bạn có muốn đăng nhập ngay không?")) {
                        window.location.href = "login.html";
                    }
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
                    success: function(response) {
                        alert(response.message || 'Thêm vào giỏ hàng thành công!');
                    },
                    error: function(xhr) {
                        let message = xhr.responseJSON?.message || "Không thể thêm sản phẩm vào giỏ hàng.";
                        if (xhr.status === 401) {
                            message = "Phiên đăng nhập hết hạn!";
                            localStorage.removeItem("id");
                            if (confirm("Bạn cần đăng nhập lại. Bạn có muốn đăng nhập ngay không?")) {
                                window.location.href = "login.html";
                            }
                        } else if (xhr.status === 400) {
                            message = xhr.responseJSON?.message || "Dữ liệu không hợp lệ.";
                        }
                        alert(message);
                        console.log(xhr.responseText);
                    }
                });
            });

            // Gắn sự kiện cho nút yêu thích
            attachWishlistHandler($('.product__details__text'), product.id);

            // Tải dữ liệu reviews cho sản phẩm
            loadProductReviews(product.id);

            // Gọi sản phẩm liên quan
            loadRelatedProducts(product.categoryCode);
        },
        error: function(xhr, status, error) {
            console.error("Lỗi lấy thông tin product-details:", status, error, xhr.responseText);
            $('.product__details__text').html('<p class="text-danger">Không thể tải thông tin sản phẩm.</p>');
        }
    });
}

// Hàm tải và hiển thị reviews của sản phẩm
function loadProductReviews(productId, page = 1, pageSize = 3) {
    $.ajax({
        url: `http://localhost:8080/doan/reviews/product/${productId}`,
        method: 'GET',
        data: {
            page: page,
            size: pageSize
        },
        success: function(response) {
            const reviews = response.result.data || [];
            const totalReviews = response.result.totalElements || 0;
            const totalPages = response.result.totalPage || 1;
            const currentPage = response.result.currentPage || 1;

            // Cập nhật số lượng review trong tab
            $('.nav-link[href="#tabs-3"] span').text(`(${totalReviews})`);

            // Tạo HTML cho reviews
            let reviewsHTML = `
                <div class="product__details__tab__desc">
                    <h6>Đánh giá sản phẩm (${totalReviews} reviews)</h6>
                    <div class="reviews-container">
            `;

            if (reviews.length > 0) {
                reviews.forEach(review => {
                    const stars = generateStars(review.rating);
                    const reviewDate = new Date(review.createdDate).toLocaleDateString('vi-VN');

                    reviewsHTML += `
                        <div class="review-item" style="border-bottom: 1px solid #eee; padding: 15px 0;">
                            <div class="review-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
                                <div class="reviewer-info">
                                    <strong style="color: #333; font-size: 16px;">${review.fullName}</strong>
                                    <div class="review-rating" style="margin-top: 5px;">
                                        ${stars}
                                    </div>
                                </div>
                                <div class="review-date" style="color: #888; font-size: 14px;">
                                    ${reviewDate}
                                </div>
                            </div>
                            <div class="review-comment" style="color: #666; line-height: 1.6;">
                                ${review.comment || 'Không có bình luận'}
                            </div>
                        </div>
                    `;
                });
            } else {
                reviewsHTML += `
                    <p style="color: #888; text-align: center; padding: 20px;">
                        Không có đánh giá nào cho sản phẩm này.
                    </p>
                `;
            }

            reviewsHTML += `
                    </div>
                    <div class="pagination-container" style="text-align: center; margin-top: 20px;">
                        <nav aria-label="Reviews pagination">
                            <ul class="pagination justify-content-center">
            `;

            // Tạo nút phân trang (tham khảo logic từ renderPagination)
            if (totalPages > 1) {
                // Nút Previous
                const prevClass = currentPage === 1 ? "disabled" : "";
                reviewsHTML += `
                    <li class="page-item ${prevClass}">
                        <a class="page-link" href="#" data-page="${currentPage - 1}" aria-label="Previous">
                            <span aria-hidden="true">«</span>
                        </a>
                    </li>
                `;

                // Tạo các nút số trang
                if (totalPages <= 6) {
                    for (let i = 1; i <= totalPages; i++) {
                        const activeClass = i === currentPage ? "active" : "";
                        reviewsHTML += `
                            <li class="page-item ${activeClass}">
                                <a class="page-link" href="#" data-page="${i}">${i}</a>
                            </li>
                        `;
                    }
                } else {
                    if (currentPage <= 3) {
                        for (let i = 1; i <= 3; i++) {
                            const activeClass = i === currentPage ? "active" : "";
                            reviewsHTML += `
                                <li class="page-item ${activeClass}">
                                    <a class="page-link" href="#" data-page="${i}">${i}</a>
                                </li>
                            `;
                        }
                        reviewsHTML += `
                            <li class="page-item disabled">
                                <a class="page-link" href="#">...</a>
                            </li>
                        `;
                        for (let i = totalPages - 2; i <= totalPages; i++) {
                            const activeClass = i === currentPage ? "active" : "";
                            reviewsHTML += `
                                <li class="page-item ${activeClass}">
                                    <a class="page-link" href="#" data-page="${i}">${i}</a>
                                </li>
                            `;
                        }
                    } else if (currentPage >= totalPages - 2) {
                        for (let i = 1; i <= 3; i++) {
                            const activeClass = i === currentPage ? "active" : "";
                            reviewsHTML += `
                                <li class="page-item ${activeClass}">
                                    <a class="page-link" href="#" data-page="${i}">${i}</a>
                                </li>
                            `;
                        }
                        reviewsHTML += `
                            <li class="page-item disabled">
                                <a class="page-link" href="#">...</a>
                            </li>
                        `;
                        for (let i = totalPages - 2; i <= totalPages; i++) {
                            const activeClass = i === currentPage ? "active" : "";
                            reviewsHTML += `
                                <li class="page-item ${activeClass}">
                                    <a class="page-link" href="#" data-page="${i}">${i}</a>
                                </li>
                            `;
                        }
                    } else {
                        reviewsHTML += `
                            <li class="page-item">
                                <a class="page-link" href="#" data-page="1">1</a>
                            </li>
                            <li class="page-item disabled">
                                <a class="page-link" href="#">...</a>
                            </li>
                        `;
                        for (let i = currentPage - 1; i <= currentPage + 1; i++) {
                            const activeClass = i === currentPage ? "active" : "";
                            reviewsHTML += `
                                <li class="page-item ${activeClass}">
                                    <a class="page-link" href="#" data-page="${i}">${i}</a>
                                </li>
                            `;
                        }
                        reviewsHTML += `
                            <li class="page-item disabled">
                                <a class="page-link" href="#">...</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#" data-page="${totalPages}">${totalPages}</a>
                            </li>
                        `;
                    }
                }

                // Nút Next
                const nextClass = currentPage === totalPages ? "disabled" : "";
                reviewsHTML += `
                    <li class="page-item ${nextClass}">
                        <a class="page-link" href="#" data-page="${currentPage + 1}" aria-label="Next">
                            <span aria-hidden="true">»</span>
                        </a>
                    </li>
                `;
            }

            reviewsHTML += `
                            </ul>
                        </nav>
                    </div>
                </div>
            `;

            // Cập nhật nội dung tab reviews
            $('#tabs-3').html(reviewsHTML);

            // Gắn sự kiện cho các nút phân trang
            $('#tabs-3 .page-link').on('click', function(e) {
                e.preventDefault();
                const page = parseInt($(this).data('page'));
                if (!isNaN(page) && page >= 1 && page <= totalPages) {
                    loadProductReviews(productId, page, pageSize);
                }
            });
        },
        error: function(xhr, status, error) {
            console.error("Lỗi lấy thông tin reviews:", status, error, xhr.responseText);
            $('#tabs-3').html(`
                <div class="product__details__tab__desc">
                    <h6>Đánh giá sản phẩm</h6>
                    <p style="color: #dc3545; text-align: center; padding: 20px;">
                        Không thể tải đánh giá sản phẩm.
                    </p>
                </div>
            `);
        }
    });
}

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

// Hàm xử lý sự kiện thêm/xóa sản phẩm trong danh sách yêu thích
function attachWishlistHandler($element, productId)  {
    $element.find('.heart-icon').on('click', function(e) {
        e.preventDefault();

        const userId = localStorage.getItem("id");
        const $heartIcon = $(this).find('i');

        if (!userId) {
            if (confirm("Bạn cần đăng nhập để thêm/xóa danh sách yêu thích. Bạn có muốn đăng nhập ngay không?")) {
                window.location.href = "login.html";
            }
            return;
        }

        const isFavorited = $heartIcon.hasClass('bi-heart-fill');

        $.ajax({
            url: `http://localhost:8080/doan/wish-list/${userId}/${productId}`,
            method: 'POST',
            contentType: 'application/json',
            xhrFields: {
                withCredentials: true
            },
            success: function(response) {
                if (response.code === 1000) {
                    if (isFavorited) {
                        $heartIcon.removeClass('bi-heart-fill text-danger').addClass('bi-heart');
                        alert('Đã xóa khỏi danh sách yêu thích!');
                    } else {
                        $heartIcon.removeClass('bi-heart').addClass('bi-heart-fill text-danger');
                        alert('Đã thêm vào danh sách yêu thích!');
                    }
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

// Hàm lấy danh sách sản phẩm liên quan
function loadRelatedProducts(categoryCode) {
    const userId = localStorage.getItem("id");
    $.ajax({
        url: `http://localhost:8080/doan/products`,
        method: 'GET',
        data: {
            categoryCode: categoryCode,
            page: 1,
            size: 4,
            sortBy: "point",
            direction: "DESC"
        },
        success: function(response) {
            const products = response.result.data;
            // Kiểm tra trạng thái yêu thích cho từng sản phẩm
            let checkPromises = products.map(product =>
                new Promise(resolve => {
                    checkWishlistStatus(userId, product.id, isFavorited => {
                        resolve({ product, isFavorited });
                    });
                })
            );

            Promise.all(checkPromises).then(results => {
                renderRelatedProducts(results, categoryCode);
            });
        },
        error: function(xhr, status, error) {
            console.error("Không thể lấy sản phẩm liên quan.");
            console.log(xhr, status, error);
        }
    });
}

// Hàm render danh sách sản phẩm liên quan
function renderRelatedProducts(results, categoryCode) {
    const container = $('.row.related-products');
    container.empty();

    results.forEach(({ product, isFavorited }, index) => {
        const delay = (0.1 + index * 0.15).toFixed(1);
        const inventoryQuantity = product.inventoryQuantity || 0;
        const initialValue = inventoryQuantity > 0 ? 1 : 0;

        const html = `
            <div class="col-xl-3 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="${delay}s">
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

        const $element = $(html);
        container.append($element);
        attachAddToCartHandler($element);
        attachWishlistHandler($element, product.id);
    });

    const viewAllButtonHtml = `
        <div class="col-12 text-center wow fadeInUp" data-wow-delay="0.1s">
            <a class="btn btn-primary rounded-pill py-3 mt-3 px-5" href="search.html?categoryCode=${categoryCode}">Xem tất cả</a>
        </div>`;
    container.append(viewAllButtonHtml);

    handleQuantityInputs();
}

// Hàm xử lý sự kiện cho các input số lượng
function handleQuantityInputs() {
    $('.input-number').each(function() {
        const $input = $(this);
        const max = parseInt($input.attr('max')) || 0;

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
                if (xhr.status === 401) {
                    if (confirm("Bạn cần đăng nhập để thêm vào giỏ hàng. Bạn có muốn đăng nhập ngay không?")) {
                        window.location.href = "login.html";
                    }
                } else {
                    console.log(xhr.responseText, status, error);
                    alert('Không thể thêm vào giỏ hàng. Vui lòng thử lại.');
                }
            }
        });
    });
}