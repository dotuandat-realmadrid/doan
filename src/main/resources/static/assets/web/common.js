/**
 * 
 */

function getQueryParam(name) {
	const urlParams = new URLSearchParams(window.location.search);
	return urlParams.get(name);
}

$(document).ready(function() {
	const code = getQueryParam("code");

	// Gọi load lần đầu cho tab đầu tiên  ***** index & product *****
	loadProductByCategory("rau-an-la", "#tab-1");

	// Lắng nghe sự kiện click để chuyển tab ***** index & product *****
	$(".nav-pills .nav-item a").on("click", function(e) {
		e.preventDefault();

		let $this = $(this);
		let categoryCode = $this.data("category");
		let tabId = $this.attr("href");

		loadProductByCategory(categoryCode, tabId);
	});

	// Gọi hàm sắp xếp sản phẩm ***** product *****
	loadProductBySortBy();

	// Lấy chi tiết sản phẩm theo code ***** product-detail *****
	loadProductDetail(code);

	// Lấy danh sách sản phẩm tìm kiểm ***** search *****
	const name = getQueryParam('name');
	const categoryCode = getQueryParam('categoryCode');
	const sortBy = getQueryParam('sortBy');
	const direction = getQueryParam('direction');
	if (name || categoryCode || sortBy) {
		const queryData = {
			page: 1,
			size: 12,
			sortBy: sortBy || 'point',
			direction: direction || 'DESC',
			searchField: 'name',
			searchValue: name || categoryCode
		};

		if (name) {
			queryData.name = name;
			$('.display-5.mb-3.name').text(`Tìm kiếm theo tên: ${name}`);
		} else if (categoryCode) {
			queryData.categoryCode = categoryCode;
			queryData.searchField = 'categoryCode';
			$('.display-5.mb-3.name').text(`Tìm kiếm theo danh mục: ${categoryCode}`);
		}

		loadProductsBy(queryData);
	}

	// Hàm tìm kiếm sản phẩm ***** All *****
	$('#search-form').submit(function(e) {
		e.preventDefault();
		const name = $('#search-input').val().trim();
		if (name !== '') {
			// Chuyển hướng sang trang search.html kèm theo query string
			window.location.href = `search.html?name=${encodeURIComponent(name)}`;
		}
	});

	// Kiểm tra trạng thái đăng nhập ***** All *****
	checkLoginStatus();

	// Xử lý sự kiện đăng xuất ***** All *****
	$('#logout').on('click', function(e) {
		e.preventDefault();
		logout();
	});

});

// Hàm gọi danh sách product theo categoryCode ***** index & product *****
function loadProductByCategory(categoryCode, tabId) {
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
			let html = "";
			let products = response.result.data;
			console.log(products);
			products.forEach((product, index) => {
				const delay = (0.1 + index * 0.15).toFixed(1);
				const inventoryQuantity = product.inventoryQuantity || 0;
				const initialValue = inventoryQuantity > 0 ? 1 : 0;

				html += `
	                    <div class="col-xl-3 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="${delay}s">
	                        <div class="product-item" data-product-code="${product.code}">
	                            <figure>
	                            	<a href="product-detail.html?code=${product.code}" title="${product.name}">
	                                    <img src="${product.images?.[0] || 'assets/web/img/product-thumb-7.png'}" alt="${product.name}" class="tab-image">
	                                </a>
	                            </figure>
	                            <div class="d-flex flex-column text-center">
	                                <h3 class="fs-6 fw-normal">${product.name}</h3>
	                                <div>
	                                    <span class="rating">
	                                        ${generateStars(product.avgRating)}
	                                    </span>
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
	                                            <a href="#" class="btn btn-outline-dark rounded-1 p-2 fs-6">
	                                                <svg width="18" height="18"><use xlink:href="#heart"></use></svg>
	                                            </a>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>`;
			});

			html += `
	                	<div class="col-12 text-center wow fadeInUp" data-wow-delay="0.1s">
					        <a class="btn btn-primary rounded-pill py-3 mt-3 px-5 btn-view-all" 
					           href="search.html?categoryCode=${categoryCode}">Xem tất cả</a>
					    </div>
				    `;

			$(`${tabId} .row.g-4`).html(html);

			// Thêm sự kiện cho input số lượng
			handleQuantityInputs();
		},
		error: function(xhr, status, error) {
			alert("Không thể tải danh sách sản phẩm.");
			console.log(xhr.responseText, status, error);
		}
	});
}

