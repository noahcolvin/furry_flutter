import 'package:flutter/material.dart';
import 'package:furry_flutter/features/cart/presentation/cart_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderDetails extends ConsumerWidget {
  const OrderDetails({super.key});
  static const shipping = 4.95;
  static const taxRate = 7.25;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartControllerProvider);

    return cartItems.when(
      data: (value) {
        final totalAmount = value.fold(
          0.0,
          (previousValue, element) => previousValue + element.storeItem.price * element.quantity,
        );
        final tax = totalAmount * taxRate / 100;
        final orderAmount = totalAmount + tax + shipping;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Details',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Item total:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '\$${totalAmount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '\$${shipping.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tax:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '\$${tax.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order total:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '\$${orderAmount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error: $error'),
    );

    /* return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Details',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Item total:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '\$',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    ); */
  }
}
