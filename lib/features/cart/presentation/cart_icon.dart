import 'package:flutter/material.dart';
import 'package:furry_flutter/features/cart/presentation/cart_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartControllerProvider);
    final totalCount = cartItems.whenData(
      (value) => value.fold(0, (previousValue, element) => previousValue + element.quantity),
    );

    return IconButton(
      icon: Badge.count(
        count: totalCount.when(data: (data) => data, error: (_, __) => 0, loading: () => 0),
        child: Icon(
          Icons.shopping_cart,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: () {
        context.push('/cart');
      },
    );
  }
}
