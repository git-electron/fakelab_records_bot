import 'package:fakelab_records_bot/fakelab_records_bot.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/i18n/app_localization.g.dart';
import '../../../domain/models/admin_access_markup.dart';
import 'on_callback_admin_access.dart';

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
        translations.admin.texts.admin_access_text(version: version),
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
