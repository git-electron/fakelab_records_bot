import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../../../../../core/i18n/app_localization.g.dart';
import '../../../domain/models/order_mix_and_mastering_markup.dart';
import '../../on_callback_confirm/domain/models/order_service_type.dart';
import '../../on_callback_confirm/domain/models/order_type.dart';
import 'on_callback_order_mix_and_mastering.dart';

@Singleton(as: OnCallbackOrderMixAndMastering)
class OnCallbackOrderMixAndMasteringImpl
    implements OnCallbackOrderMixAndMastering {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final OrderMixAndMasteringMarkup orderMixAndMasteringMarkup;

  OnCallbackOrderMixAndMasteringImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.orderMixAndMasteringMarkup,
  });

  @override
  void call(TeleDartCallbackQuery callback) {
    try {
      final Message? message = callback.message;

      if (message == null) return;

      final Chat chat = message.chat;
      final String mixCost = OrderServiceType.MIX.totalCostFormatted;
      final String masteringCost =
          OrderServiceType.MASTERING.totalCostFormatted;
      final String totalCost = OrderType.MIX_AND_MASTERING.totalCostFormatted;

      teledart.answerCallbackQuery(callback.id);
      teledart.editMessageText(
        translations.texts.order_mix_and_mastering_text(
          mixCost: mixCost,
          masteringCost: masteringCost,
          totalCost: totalCost,
        ),
        chatId: chat.id,
        messageId: message.messageId,
        parseMode: 'HTML',
        replyMarkup: orderMixAndMasteringMarkup(),
      );
    } catch (error) {
      logger.e(error);
    }
  }
}
