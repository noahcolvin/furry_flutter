import 'package:flutter/material.dart';
import 'package:furry_flutter/features/dashboard/presentation/star_rating_widget.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key});

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
                'Good Boy Dog Food',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              StarRatingWidget(starCount: 5, rating: 4.5),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/items/dog_food.jpg'),
                ),
              ),
              Text(
                '\$59.99',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'All natural dog food made with the finest chicken and vegetables.',
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
              Text('\u2022 Made in the USA'),
              Text('\u2022 Protein rich'),
              Text('\u2022 Great taste!'),
              ExpansionPanelList(
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text('Reviews'),
                      );
                    },
                    body: Column(
                      children: [
                        ListTile(
                          title: Text('Great product!'),
                          subtitle: Text('5 stars'),
                        ),
                        ListTile(
                          title: Text('My dog loves it!'),
                          subtitle: Text('5 stars'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
