import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/domain/model/user_model.dart';
import 'order_filters_model.dart';
import 'order_service_model.dart';
import 'order_status.dart';
import 'order_status_history_item_model.dart';
import 'order_type.dart';
import 'rating_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class Order with _$Order {
  factory Order({
    required String id,
    required User customer,
    required OrderType type,
    required OrderStatus status,
    required List<OrderStatusHistoryItem> statusHistory,
    required DateTime dateCreated,
    required double totalCost,
    required bool costFrom,
    required List<OrderService> services,
    required OrderFilters filters,
    Rating? rating,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
