import 'package:flutter/material.dart';
import 'package:furry_flutter/features/store_items/data/my_favorite_items.dart';
import 'package:furry_flutter/features/store_items/presentation/store_item_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyFavoriteItemsWidget extends ConsumerWidget {
  const MyFavoriteItemsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeItemList = ref.watch(fetchMyFavoriteItemsProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: switch (storeItemList) {
        AsyncData(:final value) => Row(
            spacing: 8.0,
            children: [
              ...value.items.map((item) => StoreItemWidget(item: item)),
            ],
          ),
        AsyncError() => const Text('Oops, something unexpected happened'),
        _ => const CircularProgressIndicator(),
      },
    );
  }
}
