import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:furry_flutter/features/store_items/data/store_items.dart';
import 'package:furry_flutter/features/store_items/domain/store_item_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store_items_controller.g.dart';

@riverpod
class StoreItemsController extends _$StoreItemsController {
  late StoreItems storeItems;
  Object? key;
  String? animalFilter;
  String? productFilter;

  @override
  FutureOr<StoreItemList> build() async {
    final cancelToken = CancelToken();
    key = Object();
    storeItems = ref.read(storeItemsProvider(cancelToken));
    ref.onDispose(() {
      key = null;
      cancelToken.cancel();
    });

    return _loadItems();
  }

  void changeAnimal(String value) async {
    if (value == 'All') {
      animalFilter = null;
    } else {
      animalFilter = value;
    }

    _setState();
  }

  void changeProduct(String value) async {
    if (value == 'All') {
      productFilter = null;
    } else {
      productFilter = value;
    }

    _setState();
  }

  void search(String value) async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(await storeItems.getStoreItems(search: value));
  }

  Future<StoreItemList> _loadItems() async {
    state = const AsyncValue.loading();
    return await storeItems.getStoreItems(animal: animalFilter, product: productFilter);
  }

  void _setState() async {
    // This handles a race condition where the user
    // navigates away while loading
    final key = this.key;
    final items = await _loadItems();
    if (key == this.key) {
      state = AsyncValue.data(items);
    }
  }
}
