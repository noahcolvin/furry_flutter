import 'dart:developer';

import 'package:furry_flutter/features/store_items/data/store_items.dart';
import 'package:furry_flutter/features/store_items/domain/store_item_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_widget_controller.g.dart';

@riverpod
class SearchWidgetController extends _$SearchWidgetController {
  late StoreItems storeItems;
  Object? key;
  String? animalFilter;
  String? productFilter;

  @override
  FutureOr<StoreItemList> build() {
    key = Object();
    storeItems = ref.watch(storeItemsProvider);
    ref.onDispose(() {
      key = null;
    });

    return StoreItemList(items: []);
  }

  Future<void> search(String value) async {
    state = const AsyncValue.loading();

    final key = this.key;
    final items = await storeItems.getStoreItems(search: value);
    if (key == this.key) {
      log('items: ${items.items.length}');
      state = AsyncValue.data(items);
    }
  }
}
