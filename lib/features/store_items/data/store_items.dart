import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:furry_flutter/features/store_items/domain/store_item_list.dart';
import 'package:furry_flutter/shared/data/dio_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store_items.g.dart';

class StoreItems {
  final Dio dio;
  final CancelToken cancelToken;

  StoreItems({required this.dio, required this.cancelToken});

  Future<StoreItemList> getStoreItems({String? animal, String? product, String? search}) async {
    final uri = Uri(
      path: '/items',
      queryParameters: {
        'animal': animal,
        'product': product,
        'search': search,
      },
    );
    try {
      final response = await dio.getUri(
        uri,
        cancelToken: cancelToken,
      );
      return StoreItemList.fromJson(response.data);
    } catch (e) {
      log('Request cancelled');
      return StoreItemList(items: []);
    }
  }
}

@riverpod
StoreItems storeItems(Ref ref) {
  final cancelToken = CancelToken();
  return StoreItems(dio: ref.read(dioProvider), cancelToken: cancelToken);
}
