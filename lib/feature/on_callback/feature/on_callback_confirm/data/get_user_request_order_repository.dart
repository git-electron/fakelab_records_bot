import '../domain/models/order_type.dart';

import '../domain/models/order_model.dart';

abstract class GetUserRequestOrderRepository {
  Future<Order?> call(int userId, {required OrderType orderType});
}
