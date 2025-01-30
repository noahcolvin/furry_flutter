import 'package:flutter/material.dart';
import 'package:furry_flutter/features/store_items/data/store_items.dart';
import 'package:furry_flutter/features/store_items/presentation/store_item_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StoreItemsScreen extends ConsumerWidget {
  const StoreItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeItems = ref.watch(fetchStoreItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Items'),
      ),
      body: switch (storeItems) {
        AsyncData(:final value) => GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            childAspectRatio: (1 / 1.8),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              ...value.items.map((item) => StoreItemWidget(item: item)),
            ],
          ),
        AsyncError() => const Text('Oops, something unexpected happened'),
        _ => const CircularProgressIndicator(),
      },
    );
  }
}
