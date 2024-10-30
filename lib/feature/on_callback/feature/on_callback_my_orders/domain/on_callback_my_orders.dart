import 'package:teledart/model.dart';

abstract class OnCallbackMyOrders {
  void call(TeleDartCallbackQuery callback, {required bool showMoreButton});
}
