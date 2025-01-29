import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_item.freezed.dart';
part 'store_item.g.dart';

@freezed
class StoreItem with _$StoreItem {
  factory StoreItem({
    required String id,
    required String name,
    required String image,
    required double price,
    required String description,
    required double rating,
    required List<String> about,
  }) = _StoreItem;

  /// Convert a JSON object into an [Activity] instance.
  /// This enables type-safe reading of the API response.
  factory StoreItem.fromJson(Map<String, dynamic> json) => _$StoreItemFromJson(json);
}
