import 'package:dio/dio.dart';
import 'package:furry_flutter/features/my_friends/domain/my_friend_list.dart';
import 'package:furry_flutter/shared/data/dio_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_friends.g.dart';

@riverpod
Future<MyFriendList> fetchMyFriends(Ref ref) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());

  final dio = ref.read(dioProvider);
  return myFriends(
    cancelToken: cancelToken,
    dio: dio,
  );
}

Future<MyFriendList> myFriends({CancelToken? cancelToken, required Dio dio}) async {
  final uri = Uri(path: '/my-friends');
  final response = await dio.getUri(uri, cancelToken: cancelToken);
  return MyFriendList.fromJson(response.data);
}