// Hàm lấy danh sách sản phẩm có sắp xếp ***** product *****
function loadProductBySortBy() {
	const sections = [
		{ id: '#best-selling-products', sortBy: 'soldQuantity', direction: 'DESC' },
		{ id: '#latest-products', sortBy: 'createdDate', direction: 'DESC' },
		{ id: '#featured-products', sortBy: 'avgRating', direction: 'DESC' },
		{ id: '#popular-products', sortBy: 'reviewCount', direction: 'DESC' }
	];

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
				let html = '';
				let products = response.result.data;
				console.log(products);
				products.forEach((product, index) => {
					const delay = (0.1 + index * 0.15).toFixed(1);
					const inventoryQuantity = product.inventoryQuantity || 0;
					const initialValue = inventoryQuantity > 0 ? 1 : 0;

					html += `
                        <div class="col-xl-3 col-lg-4 col-md-6 ${section.id.includes('best-selling') ? 'col' : 'swiper-slide'} wow fadeInUp" data-wow-delay="${delay}s">
                            <div class="product-item" data-product-code="${product.code}">
                                <figure>
                                	<a href="product-detail.html?code=${product.code}" title="${product.name}">
                                        <img src="${product.images?.[0] || 'assets/web/img/product-thumb-7.png'}" alt="${product.name}" class="tab-image">
                                    </a>
                                </figure>
                                <div class="d-flex flex-column text-center">
                                    <h3 class="fs-6 fw-normal">${product.name}</h3>
                                    <div>
                                        <span class="rating">
                                            ${generateStars(product.avgRating)}
                                        </span>
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
                        </div>`;
				});

				$(section.id).find('.product-grid, .swiper-wrapper').html(html);

				// Thêm sự kiện cho input số lượng
				handleQuantityInputs();
			}
		});
	});
}



