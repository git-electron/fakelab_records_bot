import '../../../../../core/constants/constants.dart';
import '../../../../../core/domain/model/support_request_model.dart';
import '../../../../../core/domain/model/support_request_status.dart';
import '../../../../../core/domain/service/support_service.dart';
import 'on_support_message_sent_to_user.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnSupportMessageSentToUser)
class OnSupportMessageSentToUserImpl implements OnSupportMessageSentToUser {
  final Logger logger;
  final TeleDart teledart;
  final SupportService supportService;

  OnSupportMessageSentToUserImpl({
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

      final bool isAdmin = Constants.adminAccountIds.contains(userId);

      if (!isAdmin) return;

      final List<SupportRequest> supportRequests =
          supportService.supportRequests;

      final SupportRequest currentRequest = supportRequests
          .where(
            (SupportRequest request) =>
                request.adminId == message.from?.id &&
                request.status == SupportRequestStatus.IN_PROGRESS,
          )
          .first;

      await teledart.sendMessage(
        currentRequest.chatId,
        message.text!,
        entities: message.entities,
      );
      // await teledart.setMessageReaction(
      //   message.chat.id,
      //   messageId: message.messageId,
      //   reaction: '✍',
      // ); //TODO
    } catch (error) {
      logger.e(error);
    }
  }
}
