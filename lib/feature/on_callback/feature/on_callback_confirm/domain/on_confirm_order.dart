import 'package:teledart/model.dart';

import 'models/order_type.dart';

abstract class OnConfirmOrder {
  void call(
    TeleDartCallbackQuery callback, {
    required OrderType orderType,
  });
}
