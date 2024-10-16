import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_go_to/domain/on_callback_go_to.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_order/domain/on_callback_order.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_order_beat/domain/on_callback_order_beat.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_order_mastering/domain/on_callback_order_mastering.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_order_mix/domain/on_callback_order_mix.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_order_mix_and_mastering/domain/on_callback_order_mix_and_mastering.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:injectable/injectable.dart';
import 'on_callback_listener.dart';

@Singleton(as: OnCallbackListener)
class OnCallbackListenerImpl implements OnCallbackListener {
  final Logger logger;
  final OnCallbackGoTo onCallbackGoTo;
  final OnCallbackOrder onCallbackOrder;
  final OnCallbackOrderMix onCallbackOrderMix;
  final OnCallbackOrderBeat onCallbackOrderBeat;
  final OnCallbackOrderMastering onCallbackOrderMastering;
  final OnCallbackOrderMixAndMastering onCallbackOrderMixAndMastering;

  OnCallbackListenerImpl({
    required this.logger,
    required this.onCallbackGoTo,
    required this.onCallbackOrder,
    required this.onCallbackOrderMix,
    required this.onCallbackOrderBeat,
    required this.onCallbackOrderMastering,
    required this.onCallbackOrderMixAndMastering,
  });

  @override
  void call(TeleDartCallbackQuery callback) {
    switch (callback.data?.split(':').first) {
      case 'order':
        onCallbackOrder(callback);
        break;
      case 'order_mix':
        onCallbackOrderMix(callback);
        break;
      case 'order_mastering':
        onCallbackOrderMastering(callback);
        break;
      case 'order_mix_and_mastering':
        onCallbackOrderMixAndMastering(callback);
        break;
      case 'order_beat':
        onCallbackOrderBeat(callback);
        break;
      case 'go_to':
        onCallbackGoTo(callback);
        break;
      default:
        break;
    }
  }
}
