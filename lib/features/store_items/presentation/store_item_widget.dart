import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:furry_flutter/features/dashboard/presentation/star_rating_widget.dart';
import 'package:furry_flutter/features/store_items/domain/store_item.dart';
import 'package:go_router/go_router.dart';
import 'package:transparent_image/transparent_image.dart';

class StoreItemWidget extends StatelessWidget {
  const StoreItemWidget({super.key, required this.item});

  final StoreItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/item', extra: item),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: SizedBox(
          width: 200,
          child: Column(
            spacing: 8.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: Stack(children: [
                  SizedBox(
                    height: 200.0,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  FadeInImage(
                    placeholder: Image.memory(kTransparentImage).image,
                    image: CachedNetworkImageProvider(item.image),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                      height: 60,
                      child: Text(
                        item.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '\$${item.price}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    StarRatingWidget(starCount: 5, rating: item.rating)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
