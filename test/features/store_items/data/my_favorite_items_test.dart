import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furry_flutter/features/store_items/data/my_favorite_items.dart';
import 'package:furry_flutter/features/store_items/domain/store_item.dart';
import 'package:furry_flutter/features/store_items/domain/store_item_list.dart';
import 'package:furry_flutter/shared/data/dio_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  ProviderContainer makeProviderContainer(MockDio dio) {
    final container = ProviderContainer(
      overrides: [
        dioProvider.overrideWithValue(dio),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('fetchMyFavoriteItems calls API', () async {
    final expected = StoreItemList(items: [
      StoreItem(id: '1', name: 'item1', price: 100, description: 'description1', image: 'image1', rating: 4, about: []),
      StoreItem(
          id: '2', name: 'item2', price: 200, description: 'description2', image: 'image2', rating: 2.5, about: []),
    ]);

    final dio = MockDio();
    when(() => dio.getUri(Uri(path: '/my-favorite-items'), cancelToken: any(named: 'cancelToken')))
        .thenAnswer((_) async => Response(data: [
              {
                "id": '1',
                "name": 'item1',
                "price": 100,
                "description": 'description1',
                "image": 'image1',
                "rating": 4,
                "about": []
              },
              {
                "id": '2',
                "name": 'item2',
                "price": 200,
                "description": 'description2',
                "image": 'image2',
                "rating": 2.5,
                "about": []
              }
            ], statusCode: 200, requestOptions: RequestOptions()));
    final container = makeProviderContainer(dio);
    final result = await container.read(fetchMyFavoriteItemsProvider.future);
    expect(result, expected);
  });
}
