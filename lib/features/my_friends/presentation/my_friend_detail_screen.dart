import 'package:flutter/material.dart';
import 'package:furry_flutter/features/my_friends/domain/my_friend.dart';

class MyFriendDetailScreen extends StatelessWidget {
  const MyFriendDetailScreen({super.key, required this.friend});

  final MyFriend friend;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Friend ${friend.name}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(friend.image),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
