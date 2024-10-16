import 'package:fakelab_records_bot/feature/on_callback/domain/models/main_menu_markup.dart';
import 'package:teledart/teledart.dart';

import '../../../../../core/i18n/app_localization.g.dart';

import 'on_start_command.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart' hide User;
import 'package:injectable/injectable.dart';

@Singleton(as: OnStartCommand)
class OnStartCommandImpl implements OnStartCommand {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final MainMenuMarkup mainMenuMarkup;

  OnStartCommandImpl({
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
