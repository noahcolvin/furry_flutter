import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeroAd extends StatelessWidget {
  const HeroAd({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/pet_insurance'),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: double.infinity,
          minHeight: 150.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.indigo.shade900,
          ),
          child: Image.asset('assets/images/pet_insurance.png'),
        ),
      ),
    );
  }
}
