import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_order_mix/domain/on_callback_order_mix.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';

@Singleton(as: OnCallbackOrderMix)
class OnCallbackOrderMixImpl implements OnCallbackOrderMix {
  final Logger logger;

  OnCallbackOrderMixImpl({
    required this.logger,
  });

  @override
  void call(TeleDartCallbackQuery callback) {}
}
