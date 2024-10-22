import '../../../../../core/constants/constants.dart';
import '../../../../../core/i18n/app_localization.g.dart';
import '../../../domain/models/support_markup.dart';
import 'on_callback_support.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnCallbackSupport)
class OnCallbackSupportImpl implements OnCallbackSupport {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final SupportMarkup supportMarkup;

  OnCallbackSupportImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.supportMarkup,
  });

  @override
  void call(TeleDartCallbackQuery callback) async {
    try {
      final Message? message = callback.message;

      if (message == null) return;

      final Chat chat = message.chat;

      await teledart.editMessageText(
        translations.texts.support_text,
        chatId: chat.id,
        messageId: message.messageId,
        parseMode: Constants.parseMode,
        replyMarkup: supportMarkup(),
      );
      await teledart.answerCallbackQuery(callback.id);
    } catch (error) {
      logger.e(error);
    }
  }
}
