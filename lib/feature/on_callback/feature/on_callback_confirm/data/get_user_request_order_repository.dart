import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/models/order_type.dart';

import '../domain/models/order_model.dart';

abstract class GetUserRequestOrderRepository {
  Future<Order?> call(int userId, {required OrderType orderType});
}
