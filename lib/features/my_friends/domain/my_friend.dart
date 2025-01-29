import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_friend.freezed.dart';
part 'my_friend.g.dart';

@freezed
class MyFriend with _$MyFriend {
  factory MyFriend({
    required String name,
    required String image,
  }) = _MyFriend;

  /// Convert a JSON object into an [Activity] instance.
  /// This enables type-safe reading of the API response.
  factory MyFriend.fromJson(Map<String, dynamic> json) => _$MyFriendFromJson(json);
}
