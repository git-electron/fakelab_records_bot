import 'package:fakelab_records_bot/core/constants/constants.dart';
import 'package:fakelab_records_bot/core/domain/service/chats_service.dart';
import 'package:fakelab_records_bot/core/extensions/duration_extensions.dart';
import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:fakelab_records_bot/feature/on_callback/domain/models/on_mailing_complete_markup.dart';
import 'package:fakelab_records_bot/feature/on_command/feature/on_send_command/domain/on_send_command.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnSendCommand)
class OnSendCommandImpl implements OnSendCommand {
  final Logger logger;
  final TeleDart teledart;
  final ChatsService chatsService;
  final Translations translations;
  final OnMailingCompleteMarkup onMailingCompleteMarkup;

  OnSendCommandImpl({
    required this.logger,
    required this.teledart,
    required this.chatsService,
    required this.translations,
    required this.onMailingCompleteMarkup,
  });

  @override
  void call(TeleDartMessage message) async {
    try {
      if (message.from == null) return;

      final int? userId = message.from?.id;

      if (userId == null) return;

      final bool isAdmin = Constants.adminAccountIds.contains(userId);

      if (!isAdmin) return;

      final Message? replyMessage = message.replyToMessage;

      if (replyMessage == null || replyMessage.text == null) return;

      final Set<int> chatsIds = chatsService.chatsIds;

      int sentTo = 0;
      int errors = 0;
      final DateTime timeStarted = DateTime.now();

      await Future.forEach(chatsIds, (int chatId) async {
        try {
          await teledart.sendMessage(
            chatId,
            replyMessage.text!,
            entities: replyMessage.entities,
          );
          sentTo++;
        } catch (error) {
          logger.e(error);
          errors++;
        }
      });

      final DateTime timeEnded = DateTime.now();
      final String time = timeEnded.difference(timeStarted).formatted;

      await teledart.sendMessage(
        message.chat.id,
        translations.admin.texts.mailing_sent_text(
          chatsTotal: chatsIds.length,
          successCount: sentTo,
          errorCount: errors,
          time: time,
        ),
        parseMode: Constants.parseMode,
        replyMarkup: onMailingCompleteMarkup(),
      );
    } catch (error) {
      logger.e(error);
    }
  }
}
