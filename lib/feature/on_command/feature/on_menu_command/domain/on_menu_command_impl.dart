import 'package:fakelab_records_bot/core/domain/model/user_model.dart';
import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:fakelab_records_bot/feature/on_callback/domain/models/main_menu_markup.dart';
import 'package:fakelab_records_bot/feature/on_command/feature/on_menu_command/domain/on_menu_command.dart';
import 'package:fakelab_records_bot/feature/on_command/feature/on_start_command/data/repository/get_user_repository.dart';
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
  final GetUserRepository getUserRepository;

  OnMenuCommandImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.mainMenuMarkup,
    required this.getUserRepository,
  });

  @override
  void call(TeleDartMessage message) async {
    final User? user = await getUserRepository(message.from!.id);

    if (user == null) {
      _sendUnregisteredMessage(message);
    } else {
      _sendRegisteredMessage(message);
    }
  }

  void _sendUnregisteredMessage(TeleDartMessage message) {
    teledart.sendMessage(
      message.chat.id,
      translations.texts.start_command_text_unregistered(
        firstName: message.from?.firstName ?? translations.user,
      ),
      parseMode: 'Markdown',
      replyMarkup: _replyMarkupUnregistered,
    );
  }

  ReplyKeyboardMarkup get _replyMarkupUnregistered {
    final KeyboardButton shareContact = KeyboardButton(
      text: translations.buttons.share_contact,
      requestContact: true,
    );

    final List<List<KeyboardButton>> keyboard = [
      [shareContact],
    ];

    final ReplyKeyboardMarkup markup = ReplyKeyboardMarkup(
      keyboard: keyboard,
      resizeKeyboard: true,
      oneTimeKeyboard: true,
    );

    return markup;
  }

  void _sendRegisteredMessage(TeleDartMessage message) {
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
