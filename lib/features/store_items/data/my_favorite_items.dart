import 'package:dio/dio.dart';
import 'package:furry_flutter/features/store_items/domain/store_item_list.dart';
import 'package:furry_flutter/shared/application/dio_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_favorite_items.g.dart';

@riverpod
Future<StoreItemList> fetchMyFavoriteItems(Ref ref) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());

  final dio = ref.read(dioProvider);
  return myFavoriteItems(
    cancelToken: cancelToken,
    dio: dio,
  );
}

Future<StoreItemList> myFavoriteItems({CancelToken? cancelToken, required Dio dio}) async {
  final uri = Uri(path: '/my-favorite-items');
  final response = await dio.getUri(uri, cancelToken: cancelToken);
  return StoreItemList.fromJson(response.data);
}
