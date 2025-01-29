import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:furry_flutter/features/store_items/domain/store_item.dart';

part 'store_item_list.freezed.dart';
part 'store_item_list.g.dart';

@freezed
class StoreItemList with _$StoreItemList {
  factory StoreItemList({
    required List<StoreItem> items,
  }) = _StoreItemList;

  factory StoreItemList.fromJson(Map<String, dynamic> json) => _$StoreItemListFromJson(json);
}
