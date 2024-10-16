import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_order/domain/on_callback_order.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:injectable/injectable.dart';
import 'on_callback_listener.dart';

@Singleton(as: OnCallbackListener)
class OnCallbackListenerImpl implements OnCallbackListener {
  final Logger logger;
  final OnCallbackOrder onCallbackOrder;

  OnCallbackListenerImpl({
    required this.logger,
    required this.onCallbackOrder,
  });

  @override
  void call(TeleDartCallbackQuery result) {
    print('inline result chosen');
  }
}
