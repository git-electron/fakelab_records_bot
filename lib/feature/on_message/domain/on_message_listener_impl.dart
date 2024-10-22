import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';
import 'package:fakelab_records_bot/core/domain/service/support_service.dart';
import 'package:fakelab_records_bot/feature/on_message/feature/on_support_request_received/domain/on_support_request_received.dart';

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

  OnMessageListenerImpl({
    required this.logger,
    required this.supportService,
    required this.onContactReceived,
    required this.onSupportRequestReceived,
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
      final bool hasUserSupportRequest = supportRequests
          .where((SupportRequest request) =>
              request.chatId == message.chat.id && request.message == null)
          .isNotEmpty;
      if (hasUserSupportRequest) {
        return onSupportRequestReceived(message);
      }
    } catch (error) {
      logger.e(error);
    }
  }
}
