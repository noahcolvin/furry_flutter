import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furry_flutter/features/store_items/data/store_items.dart';
import 'package:furry_flutter/features/store_items/domain/store_item.dart';
import 'package:furry_flutter/features/store_items/domain/store_item_list.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  test('getStoreItems calls API', () async {
    final cancelToken = CancelToken();
    final dio = MockDio();
    when(() =>
        dio.getUri(Uri(path: '/items', queryParameters: {'animal': 'dog', 'product': 'food', 'search': 'dog food'}),
            cancelToken: cancelToken)).thenAnswer((_) async => Response(data: {
          "items": [
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
          ]
        }, statusCode: 200, requestOptions: RequestOptions()));

    final expected = StoreItemList(items: [
      StoreItem(id: '1', name: 'item1', price: 100, description: 'description1', image: 'image1', rating: 4, about: []),
      StoreItem(
          id: '2', name: 'item2', price: 200, description: 'description2', image: 'image2', rating: 2.5, about: []),
    ]);

    final storeItems = StoreItems(dio: dio, cancelToken: cancelToken);
    final result = await storeItems.getStoreItems(animal: 'dog', product: 'food', search: 'dog food');

    expect(result, expected);
  });

  test('getStoreItems returns empty list on error', () async {
    final cancelToken = CancelToken();
    final dio = MockDio();
    when(() => dio.getUri(
        Uri(path: '/items', queryParameters: {'animal': 'dog', 'product': 'food', 'search': 'dog food'}),
        cancelToken: cancelToken)).thenThrow(Exception());

    final expected = StoreItemList(items: []);
    final storeItems = StoreItems(dio: dio, cancelToken: cancelToken);
    final result = await storeItems.getStoreItems(animal: 'dog', product: 'food', search: 'dog food');

    expect(result, expected);
  });
}
