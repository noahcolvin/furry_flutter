import 'package:dio/dio.dart';
import 'package:furry_flutter/features/store_items/domain/store_item_list.dart';
import 'package:furry_flutter/shared/data/dio_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store_items.g.dart';

@riverpod
Future<StoreItemList> fetchStoreItems(Ref ref) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());

  final dio = ref.read(dioProvider);
  return storeItems(
    cancelToken: cancelToken,
    dio: dio,
  );
}

Future<StoreItemList> storeItems({CancelToken? cancelToken, required Dio dio}) async {
  final uri = Uri(path: '/items');
  final response = await dio.getUri(uri, cancelToken: cancelToken);
  return StoreItemList.fromJson(response.data);
}
