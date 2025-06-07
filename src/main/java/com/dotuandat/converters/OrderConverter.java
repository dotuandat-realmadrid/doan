package com.dotuandat.converters;

import com.dotuandat.constants.StatusConstant;
import com.dotuandat.dtos.request.order.OrderDetailRequest;
import com.dotuandat.dtos.request.order.OrderRequest;
import com.dotuandat.dtos.response.order.OrderDetailResponse;
import com.dotuandat.dtos.response.order.OrderResponse;
import com.dotuandat.entities.Address;
import com.dotuandat.entities.Order;
import com.dotuandat.entities.OrderDetail;
import com.dotuandat.entities.Product;
import com.dotuandat.entities.ProductImage;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.AddressRepository;
import com.dotuandat.repositories.ProductRepository;
import com.dotuandat.repositories.ReviewRepository;
import com.dotuandat.repositories.UserRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class OrderConverter {
    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AddressRepository addressRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    public Order toEntity(OrderRequest request) {
        Order order = modelMapper.map(request, Order.class);

        order.setUser(userRepository.findByIdAndIsActive(request.getUserId(), StatusConstant.ACTIVE)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED)));

        if (request.getAddressId() != null) {
            order.setAddress(addressRepository.findById(request.getAddressId())
                    .orElseThrow(() -> new AppException(ErrorCode.ADDRESS_NOT_EXISTED)));
        }

        return order;
    }

    public List<OrderDetail> toDetailEntity(Order order, List<OrderDetailRequest> details) {
        return details.stream()
                .map(detailRequest -> {
                    Product product = productRepository.findById(detailRequest.getProductId())
                            .orElseThrow(() -> new AppException(ErrorCode.PRODUCT_NOT_EXISTED));

                    return OrderDetail.builder()
                            .order(order)
                            .product(product)
                            .quantity(detailRequest.getQuantity())
                            .priceAtPurchase(detailRequest.getPriceAtPurchase())
                            .build();
                })
                .collect(Collectors.toList());
    }

    public OrderResponse toResponse(Order order) {
        OrderResponse response = modelMapper.map(order, OrderResponse.class);

        response.setUserId(order.getUser().getId());
        response.setUsername(order.getUser().getUsername());

        if (order.getAddress() != null) {
            response.setFullName(order.getAddress().getFullName());
            response.setPhone(order.getAddress().getPhone());
            response.setAddress(buildAddress(order.getAddress()));
        } else {
            response.setFullName(order.getUser().getUsername());
            response.setPhone(order.getUser().getPhone());
        }

        List<OrderDetailResponse> details = order.getOrderDetails().stream()
                .map(orderDetail ->
                        OrderDetailResponse.builder()
                                .productId(orderDetail.getProduct().getId())
                                .productCode(orderDetail.getProduct().getCode())
                                .productName(orderDetail.getProduct().getName())
                                .quantity(orderDetail.getQuantity())
                                .priceAtPurchase(orderDetail.getPriceAtPurchase())
                                .images(orderDetail.getProduct().getImages().stream()
                                        .map(ProductImage::getImagePath)
                                        .toList())
                                .isReviewed(reviewRepository.existsByUserIdAndOrderIdAndProductId(
                                        order.getUser().getId(),
                                        order.getId(),
                                        orderDetail.getProduct().getId()
                                ))
                                .build())
                .toList();

        boolean isAllReviewed = details.stream().allMatch(OrderDetailResponse::isReviewed);
        response.setAllReviewed(isAllReviewed);
        response.setDetails(details);

        return response;
    }

    private String buildAddress(Address address) {
        return address.getDetail() + ", " +
                address.getWard() + ", " +
                address.getDistrict() + ", " +
                address.getProvince();
    }
}
