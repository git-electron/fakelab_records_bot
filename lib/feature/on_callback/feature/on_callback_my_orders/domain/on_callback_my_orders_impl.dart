import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_my_orders/domain/on_callback_my_orders.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';

@Singleton(as: OnCallbackMyOrders)
class OnCallbackMyOrdersImpl implements OnCallbackMyOrders {
  final Logger logger;

  OnCallbackMyOrdersImpl({
    required this.logger,
  });

  @override
  void call(TeleDartCallbackQuery callback) {}
}
