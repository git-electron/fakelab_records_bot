import 'package:fakelab_records_bot/core/domain/model/user_model.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/models/order_model.dart';

abstract class CreateOrderService {
  Future<Order?> call(Order order, {required User user});
}
