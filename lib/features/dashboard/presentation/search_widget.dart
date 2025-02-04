import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:furry_flutter/features/dashboard/presentation/search_widget_controller.dart';
import 'package:go_router/go_router.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchWidget extends ConsumerStatefulWidget {
  const SearchWidget({super.key});

  @override
  ConsumerState<SearchWidget> createState() => _SearchWidget();
}

class _SearchWidget extends ConsumerState<SearchWidget> {
  final _searchController = SearchController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() async {
      ref.read(searchWidgetControllerProvider.notifier).search(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExcludeFocus(
      child: SearchAnchor(
        isFullScreen: false,
        searchController: _searchController,
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0),
            ),
            onTap: () {
              controller.openView();
            },
            onChanged: (changed) {
              controller.openView();
            },
            leading: const Icon(Icons.search),
          );
        },
        viewBuilder: (suggestions) {
          return Consumer(
            builder: (_, consumerRef, __) => consumerRef.watch(searchWidgetControllerProvider).when(
                  data: (data) {
                    log('data: ${data.items.length}');

                    return ListView.builder(
                      itemCount: data.items.length,
                      itemBuilder: (context, index) {
                        final item = data.items[index];
                        return ListTile(
                          title: Text(item.name),
                          onTap: () {
                            _searchController.closeView(null);
                            _searchController.clear();
                            context.push('/item', extra: item);
                          },
                        );
                      },
                    );
                  },
                  error: (_, __) => const ListTile(
                    title: Text('Error loading suggestions'),
                  ),
                  loading: () => SizedBox.shrink(),
                ),
          );
        },
        suggestionsBuilder: (context, controller) => [],
      ),
    );
  }
}
