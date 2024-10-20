import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:fakelab_records_bot/feature/on_callback/domain/models/faq_markup.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_faq/domain/on_callback_faq.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnCallbackFaq)
class OnCallbackFaqImpl implements OnCallbackFaq {
  final Logger logger;
  final TeleDart teledart;
  final FaqMarkup faqMarkup;
  final Translations translations;

  OnCallbackFaqImpl({
    required this.logger,
    required this.teledart,
    required this.faqMarkup,
    required this.translations,
  });

  @override
  void call(TeleDartCallbackQuery callback) async {
    try {
      final Message? message = callback.message;

      if (message == null) return;

      final Chat chat = message.chat;

      await teledart.editMessageText(
        translations.texts.faq_text,
        chatId: chat.id,
        messageId: message.messageId,
        parseMode: 'HTML',
        replyMarkup: faqMarkup(),
        disableWebPagePreview: true,
      );
      await teledart.answerCallbackQuery(callback.id);
    } catch (error) {
      logger.e(error);
    }
  }
}
