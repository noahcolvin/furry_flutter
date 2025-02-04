import 'package:furry_flutter/features/cart/application/cart_service.dart';
import 'package:furry_flutter/features/cart/domain/cart_item.dart';
import 'package:furry_flutter/features/store_items/domain/store_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_controller.g.dart';

@riverpod
class CartController extends _$CartController {
  CartService? _cartService;

  @override
  FutureOr<List<CartItem>> build() {
    _cartService = ref.read(cartServiceProvider);
    return _cartService!.cartItems;
  }

  void addCartItem(StoreItem storeItem) {
    _cartService!.addCartItem(storeItem);
    state = AsyncValue.data(_cartService!.cartItems);
  }

  void removeCartItem(StoreItem storeItem) {
    _cartService!.removeCartItem(storeItem);
    state = AsyncValue.data(_cartService!.cartItems);
  }

  void completeOrder() {
    _cartService!.clearCart();
    state = AsyncValue.data(_cartService!.cartItems);
  }
}
