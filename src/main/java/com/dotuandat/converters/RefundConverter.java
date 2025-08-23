package com.dotuandat.converters;

import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.dotuandat.constants.StatusConstant;
import com.dotuandat.dtos.request.order.RefundRequest;
import com.dotuandat.dtos.response.order.OrderDetailResponse;
import com.dotuandat.dtos.response.order.RefundResponse;
import com.dotuandat.entities.Address;
import com.dotuandat.entities.ProductImage;
import com.dotuandat.entities.Refund;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.OrderRepository;
import com.dotuandat.repositories.ReviewRepository;
import com.dotuandat.repositories.UserRepository;

@Component
public class RefundConverter {

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    public Refund toEntity(RefundRequest request) {
        Refund refund = modelMapper.map(request, Refund.class);

        refund.setUser(userRepository
                .findByIdAndIsActive(request.getUserId(), StatusConstant.ACTIVE)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED)));

        refund.setOrder(orderRepository
                .findByIdAndIsActive(request.getOrderId(), StatusConstant.ACTIVE)
                .orElseThrow(() -> new AppException(ErrorCode.ORDER_NOT_EXISTED)));

        return refund;
    }

    public RefundResponse toResponse(Refund refund) {
        RefundResponse response = modelMapper.map(refund, RefundResponse.class);

        response.setUserId(refund.getUser().getId());
        response.setUsername(refund.getUser().getUsername());
        response.setOrderId(refund.getOrder().getId());
        response.setTotalPrice(refund.getOrder().getTotalPrice());
        if (refund.getOrder().getAddress() != null) {
            response.setFullName(refund.getOrder().getAddress().getFullName());
            response.setPhone(refund.getOrder().getAddress().getPhone());
            response.setAddress(buildAddress(refund.getOrder().getAddress()));
        } else {
            response.setFullName(refund.getUser().getUsername());
            response.setPhone(refund.getUser().getPhone());
        }

        List<OrderDetailResponse> details = refund.getOrder().getOrderDetails().stream()
                .map(orderDetail -> OrderDetailResponse.builder()
                        .productId(orderDetail.getProduct().getId())
                        .productCode(orderDetail.getProduct().getCode())
                        .productName(orderDetail.getProduct().getName())
                        .quantity(orderDetail.getQuantity())
                        .priceAtPurchase(orderDetail.getPriceAtPurchase())
                        .images(orderDetail.getProduct().getImages().stream()
                                .map(ProductImage::getImagePath)
                                .toList())
                        .isReviewed(reviewRepository.existsByUserIdAndOrderIdAndProductId(
                                refund.getOrder().getUser().getId(),
                                refund.getOrder().getId(),
                                orderDetail.getProduct().getId()))
                        .build())
                .toList();

        response.setDetails(details);

        return response;
    }

    private String buildAddress(Address address) {
        return address.getDetail() + ", " + address.getWard()
                + ", " + address.getDistrict()
                + ", " + address.getProvince();
    }
}
