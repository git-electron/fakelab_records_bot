import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';
import 'package:fakelab_records_bot/core/domain/model/support_request_status.dart';
import 'package:fakelab_records_bot/core/domain/service/support_service.dart';
import 'package:fakelab_records_bot/feature/on_message/feature/on_support_message_sent_to_admin/domain/on_support_message_sent_to_admin.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnSupportMessageSentToAdmin)
class OnSupportMessageSentToAdminImpl implements OnSupportMessageSentToAdmin {
  final Logger logger;
  final TeleDart teledart;
  final SupportService supportService;

  OnSupportMessageSentToAdminImpl({
    required this.logger,
    required this.teledart,
    required this.supportService,
  });

  @override
  void call(TeleDartMessage message) async {
    try {
      if (message.from == null || message.text == null) return;

      final int? userId = message.from?.id;

      if (userId == null) return;

      final List<SupportRequest> supportRequests =
          supportService.supportRequests;

      final SupportRequest currentRequest = supportRequests
          .where(
            (SupportRequest request) =>
                request.chatId == message.from?.id &&
                request.status == SupportRequestStatus.IN_PROGRESS,
          )
          .first;

      await teledart.sendMessage(
        currentRequest.adminId,
        message.text!,
        entities: message.entities,
      );
    } catch (error) {
      logger.e(error);
    }
  }
}
