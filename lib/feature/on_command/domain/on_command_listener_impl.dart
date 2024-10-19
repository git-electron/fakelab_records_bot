import '../../../core/domain/model/user_model.dart';
import '../../../core/i18n/app_localization.g.dart';
import '../data/repository/get_user_repository.dart';
import '../feature/on_menu_command/domain/on_menu_command.dart';
import '../feature/on_order_command/domain/on_order_command.dart';
import 'package:teledart/teledart.dart';

import '../../../core/constants/constants.dart';
import '../feature/on_start_command/domain/on_start_command.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart' hide User;
import 'package:injectable/injectable.dart';
import 'on_command_listener.dart';

@Singleton(as: OnCommandListener)
class OnCommandListenerImpl implements OnCommandListener {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final OnMenuCommand onMenuCommand;
  final OnStartCommand onStartCommand;
  final OnOrderCommand onOrderCommand;
  final GetUserRepository getUserRepository;

  OnCommandListenerImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.onMenuCommand,
    required this.onStartCommand,
    required this.onOrderCommand,
    required this.getUserRepository,
  });

  @override
  void call(TeleDartMessage message) async {
    try {
      final String? command = message.text;
      final String? username = message.from?.username;
      final int? userId = message.from?.id;

      logger.i('''Received a new command
Command: $command
Author: @$username (id$userId)''');

      if (command == null) {
        logger.e('Command is empty');
        return;
      }

      final User? user = await getUserRepository(message.from!.id);

      if (user == null) {
        logger.w('Unauthorized! Sending authorization message');
        await _sendUnregisteredMessage(message);
        return;
      }

      switch (command) {
        case Constants.startCommand:
          onStartCommand(message);
          break;
        case Constants.menuCommand:
          onMenuCommand(message);
          break;
        case Constants.orderCommand:
          onOrderCommand(message);
          break;
        default:
          logger.w('Invalid command: $command');
          break;
      }
    } catch (error) {
      logger.e('Failed to handle command', error: error);
    }
  }

  Future<void> _sendUnregisteredMessage(TeleDartMessage message) async {
    await teledart.sendMessage(
      message.chat.id,
      translations.texts.start_command_text_unregistered(
        firstName: message.from?.firstName ?? translations.user,
      ),
      parseMode: 'HTML',
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
}
