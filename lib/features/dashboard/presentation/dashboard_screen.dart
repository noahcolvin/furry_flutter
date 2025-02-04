import 'package:flutter/material.dart';
import 'package:furry_flutter/features/cart/presentation/cart_icon.dart';
import 'package:furry_flutter/features/dashboard/presentation/animal_types_widget.dart';
import 'package:furry_flutter/features/dashboard/presentation/hero_ad.dart';
import 'package:furry_flutter/features/dashboard/presentation/search_widget.dart';
import 'package:furry_flutter/features/my_friends/presentation/my_friends_widget.dart';
import 'package:furry_flutter/features/store_items/presentation/my_favorite_items_widget.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/header_logo.png', height: 32.0),
        actions: [
          CartIcon(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.0,
            children: [
              SearchWidget(),
              Text(
                'Welcome back!',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 8.0,
                  children: [
                    OutlinedButton(child: Text('Shop'), onPressed: () => context.push('/store')),
                    OutlinedButton(child: Text('Today\'s Specials'), onPressed: () => context.push('/specials')),
                    OutlinedButton(child: Text('Grooming'), onPressed: () => context.push('/grooming')),
                    OutlinedButton(child: Text('Locations'), onPressed: () => context.push('/locations')),
                    OutlinedButton(child: Text('Rescue'), onPressed: () => context.push('/rescue')),
                    OutlinedButton(child: Text('Vet Finder'), onPressed: () => context.push('/vet')),
                  ],
                ),
              ),
              Text(
                'What furry friend brought you here today?',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              AnimalTypesWidget(),
              Text(
                'Your favorites',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              MyFavoriteItemsWidget(),
              HeroAd(),
              Text(
                'Your furry friends',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              MyFriendsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
