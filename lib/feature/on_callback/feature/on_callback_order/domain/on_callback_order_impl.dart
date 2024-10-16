import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_order/domain/on_callback_order.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';

@Singleton(as: OnCallbackOrder)
class OnCallbackOrderImpl implements OnCallbackOrder {
  final Logger logger;

  OnCallbackOrderImpl({
    required this.logger,
  });

  @override
  void call(TeleDartCallbackQuery result) {
    print('order pressed');
  }
}
