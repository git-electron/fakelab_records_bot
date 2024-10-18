import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/models/order_model.dart';

import '../models/order_type.dart';

abstract class CreateOrderService {
  Future<Order?> call(
    int userId, {
    required OrderType orderType,
  });
}
