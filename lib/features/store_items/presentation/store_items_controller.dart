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
    key = Object();
    storeItems = ref.watch(storeItemsProvider);
    ref.onDispose(() {
      key = null;
    });

    return _loadItems();
  }

  Future<void> changeAnimal(String value) async {
    if (value == 'All') {
      animalFilter = null;
    } else {
      animalFilter = value;
    }

    await _setState();
  }

  Future<void> changeProduct(String value) async {
    if (value == 'All') {
      productFilter = null;
    } else {
      productFilter = value;
    }

    await _setState();
  }

  Future<void> search(String value) async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(await storeItems.getStoreItems(search: value));
  }

  Future<StoreItemList> _loadItems() async {
    state = const AsyncValue.loading();
    return await storeItems.getStoreItems(animal: animalFilter, product: productFilter);
  }

  Future<void> _setState() async {
    // This handles a race condition where the user
    // navigates away while loading
    final key = this.key;
    final items = await _loadItems();
    if (key == this.key) {
      state = AsyncValue.data(items);
    }
  }
}
