import '../domain/models/order_model.dart';

abstract class CreateOrderRepository {
  Future<void> call(Order order);
}
