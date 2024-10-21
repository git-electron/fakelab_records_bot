import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:fakelab_records_bot/feature/on_callback/domain/models/call_support_markup.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_call_support/domain/on_callback_call_support.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnCallbackCallSupport)
class OnCallbackCallSupportImpl implements OnCallbackCallSupport {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final CallSupportMarkup callSupportMarkup;

  OnCallbackCallSupportImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.callSupportMarkup,
  });

  @override
  void call(TeleDartCallbackQuery callback) async {
    try {
      final Message? message = callback.message;

      if (message == null) return;

      final Chat chat = message.chat;

      await teledart.editMessageText(
        translations.texts.call_support_text,
        chatId: chat.id,
        messageId: message.messageId,
        parseMode: 'HTML',
        replyMarkup: callSupportMarkup(),
      );
      await teledart.answerCallbackQuery(callback.id);
    } catch (error) {
      logger.e(error);
    }
  }
}
