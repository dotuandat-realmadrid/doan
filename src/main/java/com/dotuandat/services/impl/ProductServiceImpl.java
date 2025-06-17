package com.dotuandat.services.impl;

import com.dotuandat.constants.StatusConstant;
import com.dotuandat.converters.ProductConverter;
import com.dotuandat.dtos.request.product.ProductCreateRequest;
import com.dotuandat.dtos.request.product.ProductSearchRequest;
import com.dotuandat.dtos.request.product.ProductUpdateRequest;
import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.product.ProductResponse;
import com.dotuandat.entities.Product;
import com.dotuandat.entities.ProductImage;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.ProductRepository;
import com.dotuandat.services.ProductService;
import com.dotuandat.specifications.ProductSpecification;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class ProductServiceImpl implements ProductService {
    ProductRepository productRepository;
    ProductConverter productConverter;

    @Override
    public PageResponse<ProductResponse> search(ProductSearchRequest request, Pageable pageable) {
        Specification<Product> spec = Specification
                .where(ProductSpecification.withId(request.getId()))
                .and(ProductSpecification.withCategoryCode(request.getCategoryCode()))
                .and(ProductSpecification.withSupplierCode(request.getSupplierCode()))
                .and(ProductSpecification.withCode(request.getCode()))
                .and(ProductSpecification.withName(request.getName()))
                .and(ProductSpecification.withMinPrice(request.getMinPrice()))
                .and(ProductSpecification.withMaxPrice(request.getMaxPrice()))
                .and(ProductSpecification.withIsActive(StatusConstant.ACTIVE));

        Page<Product> products = productRepository.findAll(spec, pageable);

        return PageResponse.<ProductResponse>builder()
                .totalPage(products.getTotalPages())
                .pageSize(pageable.getPageSize())
                .currentPage(pageable.getPageNumber() + 1)
                .totalElements(products.getTotalElements())
                .data(products.stream().map(productConverter::toResponse).toList())
                .build();
    }

    @Override
    public ProductResponse getByCode(String code) {
        return productConverter.toResponse(productRepository
                .findByCodeAndIsActive(code, StatusConstant.ACTIVE)
                .orElseThrow(() -> new AppException(ErrorCode.PRODUCT_NOT_EXISTED)));
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CUD_PRODUCT')")
    public ProductResponse create(ProductCreateRequest request) {
        if (productRepository.existsByCode(request.getCode()))
            throw new AppException(ErrorCode.PRODUCT_EXISTED);

        Product product = productConverter.toEntity(request);
        product.setCreatedDate(LocalDateTime.now());
        productRepository.save(product);

        return productConverter.toResponse(product);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CUD_PRODUCT')")
    public ProductResponse update(String id, ProductUpdateRequest request) {
        Product existedProduct = productRepository.findById(id)
                .orElseThrow(() -> new AppException(ErrorCode.PRODUCT_NOT_EXISTED));

        Product updatedProduct = productConverter.toEntity(existedProduct, request);
        productRepository.save(updatedProduct);

        return productConverter.toResponse(updatedProduct);
    }
    
    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CUD_PRODUCT')")
    public ProductResponse updateImport(String code, ProductUpdateRequest request) {
    	Product existedProduct = productRepository.findByCodeAndIsActive(code, StatusConstant.ACTIVE)
                .orElseThrow(() -> new AppException(ErrorCode.PRODUCT_NOT_EXISTED));

        Product updatedProduct = productConverter.toEntity(existedProduct, request);
        productRepository.save(updatedProduct);

        return productConverter.toResponse(updatedProduct);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CUD_PRODUCT')")
    public void delete(List<String> ids) {
        List<Product> products = ids.stream()
                .map(id -> productRepository.findById(id)
                        .orElseThrow(() -> new AppException(ErrorCode.PRODUCT_NOT_EXISTED)))
                .toList();

        products.forEach(product -> product.setIsActive(StatusConstant.INACTIVE));
        productRepository.saveAll(products);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CUD_PRODUCT')")
    public void saveProductImages(String id, List<String> fileNames) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new AppException(ErrorCode.PRODUCT_NOT_EXISTED));

        List<ProductImage> productImages = fileNames.stream()
                .map(fileName -> new ProductImage(fileName, product))
                .toList();

        product.getImages().clear();
        product.getImages().addAll(productImages);
        productRepository.save(product);
    }
    
    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CUD_PRODUCT')")
    public void updateProductImages(String id, List<String> keepImages, List<String> newFileNames) {
        ObjectMapper objectMapper = new ObjectMapper();

        Product product = productRepository.findById(id)
                .orElseThrow(() -> new AppException(ErrorCode.PRODUCT_NOT_EXISTED));

        // Log dữ liệu nhận được
        log.info("Received keepImages: {}", keepImages);
        log.info("Received newFileNames: {}", newFileNames);

        // Phân tích keepImages từ JSON nếu cần
        List<String> normalizedKeepImages = new ArrayList<>();
        if (keepImages != null && !keepImages.isEmpty()) {
            try {
                for (String keepImage : keepImages) {
                    try {
                        List<String> parsedImages = objectMapper.readValue(
                            keepImage,
                            objectMapper.getTypeFactory().constructCollectionType(List.class, String.class)
                        );
                        normalizedKeepImages.addAll(parsedImages);
                    } catch (Exception e) {
                        normalizedKeepImages.add(keepImage);
                    }
                }
            } catch (Exception e) {
                log.warn("Failed to parse keepImages: {}", keepImages);
                normalizedKeepImages.addAll(keepImages);
            }
        }

        // Chuẩn hóa keepImages mà không gán lại
        List<String> finalKeepImages = normalizedKeepImages.stream()
                .filter(name -> name != null && !name.trim().isEmpty())
                .map(String::trim)
                .collect(Collectors.toList());
        log.info("Normalized keepImages: {}", finalKeepImages);

        // Lấy danh sách ảnh hiện tại
        List<ProductImage> currentImages = new ArrayList<>(product.getImages());
        log.info("Current images in database: {}", currentImages.stream()
                .map(ProductImage::getImagePath)
                .collect(Collectors.toList()));

        // Xóa các ảnh không có trong finalKeepImages
        if (!finalKeepImages.isEmpty()) {
            product.getImages().removeIf(image -> {
                String imagePath = image.getImagePath() != null ? image.getImagePath().trim() : "";
                boolean shouldRemove = !finalKeepImages.contains(imagePath);
                if (shouldRemove) {
                    log.info("Removing image: {}", imagePath);
                } else {
                    log.info("Keeping image: {}", imagePath);
                }
                return shouldRemove;
            });
        } else {
            log.info("finalKeepImages is empty, retaining all current images");
        }

        // Thêm ảnh mới
        if (newFileNames != null && !newFileNames.isEmpty()) {
            List<ProductImage> newProductImages = newFileNames.stream()
                    .filter(fileName -> fileName != null && !fileName.trim().isEmpty())
                    .map(fileName -> {
                        log.info("Adding new image: {}", fileName);
                        return new ProductImage(fileName.trim(), product);
                    })
                    .collect(Collectors.toList());
            product.getImages().addAll(newProductImages);
        } else {
            log.info("No new images to add");
        }

        // Lưu sản phẩm
        productRepository.save(product);

        // Log danh sách ảnh cuối cùng
        List<String> finalImages = product.getImages().stream()
                .map(ProductImage::getImagePath)
                .collect(Collectors.toList());
        log.info("Updated product images for product ID: {}. Final images: {}", id, finalImages);
    }

//    @Override
//    @Transactional
//    @PreAuthorize("hasAuthority('CUD_PRODUCT')")
//    public void updateProductImages(String id, List<String> keepImages, List<String> newFileNames) {
//        Product product = productRepository.findById(id)
//                .orElseThrow(() -> new AppException(ErrorCode.PRODUCT_NOT_EXISTED));
//
//        // Xóa ảnh cũ nếu ko có trong keepImages
//        if (CollectionUtils.isEmpty(keepImages)) {
//            product.getImages().clear();
//        } else {
//            product.getImages().removeIf(image -> !keepImages.contains(image.getImagePath()));
//        }
//
//        // add ảnh mới
//        List<ProductImage> newProductImages = newFileNames.stream()
//                .map(fileName -> new ProductImage(fileName, product))
//                .toList();
//
//        product.getImages().addAll(newProductImages);
//        productRepository.save(product);
//    }
}
