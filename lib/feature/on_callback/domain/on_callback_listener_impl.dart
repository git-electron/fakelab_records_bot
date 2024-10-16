import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_go_to/domain/on_callback_go_to.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_order/domain/on_callback_order.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:injectable/injectable.dart';
import 'on_callback_listener.dart';

@Singleton(as: OnCallbackListener)
class OnCallbackListenerImpl implements OnCallbackListener {
  final Logger logger;
  final OnCallbackOrder onCallbackOrder;
  final OnCallbackGoTo onCallbackGoBack;

  OnCallbackListenerImpl({
    required this.logger,
    required this.onCallbackOrder,
    required this.onCallbackGoBack,
  });

  @override
  void call(TeleDartCallbackQuery callback) {
    switch (callback.data?.split(':').first) {
      case 'order':
        onCallbackOrder(callback);
        break;
      case 'go_to':
        onCallbackGoBack(callback);
        break;
      default:
        break;
    }
  }
}
