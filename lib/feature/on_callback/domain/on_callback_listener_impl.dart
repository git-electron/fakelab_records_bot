import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_my_orders/domain/on_callback_my_orders.dart';

import '../../../core/i18n/app_localization.g.dart';
import '../feature/on_callback_confirm/domain/on_callback_confirm.dart';
import '../feature/on_callback_go_to/domain/on_callback_go_to.dart';
import '../feature/on_callback_order/domain/on_callback_order.dart';
import '../feature/on_callback_order_beat/domain/on_callback_order_beat.dart';
import '../feature/on_callback_order_mastering/domain/on_callback_order_mastering.dart';
import '../feature/on_callback_order_mix/domain/on_callback_order_mix.dart';
import '../feature/on_callback_order_mix_and_mastering/domain/on_callback_order_mix_and_mastering.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:injectable/injectable.dart';
import 'package:teledart/teledart.dart';
import 'on_callback_listener.dart';

@Singleton(as: OnCallbackListener)
class OnCallbackListenerImpl implements OnCallbackListener {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final OnCallbackGoTo onCallbackGoTo;
  final OnCallbackOrder onCallbackOrder;
  final OnCallbackConfirm onCallbackConfirm;
  final OnCallbackOrderMix onCallbackOrderMix;
  final OnCallbackMyOrders onCallbackMyOrders;
  final OnCallbackOrderBeat onCallbackOrderBeat;
  final OnCallbackOrderMastering onCallbackOrderMastering;
  final OnCallbackOrderMixAndMastering onCallbackOrderMixAndMastering;

  OnCallbackListenerImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.onCallbackGoTo,
    required this.onCallbackOrder,
    required this.onCallbackConfirm,
    required this.onCallbackOrderMix,
    required this.onCallbackMyOrders,
    required this.onCallbackOrderBeat,
    required this.onCallbackOrderMastering,
    required this.onCallbackOrderMixAndMastering,
  });

  @override
  void call(TeleDartCallbackQuery callback) async {
    logger.i('''Callback button pressed
Callback ID: ${callback.id}
Callback data: ${callback.data}
Callback triggerer: @${callback.from.username} (id${callback.from.id})''');

    final String? callbackData = callback.data;

    if (callbackData == null) return;

    final callbackAction = callbackData.split(':').first;

    try {
      switch (callbackAction) {
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
        case 'confirm':
          onCallbackConfirm(callback);
          break;
        case 'my_orders':
          onCallbackMyOrders(
            callback,
            showMoreButton: callbackData.split(':').last == 'more', //TODO: !=
          );
          break;
        default:
          await teledart.answerCallbackQuery(
            callback.id,
            text: translations.errors.not_implemented,
            showAlert: true,
          );
          break;
      }
    } catch (error) {
      logger.e('Failed to answer callback query', error: error);
    }
  }
}
