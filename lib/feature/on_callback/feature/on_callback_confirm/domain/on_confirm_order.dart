import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/models/order_type.dart';
import 'package:teledart/model.dart';

abstract class OnConfirmOrder {
  void call(
    TeleDartCallbackQuery callback, {
    required OrderType orderType,
  });
}
