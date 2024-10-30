import 'package:fakelab_records_bot/core/constants/constants.dart';
import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:fakelab_records_bot/feature/on_command/feature/on_send_command/domain/on_send_command.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnSendCommand)
class OnSendCommandImpl implements OnSendCommand {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;

  OnSendCommandImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
  });

  @override
  void call(TeleDartMessage message) async {
    try {
      if (message.from == null) return;

      final int? userId = message.from?.id;

      if (userId == null) return;

      final bool isAdmin = Constants.adminAccountIds.contains(userId);

      if (!isAdmin) return;

      await teledart.sendMessage(
        message.chat.id,
        'text',
        parseMode: Constants.parseMode,
      );
    } catch (error) {
      logger.e(error);
    }
  }
}
