import 'package:fakelab_records_bot/core/constants/constants.dart';

import '../../../domain/models/order_markup.dart';
import 'on_callback_order.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../../../../../core/i18n/app_localization.g.dart';

@Singleton(as: OnCallbackOrder)
class OnCallbackOrderImpl implements OnCallbackOrder {
  final Logger logger;
  final TeleDart teledart;
  final OrderMarkup orderMarkup;
  final Translations translations;

  OnCallbackOrderImpl({
    required this.logger,
    required this.teledart,
    required this.orderMarkup,
    required this.translations,
  });

  @override
  void call(TeleDartCallbackQuery callback) async {
    try {
      final Message? message = callback.message;

      if (message == null) return;

      final Chat chat = message.chat;

      await teledart.editMessageText(
        translations.texts.order_text,
        chatId: chat.id,
        messageId: message.messageId,
        parseMode: Constants.parseMode,
        replyMarkup: orderMarkup(),
      );
      await teledart.answerCallbackQuery(callback.id);
    } catch (error) {
      logger.e(error);
    }
  }
}
