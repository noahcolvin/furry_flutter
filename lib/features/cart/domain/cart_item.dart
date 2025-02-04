import 'package:furry_flutter/features/store_items/domain/store_item.dart';

class CartItem {
  final StoreItem storeItem;
  int quantity;

  CartItem({required this.storeItem, required this.quantity});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem && other.storeItem == storeItem && other.quantity == quantity;
  }

  @override
  int get hashCode => storeItem.hashCode ^ quantity.hashCode;
}
