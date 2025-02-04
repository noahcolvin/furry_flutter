import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:furry_flutter/features/cart/presentation/cart_controller.dart';
import 'package:furry_flutter/features/cart/presentation/cart_icon.dart';
import 'package:furry_flutter/features/dashboard/presentation/star_rating_widget.dart';
import 'package:furry_flutter/features/store_items/domain/store_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemDetailScreen extends ConsumerWidget {
  const ItemDetailScreen({super.key, required this.item});

  final StoreItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Detail'),
        actions: [
          CartIcon(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0,
            children: [
              Text(
                item.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              StarRatingWidget(starCount: 5, rating: item.rating),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: Image.memory(kTransparentImage).image,
                    image: CachedNetworkImageProvider(item.image),
                  ),
                ),
              ),
              Text(
                '\$${item.price}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                item.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              FilledButton(
                onPressed: () {
                  ref.read(cartControllerProvider.notifier).addCartItem(item);

                  const snackBar = SnackBar(content: Text('Item added to cart'));
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackBar)
                      .closed
                      .then((value) => context.mounted ? ScaffoldMessenger.of(context).clearSnackBars() : null);
                },
                child: Text('Add to Cart'),
              ),
              const SizedBox(height: 8.0),
              Text(
                'About',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              ...item.about.map((String about) => Text('\u2022 $about')),
            ],
          ),
        ),
      ),
    );
  }
}
