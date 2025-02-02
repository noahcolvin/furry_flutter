import 'package:flutter_test/flutter_test.dart';
import 'package:furry_flutter/features/store_items/data/store_items.dart';
import 'package:furry_flutter/features/store_items/domain/store_item_list.dart';
import 'package:furry_flutter/features/store_items/presentation/store_items_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class MockStoreItems extends Mock implements StoreItems {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {
  setUpAll(() {
    registerFallbackValue(const AsyncLoading<StoreItemList>());
  });

  ProviderContainer makeProviderContainer(MockStoreItems storeItems) {
    final container = ProviderContainer(
      overrides: [
        storeItemsProvider.overrideWithValue(storeItems),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  MockStoreItems makeAndMockStoreItems() {
    final storeItems = MockStoreItems();
    when(storeItems.getStoreItems).thenAnswer((_) => Future.value(StoreItemList(items: [])));
    return storeItems;
  }

  Listener<AsyncValue<StoreItemList>> makeListener(ProviderContainer container) {
    final listener = Listener<AsyncValue<StoreItemList>>();
    container.listen(
      storeItemsControllerProvider,
      listener.call,
      fireImmediately: true,
    );
    return listener;
  }

  void verifyInitialBuild(Listener<AsyncValue<StoreItemList>> listener, AsyncData<StoreItemList> data) {
    verifyInOrder([
      () => listener(null, AsyncLoading<StoreItemList>()),
      () => listener(AsyncLoading<StoreItemList>(), data),
    ]);
  }

  test('build gets store items', () async {
    final storeItems = makeAndMockStoreItems();
    final container = makeProviderContainer(storeItems);
    final listener = makeListener(container);

    final controller = container.read(storeItemsControllerProvider.notifier);
    await controller.build();

    verifyInitialBuild(listener, AsyncData<StoreItemList>(StoreItemList(items: [])));
    verifyNoMoreInteractions(listener);
    verify(() => storeItems.getStoreItems(animal: null, product: null, search: null)).called(2);
  });

  test('changeAnimal updates animal filter with value', () async {
    final storeItems = makeAndMockStoreItems();
    when(() => storeItems.getStoreItems(animal: 'cat', product: null, search: null))
        .thenAnswer((_) => Future.value(StoreItemList(items: [])));

    final container = makeProviderContainer(storeItems);
    final listener = makeListener(container);

    final controller = container.read(storeItemsControllerProvider.notifier);
    await controller.build();

    final data = AsyncData<StoreItemList>(StoreItemList(items: []));
    verifyInitialBuild(listener, data);

    await controller.changeAnimal('cat');

    verifyInOrder([
      () => listener(data, any(that: isA<AsyncLoading>())),
      () => listener(any(that: isA<AsyncLoading>()), data),
    ]);
    verifyNoMoreInteractions(listener);

    verify(() => storeItems.getStoreItems(animal: 'cat', product: null, search: null)).called(1);
  });

  test('changeAnimal updates animal filter to null for all', () async {
    final storeItems = makeAndMockStoreItems();
    final container = makeProviderContainer(storeItems);
    final listener = makeListener(container);

    final controller = container.read(storeItemsControllerProvider.notifier);
    await controller.build();

    final data = AsyncData<StoreItemList>(StoreItemList(items: []));
    verifyInitialBuild(listener, data);

    controller.animalFilter = 'pig';
    await controller.changeAnimal('All');

    verifyInOrder([
      () => listener(data, any(that: isA<AsyncLoading>())),
      () => listener(any(that: isA<AsyncLoading>()), data),
    ]);
    verifyNoMoreInteractions(listener);

    verify(() => storeItems.getStoreItems(animal: null, product: null, search: null)).called(3);
  });

  test('changeProduct updates product filter with value', () async {
    final storeItems = makeAndMockStoreItems();
    when(() => storeItems.getStoreItems(animal: null, product: 'food', search: null))
        .thenAnswer((_) => Future.value(StoreItemList(items: [])));

    final container = makeProviderContainer(storeItems);
    final listener = makeListener(container);

    final controller = container.read(storeItemsControllerProvider.notifier);
    await controller.build();

    final data = AsyncData<StoreItemList>(StoreItemList(items: []));
    verifyInitialBuild(listener, data);

    await controller.changeProduct('food');

    verifyInOrder([
      () => listener(data, any(that: isA<AsyncLoading>())),
      () => listener(any(that: isA<AsyncLoading>()), data),
    ]);
    verifyNoMoreInteractions(listener);

    verify(() => storeItems.getStoreItems(animal: null, product: 'food', search: null)).called(1);
  });

  test('changeProduct updates product filter to null for all', () async {
    final storeItems = makeAndMockStoreItems();
    final container = makeProviderContainer(storeItems);
    final listener = makeListener(container);

    final controller = container.read(storeItemsControllerProvider.notifier);
    await controller.build();

    // store this into a variable since we'll need it multiple times
    final data = AsyncData<StoreItemList>(StoreItemList(items: []));
    verifyInitialBuild(listener, data);

    controller.productFilter = 'houses';
    await controller.changeProduct('All');

    verifyInOrder([
      () => listener(data, any(that: isA<AsyncLoading>())),
      () => listener(any(that: isA<AsyncLoading>()), data),
    ]);
    verifyNoMoreInteractions(listener);

    verify(() => storeItems.getStoreItems(animal: null, product: null, search: null)).called(3);
  });

  test('search ignores filter items', () async {
    final storeItems = makeAndMockStoreItems();
    when(() => storeItems.getStoreItems(animal: null, product: null, search: 'mouse trap'))
        .thenAnswer((_) => Future.value(StoreItemList(items: [])));

    final container = makeProviderContainer(storeItems);
    final listener = makeListener(container);

    final controller = container.read(storeItemsControllerProvider.notifier);
    await controller.build();

    // store this into a variable since we'll need it multiple times
    final data = AsyncData<StoreItemList>(StoreItemList(items: []));
    verifyInitialBuild(listener, data);

    controller.productFilter = 'houses';
    controller.animalFilter = 'eagle';
    await controller.search('mouse trap');

    verifyInOrder([
      () => listener(data, any(that: isA<AsyncLoading>())),
      () => listener(any(that: isA<AsyncLoading>()), data),
    ]);
    verifyNoMoreInteractions(listener);

    //verify(() => storeItems.getStoreItems(animal: null, product: null, search: null)).called(3);
    verify(() => storeItems.getStoreItems(animal: null, product: null, search: 'mouse trap')).called(1);
  });
}
