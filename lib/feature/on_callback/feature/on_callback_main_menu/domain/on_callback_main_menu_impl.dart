import 'package:fakelab_records_bot/core/constants/constants.dart';

import '../../../../../core/i18n/app_localization.g.dart';
import '../../../domain/models/main_menu_markup.dart';
import 'on_callback_main_menu.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnCallbackMainMenu)
class OnCallbackMainMenuImpl implements OnCallbackMainMenu {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final MainMenuMarkup mainMenuMarkup;

  OnCallbackMainMenuImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.mainMenuMarkup,
  });

  @override
  void call(TeleDartCallbackQuery callback) async {
    try {
      final Message? message = callback.message;

      if (message == null) return;

      final Chat chat = message.chat;

      await teledart.editMessageText(
        translations.texts.main_menu_text(firstName: callback.from.firstName),
        chatId: chat.id,
        messageId: message.messageId,
        parseMode: Constants.parseMode,
        replyMarkup: mainMenuMarkup(),
      );
      await teledart.answerCallbackQuery(callback.id);
    } catch (error) {
      logger.e(error);
    }
  }
}
