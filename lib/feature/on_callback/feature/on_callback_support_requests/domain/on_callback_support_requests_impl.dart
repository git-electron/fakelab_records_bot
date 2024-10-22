import 'package:fakelab_records_bot/core/domain/model/support_request_status.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/domain/model/support_request_model.dart';
import '../../../../../core/domain/service/support_service.dart';
import '../../../../../core/extensions/date_time_extensions.dart';
import '../../../../../core/i18n/app_localization.g.dart';
import '../../../domain/models/support_requests_markup.dart';
import 'on_callback_support_requests.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnCallbackSupportRequests)
class OnCallbackSupportRequestsImpl implements OnCallbackSupportRequests {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final SupportService supportService;
  final SupportRequestsMarkup supportRequestsMarkup;

  OnCallbackSupportRequestsImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.supportService,
    required this.supportRequestsMarkup,
  });

  @override
  void call(TeleDartCallbackQuery callback) async {
    try {
      final Message? message = callback.message;
      final bool isAdmin = Constants.adminAccountIds.contains(callback.from.id);

      if (message == null || !isAdmin) return;

      final Chat chat = message.chat;

      await teledart.editMessageText(
        translations.admin.texts.support_requests_text(
          supportRequests: _requests,
        ),
        chatId: chat.id,
        messageId: message.messageId,
        parseMode: Constants.parseMode,
        replyMarkup: supportRequestsMarkup(),
        disableWebPagePreview: true,
      );
      await teledart.answerCallbackQuery(callback.id);
    } catch (error) {
      logger.e(error);
    }
  }

  String get _requests {
    final List<SupportRequest> requests = supportService.supportRequests;

    if (requests.isEmpty) return translations.admin.errors.requests_empty;

    return requests.map((SupportRequest request) {
      return translations.admin.cards.support_request.card(
        chatId: request.chatId,
        dateCreated: request.dateCreated.dateFormatted,
        status: _requestStatus(request.status),
        admin: request.adminId != null
            ? translations.admin.cards.support_request.admin(
                adminUsername: request.adminUsername ?? 'null',
                adminId: request.adminId ?? 'null',
              )
            : translations.admin.cards.support_request.no_admin,
        message: request.message ??
            translations.admin.cards.support_request.no_message,
      );
    }).join('\n\n');
  }

  String _requestStatus(SupportRequestStatus requestStatus) {
    return switch (requestStatus) {
      SupportRequestStatus.REQUEST =>
        translations.admin.cards.support_request.status.request,
      SupportRequestStatus.IN_PROGRESS =>
        translations.admin.cards.support_request.status.in_progress,
    };
  }
}
