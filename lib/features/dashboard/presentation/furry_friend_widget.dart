import 'package:flutter/material.dart';

class FurryFriend extends StatelessWidget {
  const FurryFriend({
    super.key,
    required this.assetPath,
    required this.name,
  });

  final String assetPath;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: 100,
            child: Image.asset(assetPath),
          ),
        ),
        Text(name),
      ],
    );
  }
}
