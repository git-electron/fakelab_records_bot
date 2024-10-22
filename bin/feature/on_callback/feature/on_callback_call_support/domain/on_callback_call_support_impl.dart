import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/domain/model/support_request_model.dart';
import '../../../../../core/i18n/app_localization.g.dart';
import '../../../domain/models/call_support_markup.dart';
import 'on_callback_call_support.dart';
import 'service/create_suport_request_service.dart';

@Singleton(as: OnCallbackCallSupport)
class OnCallbackCallSupportImpl implements OnCallbackCallSupport {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final CallSupportMarkup callSupportMarkup;
  final CreateSupportRequestService createSuportRequestService;

  OnCallbackCallSupportImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.callSupportMarkup,
    required this.createSuportRequestService,
  });

  @override
  void call(TeleDartCallbackQuery callback) async {
    try {
      final Message? message = callback.message;

      if (message == null || message.from == null) return;

      final Chat chat = message.chat;
      final String username = callback.from.username ?? '';
      final int userId = callback.from.id;

      final SupportRequest? supportRequest =
          await createSuportRequestService(message.chat.id);

      if (supportRequest == null) {
        await teledart.editMessageText(
          translations.texts.support_already_called_text,
          chatId: chat.id,
          messageId: message.messageId,
          parseMode: Constants.parseMode,
          replyMarkup: callSupportMarkup(),
        );
      } else {
        await teledart.editMessageText(
          translations.texts.call_support_text,
          chatId: chat.id,
          messageId: message.messageId,
          parseMode: Constants.parseMode,
        );
      }

      await teledart.answerCallbackQuery(callback.id);

      await Future.forEach(
        Constants.adminAccountIds,
        (int adminAccountId) async {
          await teledart.sendMessage(
            adminAccountId,
            translations.admin.notifications.new_request_text(
              username: username,
              userId: userId,
            ),
            parseMode: Constants.parseMode,
          );
        },
      );
    } catch (error) {
      logger.e(error);
    }
  }
}
