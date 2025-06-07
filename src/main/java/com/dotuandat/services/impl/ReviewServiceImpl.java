package com.dotuandat.services.impl;

import com.dotuandat.constants.StatusConstant;
import com.dotuandat.dtos.request.review.ReviewRequest;
import com.dotuandat.dtos.response.PageResponse;
import com.dotuandat.dtos.response.review.ReviewResponse;
import com.dotuandat.entities.Order;
import com.dotuandat.entities.Product;
import com.dotuandat.entities.Review;
import com.dotuandat.entities.User;
import com.dotuandat.enums.OrderStatus;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.OrderDetailRepository;
import com.dotuandat.repositories.OrderRepository;
import com.dotuandat.repositories.ProductRepository;
import com.dotuandat.repositories.ReviewRepository;
import com.dotuandat.repositories.UserRepository;
import com.dotuandat.services.ReviewService;
import com.dotuandat.utils.PointCalculator;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ReviewServiceImpl implements ReviewService {
    ReviewRepository reviewRepository;
    OrderRepository orderRepository;
    OrderDetailRepository orderDetailRepository;
    UserRepository userRepository;
    ProductRepository productRepository;

    @Override
    @Transactional
    public ReviewResponse create(ReviewRequest request) {
        Order order = validateOrderAndUser(request);
        validateProductInOrder(request);
        validateReviewNotExists(request);

        Review review = createReviewFromRequest(request, order);
        reviewRepository.save(review);

        updateProductRatingAndPoint(review.getProduct().getId(), review.getRating(), true);

        return mapToResponse(review);
    }

    @Override
    public PageResponse<ReviewResponse> getByProductId(String productId, Pageable pageable) {
        Page<Review> reviews = reviewRepository.findByProductIdAndIsActive(productId, StatusConstant.ACTIVE, pageable);

        List<ReviewResponse> reviewResponses = reviews.stream()
                .map(this::mapToResponse)
                .toList();

        return PageResponse.<ReviewResponse>builder()
                .pageSize(pageable.getPageSize())
                .currentPage(pageable.getPageNumber() + 1)
                .totalPage(reviews.getTotalPages())
                .totalElements(reviews.getTotalElements())
                .data(reviewResponses)
                .build();
    }

    @Override
    @PreAuthorize("hasRole('ADMIN')")
    public void delete(String id) {
        Review review = reviewRepository.findById(id)
                .orElseThrow(() -> new AppException(ErrorCode.REVIEW_NOT_EXISTED));

        updateProductRatingAndPoint(review.getProduct().getId(), review.getRating(), false);
        review.setIsActive(StatusConstant.INACTIVE);
        reviewRepository.save(review);
    }

    private Order validateOrderAndUser(ReviewRequest request) {
        Order order = orderRepository.findById(request.getOrderId())
                .orElseThrow(() -> new AppException(ErrorCode.ORDER_NOT_EXISTED));

        if (!order.getUser().getId().equals(request.getUserId())) {
            throw new AppException(ErrorCode.UNAUTHORIZED);
        }

        if (order.getStatus() != OrderStatus.COMPLETED) {
            throw new AppException(ErrorCode.CAN_NOT_REVIEW);
        }

        return order;
    }

    private void validateProductInOrder(ReviewRequest request) {
        boolean productInOrder = orderDetailRepository
                .existsByOrderIdAndProductId(request.getOrderId(), request.getProductId());
        if (!productInOrder) {
            throw new AppException(ErrorCode.PRODUCT_NOT_IN_ORDER);
        }
    }

    private void validateReviewNotExists(ReviewRequest request) {
        if (reviewRepository.existsByUserIdAndOrderIdAndProductId(
                request.getUserId(), request.getOrderId(), request.getProductId())) {
            throw new AppException(ErrorCode.ALREADY_REVIEWED);
        }
    }

    private Review createReviewFromRequest(ReviewRequest request, Order order) {
        User user = userRepository.findByIdAndIsActive(request.getUserId(), StatusConstant.ACTIVE)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));
        Product product = productRepository.findById(request.getProductId())
                .orElseThrow(() -> new AppException(ErrorCode.PRODUCT_NOT_EXISTED));

        return Review.builder()
                .user(user)
                .product(product)
                .order(order)
                .rating(request.getRating())
                .comment(request.getComment())
                .build();
    }

    /**
     * Cập nhật đánh giá trung bình và điểm cho sản phẩm sau khi có review mới.
     *
     * @param productId ID của sản phẩm
     * @param newRating Điểm đánh giá mới
     */
    private void updateProductRatingAndPoint(String productId, int newRating, boolean isAdd) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new AppException(ErrorCode.PRODUCT_NOT_EXISTED));

        // Cập nhật avgRating
        int reviewCount = product.getReviewCount();
        double newAvgRating;

        if (isAdd) {
            double currentAvgRating = product.getAvgRating();
            newAvgRating = reviewCount == 0 ? newRating :
                    (currentAvgRating * reviewCount + newRating) / (reviewCount + 1);

            product.setAvgRating(newAvgRating);
            product.setReviewCount(reviewCount + 1);
        } else {
            double currentAvgRating = product.getAvgRating();
            newAvgRating = reviewCount - 1 == 0 ? 2.5 :
                    (currentAvgRating * reviewCount - newRating) / (reviewCount - 1);

            product.setAvgRating(newAvgRating);
            product.setReviewCount(reviewCount - 1);
        }

        // Tính lại point với soldQuantity và avgRating mới
        double point = PointCalculator
                .calculatePoint(product.getSoldQuantity(), newAvgRating, product.getReviewCount());
        product.setPoint(point);

        productRepository.save(product);
    }

    private ReviewResponse mapToResponse(Review review) {
        return ReviewResponse.builder()
                .id(review.getId())
                .userId(review.getUser().getId())
                .fullName(review.getUser().getFullName())
                .orderId(review.getOrder().getId())
                .productId(review.getProduct().getId())
                .rating(review.getRating())
                .comment(review.getComment())
                .createdDate(review.getCreatedDate())
                .build();
    }
}
