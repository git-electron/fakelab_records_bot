import 'package:fakelab_records_bot/core/constants/constants.dart';
import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';
import 'package:fakelab_records_bot/core/domain/model/support_request_status.dart';
import 'package:fakelab_records_bot/core/domain/model/user_model.dart';
import 'package:fakelab_records_bot/core/domain/service/support_service.dart';
import 'package:fakelab_records_bot/core/extensions/date_time_extensions.dart';
import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:fakelab_records_bot/feature/on_callback/domain/models/main_menu_markup.dart';
import 'package:fakelab_records_bot/feature/on_callback/domain/models/on_support_request_complete_markup.dart';
import 'package:fakelab_records_bot/feature/on_command/data/repository/get_user_repository.dart';
import 'package:fakelab_records_bot/feature/on_command/feature/on_support_request_complete_command/data/repository/delete_support_request_repository.dart';
import 'package:fakelab_records_bot/feature/on_command/feature/on_support_request_complete_command/domain/on_support_request_complete_command.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart' hide User;
import 'package:teledart/teledart.dart';

@Singleton(as: OnSupportRequestCompleteCommand)
class OnSupportRequestCompleteCommandImpl
    implements OnSupportRequestCompleteCommand {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final SupportService supportService;
  final MainMenuMarkup mainMenuMarkup;
  final GetUserRepository getUserRepository;
  final DeleteSupportRequestRepository deleteSupportRequestRepository;
  final OnSupportRequestCompleteMarkup onSupportRequestCompleteMarkup;

  OnSupportRequestCompleteCommandImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.supportService,
    required this.mainMenuMarkup,
    required this.getUserRepository,
    required this.deleteSupportRequestRepository,
    required this.onSupportRequestCompleteMarkup,
  });

  @override
  void call(TeleDartMessage message) async {
    try {
      if (message.from == null) return;

      final int? userId = message.from?.id;

      if (userId == null) return;

      final bool isAdmin = Constants.adminAccountIds.contains(userId);

      if (!isAdmin) return;

      final List<SupportRequest> requests = supportService.supportRequests;

      final SupportRequest currentRequest = requests
          .where((SupportRequest request) =>
              request.adminId == userId &&
              request.status == SupportRequestStatus.IN_PROGRESS)
          .first;

      await deleteSupportRequestRepository(currentRequest.chatId);

      await teledart.sendMessage(
        message.chat.id,
        translations.admin.texts.delete_support_request_text(
          requestId: currentRequest.chatId,
          request: translations.admin.cards.support_request.card(
            chatId: currentRequest.chatId,
            dateCreated: currentRequest.dateCreated.dateFormatted,
            status: translations.admin.cards.support_request.status.completed,
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
        replyMarkup: onSupportRequestCompleteMarkup(),
      );

      await teledart.sendMessage(
        currentRequest.chatId,
        translations.texts.administrator_disconnected_text,
        parseMode: Constants.parseMode,
      );
      await Future.delayed(const Duration(seconds: 1));

      final User? user = await getUserRepository(currentRequest.chatId);

      if (user == null) return;

      await _sendRegisteredMessage(
        currentRequest.chatId,
        firstName: user.firstName,
      );
    } catch (error) {
      logger.e(error);
    }
  }

  Future<void> _sendRegisteredMessage(
    dynamic chatId, {
    required String? firstName,
  }) async {
    await teledart.sendMessage(
      chatId,
      translations.texts.main_menu_text(
        firstName: firstName ?? translations.user,
      ),
      parseMode: Constants.parseMode,
      replyMarkup: mainMenuMarkup(chatId),
    );
  }
}
