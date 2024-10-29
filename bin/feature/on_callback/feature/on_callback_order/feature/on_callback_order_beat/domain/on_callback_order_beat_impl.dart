import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../../../../../../../core/constants/constants.dart';
import '../../../../../../../core/i18n/app_localization.g.dart';
import '../../../../../domain/models/order_beat_markup.dart';
import '../../../../on_callback_confirm/domain/models/order_type.dart';
import 'on_callback_order_beat.dart';

@Singleton(as: OnCallbackOrderBeat)
class OnCallbackOrderBeatImpl implements OnCallbackOrderBeat {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final OrderBeatMarkup orderBeatMarkup;

  OnCallbackOrderBeatImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.orderBeatMarkup,
  });

  @override
  void call(TeleDartCallbackQuery callback) async {
    try {
      final Message? message = callback.message;

      if (message == null) return;

      final Chat chat = message.chat;
      final String totalCost = OrderType.BEAT.totalCostFormatted;

      await teledart.editMessageText(
        translations.texts.order_beat_text(totalCost: totalCost),
        chatId: chat.id,
        messageId: message.messageId,
        parseMode: Constants.parseMode,
        replyMarkup: orderBeatMarkup(),
      );
      await teledart.answerCallbackQuery(callback.id);
    } catch (error) {
      logger.e(error);
    }
  }
}
