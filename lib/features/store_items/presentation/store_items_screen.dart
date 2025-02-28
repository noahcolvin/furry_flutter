import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:furry_flutter/features/cart/presentation/cart_icon.dart';
import 'package:furry_flutter/features/store_items/presentation/store_item_widget.dart';
import 'package:furry_flutter/features/store_items/presentation/store_items_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StoreItemsScreen extends ConsumerStatefulWidget {
  const StoreItemsScreen({super.key, this.animal});

  final String? animal;

  @override
  ConsumerState<StoreItemsScreen> createState() => _StoreItemsScreenState();
}

class _StoreItemsScreenState extends ConsumerState<StoreItemsScreen> {
  final List<String> animalList = ['All', 'Dog', 'Cat', 'Hamster', 'Bird', 'Fish', 'Reptile'];
  String animalDropdownValue = 'All';

  final List<String> productList = ['All', 'Food', 'Toy'];
  String productDropdownValue = 'All';

  @override
  void initState() {
    super.initState();
    if (widget.animal != null) {
      setState(() {
        animalDropdownValue = widget.animal!;
        Future(() => ref.read(storeItemsControllerProvider.notifier).changeAnimal(widget.animal!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final storeItems = ref.watch(storeItemsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Items'),
        actions: [
          CartIcon(),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              spacing: 16.0,
              children: [
                DropdownButton<String>(
                  value: animalDropdownValue,
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: const Icon(Icons.pets),
                  ),
                  elevation: 16,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                  underline: Container(
                    height: 1,
                    color: Theme.of(context).primaryColor,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      animalDropdownValue = value!;
                      ref.read(storeItemsControllerProvider.notifier).changeAnimal(value);
                    });
                  },
                  items: animalList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: productDropdownValue,
                  icon: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: const Icon(Icons.store),
                  ),
                  elevation: 16,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                  underline: Container(
                    height: 1,
                    color: Theme.of(context).primaryColor,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      productDropdownValue = value!;
                      ref.read(storeItemsControllerProvider.notifier).changeProduct(value);
                    });
                  },
                  items: productList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: switch (storeItems) {
              AsyncData(:final value) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DynamicHeightGridView(
                      itemCount: value.items.length,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      builder: (ctx, index) {
                        return StoreItemWidget(item: value.items[index]);
                      }),
                ),
              AsyncError() => Center(child: const Text('Oops, something unexpected happened')),
              _ => Center(child: const CircularProgressIndicator()),
            },
          ),
        ],
      ),
    );
  }
}
