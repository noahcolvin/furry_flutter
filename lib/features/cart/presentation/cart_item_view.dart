import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:furry_flutter/features/cart/domain/cart_item.dart';
import 'package:furry_flutter/features/cart/presentation/cart_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class CartItemView extends ConsumerWidget {
  const CartItemView(this.item, {super.key});

  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: Image.memory(kTransparentImage).image,
            image: CachedNetworkImageProvider(item.storeItem.image),
          ),
        ),
      ),
      title: Text(item.storeItem.name),
      subtitle: Row(
        children: [
          TextButton(
            onPressed: () => ref.read(cartControllerProvider.notifier).removeCartItem(item.storeItem),
            style: TextButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(5),
            ),
            child: Text(
              '-',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          Text('${item.quantity}'),
          TextButton(
            onPressed: () => ref.read(cartControllerProvider.notifier).addCartItem(item.storeItem),
            style: TextButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(5),
            ),
            child: Text(
              '+',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
          )
        ],
      ),
      trailing: Text('\$${(item.storeItem.price * item.quantity).toStringAsFixed(2)}'),
    );
  }
}
