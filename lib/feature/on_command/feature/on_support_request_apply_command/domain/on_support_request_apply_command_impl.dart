import 'package:fakelab_records_bot/core/constants/constants.dart';
import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';
import 'package:fakelab_records_bot/core/domain/model/support_request_status.dart';
import 'package:fakelab_records_bot/core/domain/service/support_service.dart';
import 'package:fakelab_records_bot/core/extensions/date_time_extensions.dart';
import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:fakelab_records_bot/feature/on_command/feature/on_support_request_apply_command/domain/on_support_request_apply_command.dart';
import 'package:fakelab_records_bot/feature/on_command/feature/on_support_request_apply_command/domain/service/set_support_request_in_progress_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnSupportRequestApplyCommand)
class OnSupportRequestApplyCommandImpl implements OnSupportRequestApplyCommand {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final SupportService supportService;
  final SetSupportRequestInProgressService setSupportRequestInProgressService;

  OnSupportRequestApplyCommandImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.supportService,
    required this.setSupportRequestInProgressService,
  });

  @override
  void call(TeleDartMessage message) async {
    try {
      if (message.from == null) return;

      final String command = message.text!;
      final int? userId = message.from?.id;

      if (userId == null) return;

      final bool isAdmin = Constants.adminAccountIds.contains(userId);

      if (!isAdmin) return;

      final int? chatId = int.tryParse(command.split('/r').last);

      if (chatId == null) return;

      final SupportRequest? request = await setSupportRequestInProgressService(
        chatId,
        adminId: userId,
        adminUsername: message.from!.username,
      );

      if (request == null) {
        final SupportRequest currentRequest = supportService.supportRequests
            .where((SupportRequest request) =>
                request.status == SupportRequestStatus.IN_PROGRESS)
            .first;

        await teledart.sendMessage(
          message.chat.id,
          translations.admin.texts.another_support_request_in_progress_text(
            requestId: currentRequest.chatId,
            request: translations.admin.cards.support_request.card(
              chatId: currentRequest.chatId,
              dateCreated: currentRequest.dateCreated.dateFormatted,
              status: _requestStatus(currentRequest.status),
              admin: currentRequest.adminId != null
                  ? translations.admin.cards.support_request.admin(
                      adminUsername: currentRequest.adminUsername ?? 'null',
                      adminId: currentRequest.adminId ?? 'null',
                    )
                  : translations.admin.cards.support_request.no_admin,
              message: currentRequest.message ??
                  translations.admin.cards.support_request.no_message,
            ),
          ),
          parseMode: Constants.parseMode,
        );
      } else {
        await teledart.sendMessage(
          message.chat.id,
          translations.admin.texts
              .set_support_request_status_to_in_progress_text(
            requestId: request.chatId,
            request: translations.admin.cards.support_request.card(
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
            ),
          ),
          parseMode: Constants.parseMode,
        );

        await teledart.sendMessage(
          request.chatId,
          translations.texts.administrator_connected_text,
          parseMode: Constants.parseMode,
        );
      }
    } catch (error) {
      logger.e(error);
    }
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
