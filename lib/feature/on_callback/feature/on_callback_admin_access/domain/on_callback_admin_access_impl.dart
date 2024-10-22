import 'package:fakelab_records_bot/core/constants/constants.dart';
import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:fakelab_records_bot/feature/on_callback/domain/models/admin_access_markup.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_admin_access/domain/on_callback_admin_access.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnCallbackAdminAccess)
class OnCallbackAdminAccessImpl implements OnCallbackAdminAccess {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final AdminAccessMarkup adminAccessMarkup;

  OnCallbackAdminAccessImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.adminAccessMarkup,
  });

  @override
  void call(TeleDartCallbackQuery callback) async {
    try {
      final Message? message = callback.message;
      final bool isAdmin = Constants.adminAccountIds.contains(callback.from.id);

      if (message == null || !isAdmin) return;

      final Chat chat = message.chat;

      await teledart.editMessageText(
        translations.admin.texts.admin_access_text,
        chatId: chat.id,
        messageId: message.messageId,
        parseMode: Constants.parseMode,
        replyMarkup: adminAccessMarkup(),
        disableWebPagePreview: true,
      );
      await teledart.answerCallbackQuery(callback.id);
    } catch (error) {
      logger.e(error);
    }
  }
}
