import '../domain/models/order_model.dart';

abstract class GetUserRequestOrderRepository {
  Future<Order?> call(int userId);
}
