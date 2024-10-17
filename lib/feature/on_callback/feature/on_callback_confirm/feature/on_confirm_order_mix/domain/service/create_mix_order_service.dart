import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/models/order_model.dart';

abstract class CreateMixOrderService {
  Future<Order?> call(int userId);
}
