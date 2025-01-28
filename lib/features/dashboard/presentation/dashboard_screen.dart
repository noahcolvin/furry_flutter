import 'package:flutter/material.dart';
import 'package:furry_flutter/features/dashboard/presentation/furry_friend_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Furry'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              //showSearch(context: context, delegate: SearchBarDelegate());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                  OutlinedButton(child: Text('Pharmacy'), onPressed: () {}),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 8.0,
                children: [
                  FurryFriend(
                    assetPath: 'assets/images/dog.png',
                    name: 'Dog',
                  ),
                  FurryFriend(
                    assetPath: 'assets/images/dog.png',
                    name: 'Cat',
                  ),
                  FurryFriend(
                    assetPath: 'assets/images/dog.png',
                    name: 'Hamster',
                  ),
                  FurryFriend(
                    assetPath: 'assets/images/dog.png',
                    name: 'Snake',
                  ),
                  FurryFriend(
                    assetPath: 'assets/images/dog.png',
                    name: 'Ferret',
                  ),
                  FurryFriend(
                    assetPath: 'assets/images/dog.png',
                    name: 'Fish',
                  ),
                ],
              ),
            ),
            Text(
              'Your favorites',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
