/**
 * 
 */
function getQueryParam(name) {
	const urlParams = new URLSearchParams(window.location.search);
	return urlParams.get(name);
}
$(document).ready(function() {
	const code = getQueryParam("code");

	// Hàm tìm kiếm sản phẩm ***** All *****
	$('#search-form').submit(function(e) {
		e.preventDefault();
		const name = $('#search-input').val().trim();
		if (name !== '') {
			// Chuyển hướng sang trang search.html kèm theo query string
			window.location.href = `search.html?name=${encodeURIComponent(name)}`;
		}
	});

	// Lấy chi tiết sản phẩm theo code ***** product-detail *****
	loadProductDetail(code);

	// Kiểm tra trạng thái đăng nhập ***** All *****
	checkLoginStatus();

	// Xử lý sự kiện đăng xuất ***** All *****
	$('#logout').on('click', function(e) {
		e.preventDefault();
		logout();
	});
	
	// Gọi hàm khi mở offcanvas
	$('#offcanvasCart').on('show.bs.offcanvas', function() {
		const userId = localStorage.getItem("id");
		loadCart(userId);
	});

});

// Hàm lấy chi tiết sản phẩm theo code ***** product-detail *****
function loadProductDetail(code) {
    $.ajax({
        url: `http://localhost:8080/doan/products/${code}`,
        method: 'GET',
        success: function(response) {
            const product = response.result;

            // Cập nhật tên sản phẩm
            $('.product__details__text h3').text(product.name);

            // Cập nhật mô tả sản phẩm
            $('.product__details__tab__desc p').first().text(product.description || 'Không có mô tả');
            $('.product__details__text p').text(product.description || 'Không có mô tả');

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

            // Gắn sự kiện "Thêm vào giỏ hàng" cho nút .primary-btn.btn-add-cart
            $('.primary-btn.btn-add-cart').off('click').on('click', function(e) {
                e.preventDefault(); // Ngăn chuyển hướng #

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
                        loadCart(userId);
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

            // Gọi sản phẩm liên quan
            loadRelatedProducts(product.categoryCode);
        },
        error: function(xhr, status, error) {
            console.error("Lỗi lấy thông tin product-details:", status, error, xhr.responseText);
            $('.product__details__text').html('<p class="text-danger">Không thể tải thông tin sản phẩm.</p>');
        }
    });
}

// Hàm lấy danh sách sản phẩm liên quan ***** product-detail *****
function loadRelatedProducts(categoryCode) {
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
			console.log(products);
			renderRelatedProducts(products, categoryCode);
		},
		error: function(xhr, status, error) {
			console.error("Không thể lấy sản phẩm liên quan.");
			console.log(xhr, status, error);
		}
	});
}

function attachAddToCartHandler($element) {
	$element.find('.btn-cart').on('click', function(e) {
		e.preventDefault(); // Ngăn hành vi mặc định của thẻ <a>

		const $productItem = $(this).closest('.product-item');
		const productId = $productItem.data('product-id');
		const quantity = parseInt($productItem.find('.quantity').val());
		const userId = localStorage.getItem("id");

		if (quantity <= 0) {
			alert('Vui lòng chọn số lượng hợp lệ.');
			return;
		}

		// Gửi request POST để thêm vào giỏ hàng
		$.ajax({
			url: 'http://localhost:8080/doan/cart/items',
			method: 'POST',
			contentType: 'application/json',
			xhrFields: {
				withCredentials: true // Gửi cookie cùng yêu cầu
			},
			data: JSON.stringify({
				userId: userId,
				productId: productId,
				quantity: quantity,
				updatedQuantity: quantity
			}),
			success: function() {
				alert('Thêm vào giỏ hàng thành công!');
				// Gọi lại hàm loadCart để cập nhật giỏ hàng
				loadCart(userId);
			},
			error: function(xhr, status, error) {
				if (xhr.status === 401) {
					if (confirm("Bạn cần đăng nhập để thêm vào giỏ hàng. Bạn có muốn đăng nhập ngay không?")) {
					window.location.href = "login.html";
					}
				} else {
					console.log(xhr.responseText, status, error);
				}
			}
		});
	});
}

function renderRelatedProducts(products, categoryCode) {
	const container = $('.row.related-products');
	container.empty();

	products.forEach((product, index) => {
		const delay = (0.1 + index * 0.15).toFixed(1);
		const inventoryQuantity = product.inventoryQuantity || 0;
		const initialValue = inventoryQuantity > 0 ? 1 : 0;

		const html = `
            <div class="col-xl-3 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="${delay}s">
                <div class="product-item" data-product-code="${product.code}" data-product-id="${product.id}">
                    <figure>
                        <a href="product-detail.html?code=${product.code}" title="${product.name}">
                            <img src="${product.images?.[0] || 'assets/web/img/product-thumb-7.png'}" alt="${product.name}" class="tab-image">
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
                                    <a href="#" class="btn btn-outline-dark rounded-1 p-2 fs-6">
                                        <svg width="18" height="18"><use xlink:href="#heart"></use></svg>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `;

		// Thêm HTML vào container và gán sự kiện
		const $element = $(html);
		container.append($element);
		attachAddToCartHandler($element);
	});

	// Thêm nút "Xem tất cả"
	const viewAllButtonHtml = `
        <div class="col-12 text-center wow fadeInUp" data-wow-delay="0.1s">
            <a class="btn btn-primary rounded-pill py-3 mt-3 px-5" href="search.html?categoryCode=${categoryCode}">Xem tất cả</a>
        </div>`;
	container.append(viewAllButtonHtml);

	handleQuantityInputs();
}

// Hàm kiểm tra đăng nhập ***** All *****
function checkLoginStatus() {
	$.ajax({
		url: 'http://localhost:8080/doan/users/myInfo',
		type: 'GET',
		xhrFields: {
			withCredentials: true // Gửi cookie cùng yêu cầu
		},
		success: function(response) {
			if (response && response.code === 1000 && response.result) {
				// Đăng nhập thành công
				const user = response.result;
				localStorage.setItem("id", user.id);
				console.log("UserId: " + user.id);
				$('#user-name').text(user.fullName || 'Unknown User');
				$('#user-role').text(user.roles && user.roles.length > 0 ? user.roles.join(', ') : 'User');

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
				// Chưa đăng nhập
				showLoginLink();
			}
		},
		error: function(xhr, status, error) {
			console.error('Error checking login status:', status, error, xhr.responseText);
			showLoginLink();
		}
	});
}

// Hàm xử lý sự kiện cho các input số lượng ***** All *****
function handleQuantityInputs() {
	$('.input-number').each(function() {
		const $input = $(this);
		const max = parseInt($input.attr('max')) || 0;
		const $productItem = $input.closest('.product-item');

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

// Hàm tính sao đánh giá ***** All *****
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
		error: function() {
			alert("Không thể tải giỏ hàng.");
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

$('.btn-lg.btn-view-order').on('click', function(e) {
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
