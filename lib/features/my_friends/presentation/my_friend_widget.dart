import 'package:flutter/material.dart';
import 'package:furry_flutter/features/my_friends/domain/my_friend.dart';
import 'package:go_router/go_router.dart';

class MyFriendWidget extends StatelessWidget {
  const MyFriendWidget({super.key, required this.myFriend});

  final MyFriend myFriend;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/my-friend', extra: myFriend),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  myFriend.image,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  height: 150.0,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      myFriend.name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
