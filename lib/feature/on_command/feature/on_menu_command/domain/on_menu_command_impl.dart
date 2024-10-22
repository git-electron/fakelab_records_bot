import 'package:fakelab_records_bot/core/constants/constants.dart';

import '../../../../../core/i18n/app_localization.g.dart';
import '../../../../on_callback/domain/models/main_menu_markup.dart';
import 'on_menu_command.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart' hide User;
import 'package:teledart/teledart.dart';

@Singleton(as: OnMenuCommand)
class OnMenuCommandImpl implements OnMenuCommand {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final MainMenuMarkup mainMenuMarkup;

  OnMenuCommandImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.mainMenuMarkup,
  });

  @override
  void call(TeleDartMessage message) async {
    try {
      if (message.from == null) return;

      await teledart.sendMessage(
        message.chat.id,
        translations.texts.main_menu_text(
          firstName: message.from?.firstName ?? translations.user,
        ),
        parseMode: Constants.parseMode,
        replyMarkup: mainMenuMarkup(message.from!.id),
      );
    } catch (error) {
      logger.e(error);
    }
  }
}
