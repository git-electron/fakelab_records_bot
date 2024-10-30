import 'package:fakelab_records_bot/core/domain/service/chats_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart' hide User;
import 'package:teledart/teledart.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/domain/model/user_model.dart';
import '../../../../core/i18n/app_localization.g.dart';
import '../data/repository/get_user_repository.dart';
import '../feature/on_menu_command/domain/on_menu_command.dart';
import '../feature/on_order_command/domain/on_order_command.dart';
import '../feature/on_orders_command/domain/on_orders_command.dart';
import '../feature/on_start_command/domain/on_start_command.dart';
import '../feature/on_support_command/domain/on_support_command.dart';
import '../feature/on_support_request_apply_command/domain/on_support_request_apply_command.dart';
import '../feature/on_support_request_complete_command/domain/on_support_request_complete_command.dart';
import 'on_command_listener.dart';

@Singleton(as: OnCommandListener)
class OnCommandListenerImpl implements OnCommandListener {
  final Logger logger;
  final TeleDart teledart;
  final ChatsService chatsService;
  final Translations translations;
  final OnMenuCommand onMenuCommand;
  final OnStartCommand onStartCommand;
  final OnOrderCommand onOrderCommand;
  final OnOrdersCommand onOrdersCommand;
  final OnSupportCommand onSupportCommand;
  final GetUserRepository getUserRepository;
  final OnSupportRequestApplyCommand onSupportRequestApplyCommand;
  final OnSupportRequestCompleteCommand onSupportRequestCompleteCommand;

  OnCommandListenerImpl({
    required this.logger,
    required this.teledart,
    required this.chatsService,
    required this.translations,
    required this.onMenuCommand,
    required this.onStartCommand,
    required this.onOrderCommand,
    required this.onOrdersCommand,
    required this.onSupportCommand,
    required this.getUserRepository,
    required this.onSupportRequestApplyCommand,
    required this.onSupportRequestCompleteCommand,
  });

  @override
  void call(TeleDartMessage message) async {
    try {
      final String? command = message.text;
      final String? username = message.from?.username;
      final int? userId = message.from?.id;
      final int chatId = message.chat.id;

      final Set<int> chatsIds = chatsService.chatsIds;

      if (!chatsIds.contains(chatId)) chatsService.addChat(chatId);

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

      if (command.startsWith('/r')) {
        if (command == Constants.supportRequestCompleteCommand) {
          return onSupportRequestCompleteCommand(message);
        }

        return onSupportRequestApplyCommand(message);
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
        case Constants.ordersCommand:
          onOrdersCommand(message);
          break;
        case Constants.supportCommand:
          onSupportCommand(message);
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
      parseMode: Constants.parseMode,
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
