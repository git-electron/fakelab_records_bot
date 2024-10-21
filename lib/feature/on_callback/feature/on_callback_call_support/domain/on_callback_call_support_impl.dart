import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';
import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:fakelab_records_bot/feature/on_callback/domain/models/call_support_markup.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_call_support/domain/on_callback_call_support.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_call_support/domain/service/create_suport_request_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

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

      final SupportRequest? supportRequest =
          await createSuportRequestService(message.chat.id);

      if (supportRequest == null) {
        await teledart.editMessageText(
          translations.texts.support_already_called_text,
          chatId: chat.id,
          messageId: message.messageId,
          parseMode: 'HTML',
          replyMarkup: callSupportMarkup(),
        );
      } else {
        await teledart.editMessageText(
          translations.texts.call_support_text,
          chatId: chat.id,
          messageId: message.messageId,
          parseMode: 'HTML',
        );
      }

      await teledart.answerCallbackQuery(callback.id);
    } catch (error) {
      logger.e(error);
    }
  }
}
