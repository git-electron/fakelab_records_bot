import '../models/order_model.dart';

import '../models/order_type.dart';

abstract class CreateOrderService {
  Future<Order?> call(
    int userId, {
    required OrderType orderType,
  });
}
