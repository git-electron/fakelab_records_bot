import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/i18n/app_localization.g.dart';
import 'models/order_type.dart';
import 'on_callback_confirm.dart';
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
  void call(TeleDartCallbackQuery callback) async {
    final Message? message = callback.message;
    final String? item = callback.data?.split(':').last;

    if (message == null || item == null) return;

    try {
      onConfirmOrder(callback,
          orderType: switch (item) {
            Constants.orderMix => OrderType.MIX,
            Constants.orderMastering => OrderType.MASTERING,
            Constants.orderMixAndMastering => OrderType.MIX_AND_MASTERING,
            Constants.orderBeat => OrderType.BEAT,
            _ => throw Exception()
          });
    } catch (error) {
      try {
        await teledart.answerCallbackQuery(
          callback.id,
          text: translations.errors.not_implemented,
          showAlert: true,
        );
      } catch (error) {
        logger.e(error);
      }
    }
  }
}
