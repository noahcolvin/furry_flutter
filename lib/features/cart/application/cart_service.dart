import 'package:furry_flutter/features/cart/domain/cart_item.dart';
import 'package:furry_flutter/features/store_items/domain/store_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_service.g.dart';

class CartService {
  final List<CartItem> _cartItems = [];

  void addCartItem(StoreItem storeItem) {
    final cartItem = _cartItems.firstWhere(
      (element) => element.storeItem.id == storeItem.id,
      orElse: () => CartItem(storeItem: storeItem, quantity: 0),
    );

    if (cartItem.quantity == 0) {
      _cartItems.add(CartItem(storeItem: storeItem, quantity: 1));
    } else {
      cartItem.quantity++;
    }
  }

  void removeCartItem(StoreItem storeItem) {
    final cartItem = _cartItems.firstWhere(
      (element) => element.storeItem.id == storeItem.id,
      orElse: () => CartItem(storeItem: storeItem, quantity: 0),
    );

    if (cartItem.quantity == 0) {
      return;
    } else if (cartItem.quantity == 1) {
      _cartItems.remove(cartItem);
    } else {
      cartItem.quantity--;
    }
  }

  void clearCart() {
    _cartItems.clear();
  }

  List<CartItem> get cartItems => _cartItems;
}

@Riverpod(keepAlive: true)
CartService cartService(Ref ref) {
  return CartService();
}
