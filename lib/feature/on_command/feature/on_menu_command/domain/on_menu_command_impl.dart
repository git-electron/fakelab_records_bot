import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:fakelab_records_bot/feature/on_callback/domain/models/main_menu_markup.dart';
import 'package:fakelab_records_bot/feature/on_command/feature/on_menu_command/domain/on_menu_command.dart';
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
  void call(TeleDartMessage message) {
    teledart.sendMessage(
      message.chat.id,
      translations.texts.main_menu_text(
        firstName: message.from?.firstName ?? translations.user,
      ),
      parseMode: 'Markdown',
      replyMarkup: mainMenuMarkup(),
    );
  }
}