// Hàm lấy chi tiết sản phẩm theo code ***** product-detail *****
function loadProductDetail(code) {
	// Gửi AJAX request để lấy thông tin sản phẩm
	$.ajax({
		url: `http://localhost:8080/doan/products/${code}`, // Endpoint API lấy thông tin sản phẩm theo mã code
		method: 'GET',
		success: function(response) {
			const product = response.result;
			// Hiển thị thông tin sản phẩm lên giao diện

			// Cập nhật tên sản phẩm
			$('.product__details__text h3').text(product.name);

			// Cập nhật mô tả sản phẩm
			$('.product__details__tab__desc p').first().text(product.description);
			$('.product__details__text p').text(product.description);

			// Cập nhật giá sản phẩm
			if (product.discountPrice) {
				$('.product__details__price').html(`<del>$${(product.price / 1000).toFixed(2)}K</del> <span>$${(product.discountPrice / 1000).toFixed(2)}K</span>`);
			} else {
				$('.product__details__price').text(`$${(product.price / 1000).toFixed(2)}K`);
			}

			/* // Cập nhật hình ảnh sản phẩm
			const mainImage = product.images?.[0]; // Lấy ảnh đầu tiên
			$('.product__details__pic .product__details__pic__item img').attr('src', `assets/web/img/${mainImage}`);
			// Cập nhật các ảnh trong slider
			let imageHtml = '';
			product.images.forEach(image => {
				imageHtml += `<img data-imgbigurl="assets/web/img/${image}" src="assets/web/img/${image}" alt="">`;
			});
			$('.product__details__pic__slider').html(imageHtml); */

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

			// Gỡ sự kiện cũ (tránh lặp nếu gọi lại nhiều lần)
			$('.pro-qty').off('click', '.qtybtn');

			// Gắn sự kiện tăng giảm với kiểm tra tồn kho
			$('.pro-qty').on('click', '.qtybtn', function() {
				let oldValue = parseInt($qtyInput.val());
				if (isNaN(oldValue)) oldValue = 0;

				// Tăng giảm theo nút click
				if ($(this).hasClass('inc')) {
					if (oldValue < inventoryQuantity) {
						$qtyInput.val(oldValue + 1);
					} else {
						$qtyInput.val(inventoryQuantity);  // Giới hạn giá trị = inventoryQuantity
					}
				} else {
					if (oldValue > 1) {
						$qtyInput.val(oldValue - 1);
					}
				}
			});

			// Nếu hết hàng, disable input và nút
			if (inventoryQuantity === 0) {
				$('.pro-qty .qtybtn').css({
					'pointer-events': 'none',
					'opacity': '0.5'
				});
				$qtyInput.val(0).prop('readonly', true);
			}

			// Xử lý nhập vào, đảm bảo không quá inventoryQuantity
			$qtyInput.on('input', function() {
				let currentValue = parseInt($(this).val());
				if (isNaN(currentValue) || currentValue <= 0) {
					$(this).val(1);  // Đảm bảo giá trị > 0
				}
				if (currentValue > inventoryQuantity) {
					$(this).val(inventoryQuantity);  // Giới hạn bằng inventoryQuantity
				}
			});

			// Sau khi lấy xong chi tiết sản phẩm, gọi tiếp hàm lấy sản phẩm liên quan
			loadRelatedProducts(product.categoryCode);
		},
		error: function(xhr, status, error) {
			console.error("Lỗi lấy thông tin product-details:", error);
			console.log(xhr, status, error);
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

// Hàm hiển thị sản phẩm liên quan ***** product-detail *****
function renderRelatedProducts(products, categoryCode) {
	const container = $('.row.related-products');
	container.empty();

	products.forEach((product, index) => {
		const delay = (0.1 + index * 0.15).toFixed(1);
		const inventoryQuantity = product.inventoryQuantity || 0;
		const initialValue = inventoryQuantity > 0 ? 1 : 0;

		const html = `
	        <div class="col-xl-3 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="${delay}s">
	            <div class="product-item" data-product-code="${product.code}">
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
	                        <del>$${(product.price / 1000).toFixed(2)}K</del>
	                        <span class="text-dark fw-semibold">$${(product.discountPrice / 1000).toFixed(2)}K</span>
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
	        </div>`;
		container.append(html);
	});

	// Thêm nút "Xem tất cả"
	const viewAllButtonHtml = `
	        <div class="col-12 text-center wow fadeInUp" data-wow-delay="0.1s">
	            <a class="btn btn-primary rounded-pill py-3 mt-3 px-5" href="search.html?categoryCode=${categoryCode}">Xem tất cả</a>
	        </div>`;
	container.append(viewAllButtonHtml);

	handleQuantityInputs();
}

// Hàm hiển thị danh sách sản phẩm tìm kiếm ***** search *****
function loadProductsBy(data) {
	const searchFields = ['name', 'id', 'code', 'categoryCode', 'supplierCode', 'minPrice', 'maxPrice'];
	const currentFieldIndex = searchFields.indexOf(data.searchField);
	const searchValue = data.searchValue;
	const isNumeric = !isNaN(searchValue) && !isNaN(parseFloat(searchValue));

	$.ajax({
		url: 'http://localhost:8080/doan/products',
		type: 'GET',
		data: {
			page: data.page,
			size: data.size,
			sortBy: data.sortBy,
			direction: data.direction,
			name: data.name || null,
			id: data.id || null,
			code: data.code || null,
			categoryCode: data.categoryCode || null,
			supplierCode: data.supplierCode || null,
			minPrice: data.minPrice ? parseInt(data.minPrice) : null,
			maxPrice: data.maxPrice ? parseInt(data.maxPrice) : null
		},
		success: function(response) {
			// Kiểm tra phản hồi từ API
			if (!response || !response.result || !Array.isArray(response.result.data)) {
				console.error('Invalid API response:', response);
				$('.row.g-4').empty().append('<h1 class="w-100 text-center text-muted py-4">Không tìm thấy sản phẩm nào.</h1>');
				$('#pagination-container').hide();
				return;
			}

			const products = response.result.data;
			const totalPages = response.result.totalPage || 1;
			const currentPage = response.result.currentPage || 1;
			const container = $('.row.g-4');
			container.empty();

			if (products.length === 0 && currentFieldIndex < searchFields.length - 1) {
				// Tìm trường tiếp theo hợp lệ
				let nextFieldIndex = currentFieldIndex + 1;
				let nextField = searchFields[nextFieldIndex];

				// Bỏ qua minPrice/maxPrice nếu searchValue không phải số
				while (nextFieldIndex < searchFields.length &&
					((nextField === 'minPrice' || nextField === 'maxPrice') && !isNumeric)) {
					nextFieldIndex++;
					nextField = searchFields[nextFieldIndex];
				}

				if (nextFieldIndex >= searchFields.length) {
					console.log('No products found after all valid fields tried.');
					$('#pagination-container').hide();
					container.append('<h1 class="w-100 text-center text-muted py-4">Không tìm thấy sản phẩm nào.</h1>');
					return;
				}

				const newData = { ...data, [data.searchField]: null, searchField: nextField };

				// Gán giá trị tìm kiếm cho trường tiếp theo
				if (nextField === 'minPrice' || nextField === 'maxPrice') {
					newData[nextField] = parseFloat(searchValue);
				} else {
					newData[nextField] = searchValue;
				}

				// Cập nhật tiêu đề
				const fieldLabels = {
					name: 'tên',
					id: 'ID',
					code: 'mã sản phẩm',
					categoryCode: 'mã danh mục',
					supplierCode: 'mã nhà cung cấp',
					minPrice: 'giá tối thiểu',
					maxPrice: 'giá tối đa'
				};
				$('.display-5.mb-3.name').text(`Tìm kiếm theo ${fieldLabels[nextField]}: ${searchValue}`);
				loadProductsBy(newData);
			} else {
				if (products.length === 0) {
					console.log('Hiding pagination due to no products.');
					$('#pagination-container').hide();
					container.append('<h1 class="w-100 text-center text-muted py-4">Không tìm thấy sản phẩm nào.</h1>');
				} else {
					console.log('Showing products:', products.length);
					$('#pagination-container').show();

					products.forEach((product, index) => {
						const delay = (0.1 + index * 0.15).toFixed(2);
						const inventoryQuantity = product.inventoryQuantity || 0;
						const initialValue = inventoryQuantity > 0 ? 1 : 0;
						const html = `
                                <div class="col-xl-3 col-md-6 wow fadeInDown" data-wow-delay="${delay}s">
                                    <div class="product-item" data-product="${product.code}">
                                        <figure>
                                            <a href="product-detail.html?code=${encodeURIComponent(product.code)}" title="${product.name}">
                                                <img src="${product.images?.[0] || 'assets/web/img/product-thumb-7.png'}" alt="${product.name}" class="tab-image">
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
                                </div>`;
						container.append(html);
					});

					renderPagination(currentPage, totalPages, data);
					handleQuantityInputs();
				}
			}
		},
		error: function(xhr, status, error) {
			console.error('API error:', status, error, xhr.responseText);
			$('.row.g-4').empty().append('<p class="w-100 text-center text-muted py-4">Lỗi khi tải sản phẩm. Vui lòng thử lại.</p>');
			$('#pagination-container').hide();
		}
	});
}

// Hàm phân trang ***** search *****
function renderPagination(currentPage, totalPages, originalData) {
	const paginationContainer = $('#pagination-container');
	paginationContainer.empty();

	const createPageItem = (page, text, active = false, disabled = false) => {
		return `<li class="page-item ${active ? 'active' : ''} ${disabled ? 'disabled' : ''}">
                        <a class="page-link" href="#" data-page="${page}">${text}</a>
                    </li>`;
	};

	paginationContainer.append(createPageItem(currentPage - 1, 'Previous', false, currentPage === 1));

	const visiblePages = 5;
	let start = Math.max(1, currentPage - Math.floor(visiblePages / 2));
	let end = Math.min(start + visiblePages - 1, totalPages);
	start = Math.max(1, end - visiblePages + 1);

	for (let i = start; i <= end; i++) {
		paginationContainer.append(createPageItem(i, i, i === currentPage));
	}

	paginationContainer.append(createPageItem(currentPage + 1, 'Next', false, currentPage === totalPages));

	paginationContainer.find('.page-link').click(function(e) {
		e.preventDefault();
		const page = parseInt($(this).data('page'));
		if (!isNaN(page) && page >= 1 && page <= totalPages) {
			const newData = { ...originalData, page };
			loadProductsBy(newData);
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