import 'package:fakelab_records_bot/core/converters/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_status.dart';

part 'order_status_history_item_model.freezed.dart';
part 'order_status_history_item_model.g.dart';

@freezed
class OrderStatusHistoryItem with _$OrderStatusHistoryItem {
  factory OrderStatusHistoryItem({
    required OrderStatus status,
    @DateTimeConverter() required DateTime dateChanged,
  }) = _OrderStatusHistoryItem;

  factory OrderStatusHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusHistoryItemFromJson(json);
}
