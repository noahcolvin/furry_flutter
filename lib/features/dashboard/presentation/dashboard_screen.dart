import 'package:flutter/material.dart';
import 'package:furry_flutter/features/dashboard/presentation/animal_types_widget.dart';
import 'package:furry_flutter/features/dashboard/presentation/hero_ad.dart';
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
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              //showSearch(context: context, delegate: SearchBarDelegate());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.0,
            children: [
              SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                  );
                },
                suggestionsBuilder: (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(
                    5,
                    (int index) {
                      final String item = 'item $index';
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          controller.closeView(item);
                        },
                      );
                    },
                  );
                },
              ),
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
                    OutlinedButton(child: Text('Today\'s Specials'), onPressed: () {}),
                    OutlinedButton(child: Text('Shop'), onPressed: () => context.push('/store')),
                    OutlinedButton(child: Text('Grooming'), onPressed: () {}),
                    OutlinedButton(child: Text('Locations'), onPressed: () {}),
                    OutlinedButton(child: Text('Rescue'), onPressed: () {}),
                    OutlinedButton(child: Text('Vet Finder'), onPressed: () {}),
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
