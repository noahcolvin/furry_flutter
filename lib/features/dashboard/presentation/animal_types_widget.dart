import 'package:flutter/material.dart';
import 'package:furry_flutter/features/dashboard/presentation/animal_type_widget.dart';

class AnimalTypesWidget extends StatelessWidget {
  const AnimalTypesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8.0,
        children: [
          AnimalType(
            name: 'Dog',
          ),
          AnimalType(
            name: 'Cat',
          ),
          AnimalType(
            name: 'Hamster',
          ),
          AnimalType(
            name: 'Snake',
          ),
          AnimalType(
            name: 'Ferret',
          ),
          AnimalType(
            name: 'Fish',
          ),
        ],
      ),
    );
  }
}
