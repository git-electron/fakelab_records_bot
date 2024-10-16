import 'package:fakelab_records_bot/feature/on_command/feature/on_menu_command/domain/on_menu_command.dart';

import '../../../core/constants/constants.dart';
import '../feature/on_start_command/domain/on_start_command.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:injectable/injectable.dart';
import 'on_command_listener.dart';

@Singleton(as: OnCommandListener)
class OnCommandListenerImpl implements OnCommandListener {
  final Logger logger;
  final OnMenuCommand onMenuCommand;
  final OnStartCommand onStartCommand;

  OnCommandListenerImpl({
    required this.logger,
    required this.onMenuCommand,
    required this.onStartCommand,
  });

  @override
  void call(TeleDartMessage message) {
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

    switch (command) {
      case Constants.startCommand:
        onStartCommand(message);
        break;
      case Constants.menuCommand:
        onMenuCommand(message);
        break;
      default:
        logger.w('Invalid command: $command');
        break;
    }
  }
}
