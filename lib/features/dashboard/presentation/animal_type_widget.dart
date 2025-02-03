import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnimalType extends StatelessWidget {
  const AnimalType({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/items', extra: name),
      child: Column(
        spacing: 8.0,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 100,
              child: Image.asset(
                'assets/images/animal-types/${name.toLowerCase()}.jpg',
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.indigo.shade900,
                  ),
                ),
              ),
            ),
          ),
          Text(name),
        ],
      ),
    );
  }
}
