import 'package:flutter/material.dart';
import 'package:furry_flutter/features/dashboard/presentation/star_rating_widget.dart';
import 'package:furry_flutter/features/store_items/domain/store_item.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, required this.item});

  final StoreItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Detail'),
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
                  child: Image.network(item.image),
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
                onPressed: () {},
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
