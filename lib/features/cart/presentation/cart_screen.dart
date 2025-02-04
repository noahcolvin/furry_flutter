import 'package:flutter/material.dart';
import 'package:furry_flutter/features/cart/presentation/cart_controller.dart';
import 'package:furry_flutter/features/cart/presentation/cart_item_view.dart';
import 'package:furry_flutter/features/cart/presentation/order_details.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartControllerProvider);
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cartItems.when(
        data: (value) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Items',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      final item = value[index];
                      return CartItemView(item);
                    },
                  ),
                ),
                const Divider(
                  thickness: 5,
                ),
                OrderDetails(),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, bottomPadding),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
                    ),
                    onPressed: () {
                      ref.read(cartControllerProvider.notifier).completeOrder();
                      context.go('/');
                    },
                    child: Text(
                      'Complete Order',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
