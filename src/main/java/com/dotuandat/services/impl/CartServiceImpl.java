package com.dotuandat.services.impl;

import com.dotuandat.constants.StatusConstant;
import com.dotuandat.converters.CartConverter;
import com.dotuandat.dtos.request.cart.CartItemRequest;
import com.dotuandat.dtos.response.cart.CartResponse;
import com.dotuandat.entities.Cart;
import com.dotuandat.entities.CartItem;
import com.dotuandat.entities.Product;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.CartItemRepository;
import com.dotuandat.repositories.CartRepository;
import com.dotuandat.repositories.ProductRepository;
import com.dotuandat.repositories.UserRepository;
import com.dotuandat.services.CartService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CartServiceImpl implements CartService {
    CartRepository cartRepository;
    UserRepository userRepository;
    ProductRepository productRepository;
    CartItemRepository cartItemRepository;
    CartConverter cartConverter;

    @Override
    public int getTotalItems(String userId) {
        return cartRepository.findByUser_Id(userId)
                .map(cart -> cart.getItems().stream().mapToInt(CartItem::getQuantity).sum())
                .orElse(0);
    }

    @Override
    public CartResponse getCartByUser(String userId) {
        Cart cart = cartRepository.findByUser_Id(userId)
                .orElse(null);

        return cart != null ? cartConverter.toResponse(cart) : null;
    }

    @Override
    @Transactional
    public void clearCart(String userId) {
        cartRepository.findByUser_Id(userId).ifPresent(cartRepository::delete);
    }

    @Override
    @Transactional
    public CartResponse addCartItem(CartItemRequest request) {
        Cart cart = getCartOrCreateIfNotExisted(request.getUserId());

        CartItem existedItem = cartItemRepository.findByCart_IdAndProduct_Id(cart.getId(), request.getProductId())
                .orElse(null);

        if (existedItem != null) {
            updateQuantity(existedItem, request);
        } else {
            createNewCartItem(cart, request);
        }

        cartRepository.save(cart);

        return cartConverter.toResponse(cart);
    }

    @Override
    @Transactional
    public void removeItem(String userId, String productId) {
        Cart cart = cartRepository.findByUser_Id(userId)
                .orElseThrow(() -> new AppException(ErrorCode.CART_NOT_EXISTED));

        cartItemRepository.deleteByCart_IdAndProduct_Id(cart.getId(), productId);
    }

    private Cart getCartOrCreateIfNotExisted(String userId) {
        return cartRepository.findByUser_Id(userId)
                .orElseGet(() -> {
                    Cart newCart = Cart.builder()
                            .user(userRepository.findByIdAndIsActive(userId, StatusConstant.ACTIVE)
                                    .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED)))
                            .build();

                    return cartRepository.save(newCart);
                });
    }

    private void updateQuantity(CartItem existedItem, CartItemRequest request) {
        if (existedItem.getQuantity() > 0) {
            // Ưu tiên xử lý deletedQuantity trước
            if (request.getDeletedQuantity() != null) {
                existedItem.setQuantity(existedItem.getQuantity() - request.getDeletedQuantity());
            }
            // Nếu có updatedQuantity, cộng thêm vào
            else if (request.getUpdatedQuantity() != null) {
                existedItem.setQuantity(existedItem.getQuantity() + request.getUpdatedQuantity());
            }
            // Nếu chỉ có quantity, set trực tiếp (trường hợp update toàn bộ)
            else if (request.getQuantity() != null) {
                existedItem.setQuantity(request.getQuantity());
            }
        }
        
        // Đảm bảo quantity không âm và xóa item nếu <= 0
        if (existedItem.getQuantity() <= 0) {
            existedItem.getCart().getItems().remove(existedItem); // Remove from cart's items list
            cartItemRepository.delete(existedItem);
        } else {
            cartItemRepository.save(existedItem); // Save if quantity > 0
        }
    }

    private void createNewCartItem(Cart cart, CartItemRequest request) {
        Product product = productRepository.findById(request.getProductId())
                .orElseThrow(() -> new AppException(ErrorCode.PRODUCT_NOT_EXISTED));

        if (product.getInventoryQuantity() == 0)
            throw new AppException(ErrorCode.INVENTORY_NOT_ENOUGH);

        CartItem newItem = CartItem.builder()
                .cart(cart)
                .product(product)
                .quantity(request.getQuantity())
                .build();

        cart.getItems().add(newItem);
    }
}
