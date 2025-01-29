import 'package:flutter/material.dart';
import 'package:furry_flutter/features/my_friends/data/my_friends.dart';
import 'package:furry_flutter/features/my_friends/presentation/my_friend_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyFriendsWidget extends ConsumerWidget {
  const MyFriendsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myFriends = ref.watch(fetchMyFriendsProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: switch (myFriends) {
        AsyncData(:final value) => Row(
            spacing: 8.0,
            children: [
              ...value.friends.map((myFriend) => MyFriendWidget(myFriend: myFriend)),
            ],
          ),
        AsyncError() => const Text('Oops, something unexpected happened'),
        _ => const CircularProgressIndicator(),
      },
    );
  }
}
