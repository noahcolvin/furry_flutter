import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:furry_flutter/features/my_friends/domain/my_friend.dart';

part 'my_friend_list.freezed.dart';
part 'my_friend_list.g.dart';

@freezed
class MyFriendList with _$MyFriendList {
  factory MyFriendList({
    required List<MyFriend> friends,
  }) = _MyFriendList;

  factory MyFriendList.fromJson(Map<String, dynamic> json) => _$MyFriendListFromJson(json);
}
