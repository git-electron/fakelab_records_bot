import 'package:fakelab_records_bot/core/domain/model/support_request_status.dart';
import 'package:fakelab_records_bot/feature/on_message/feature/on_support_message_sent_to_admin/domain/on_support_message_sent_to_admin.dart';
import 'package:fakelab_records_bot/feature/on_message/feature/on_support_message_sent_to_user/domain/on_support_message_sent_to_user.dart';

import '../../../core/domain/model/support_request_model.dart';
import '../../../core/domain/service/support_service.dart';
import '../feature/on_support_request_received/domain/on_support_request_received.dart';

import '../feature/on_contact_received/domain/on_contact_received.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:injectable/injectable.dart';
import 'on_message_listener.dart';

@Singleton(as: OnMessageListener)
class OnMessageListenerImpl implements OnMessageListener {
  final Logger logger;
  final SupportService supportService;
  final OnContactReceived onContactReceived;
  final OnSupportRequestReceived onSupportRequestReceived;
  final OnSupportMessageSentToUser onSupportMessageSentToUser;
  final OnSupportMessageSentToAdmin onSupportMessageSentToAdmin;

  OnMessageListenerImpl({
    required this.logger,
    required this.supportService,
    required this.onContactReceived,
    required this.onSupportRequestReceived,
    required this.onSupportMessageSentToUser,
    required this.onSupportMessageSentToAdmin,
  });

  @override
  void call(TeleDartMessage message) {
    try {
      if (message.contact != null) {
        final Contact contact = message.contact!;
        return onContactReceived(message, contact: contact);
      }

      final List<SupportRequest> supportRequests =
          supportService.supportRequests;

      final bool hasUserSupportRequestWithoutMessage = supportRequests
          .where((SupportRequest request) =>
              request.chatId == message.chat.id &&
              request.status == SupportRequestStatus.REQUEST &&
              request.message == null)
          .isNotEmpty;

      if (hasUserSupportRequestWithoutMessage) {
        return onSupportRequestReceived(message);
      }

      final bool isAdminWithCurrentInProgressSupportRequest = supportRequests
          .where(
            (SupportRequest request) =>
                request.adminId == message.from?.id &&
                request.status == SupportRequestStatus.IN_PROGRESS,
          )
          .isNotEmpty;

      if (isAdminWithCurrentInProgressSupportRequest) {
        return onSupportMessageSentToUser(message);
      }

      final bool isUserWithCurrentInProgressSupportRequest = supportRequests
          .where(
            (SupportRequest request) =>
                request.chatId == message.from?.id &&
                request.status == SupportRequestStatus.IN_PROGRESS,
          )
          .isNotEmpty;

      if (isUserWithCurrentInProgressSupportRequest) {
        return onSupportMessageSentToAdmin(message);
      }
    } catch (error) {
      logger.e(error);
    }
  }
}
