import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/models/order_type.dart';

import '../../../../../core/i18n/app_localization.g.dart';
import 'on_callback_confirm.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import 'on_confirm_order.dart';

@Singleton(as: OnCallbackConfirm)
class OnCallbackConfirmImpl implements OnCallbackConfirm {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final OnConfirmOrder onConfirmOrder;

  OnCallbackConfirmImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.onConfirmOrder,
  });

  @override
  void call(TeleDartCallbackQuery callback) {
    final Message? message = callback.message;
    final String? item = callback.data?.split(':').last;

    if (message == null || item == null) return;

    try {
      onConfirmOrder(callback,
          orderType: switch (item) {
            'order_mix' => OrderType.MIX,
            'order_mastering' => OrderType.MASTERING,
            'order_mix_and_mastering' => OrderType.MIX_AND_MASTERING,
            'order_beat' => OrderType.BEAT,
            _ => throw Exception()
          });
    } catch (error) {
      print('no such method');
      teledart.answerCallbackQuery(
        callback.id,
        text: translations.errors.not_implemented,
        showAlert: true,
      );
    }
  }
}
