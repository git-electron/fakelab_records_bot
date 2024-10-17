import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_service_type.dart';

part 'order_service_model.freezed.dart';
part 'order_service_model.g.dart';

@freezed
class OrderService with _$OrderService {

  factory OrderService({
    required OrderServiceType type,
    required double totalCost,
    required bool costFrom,
  }) = _OrderService;

  factory OrderService.fromJson(Map<String, dynamic> json) => _$OrderServiceFromJson(json);
}