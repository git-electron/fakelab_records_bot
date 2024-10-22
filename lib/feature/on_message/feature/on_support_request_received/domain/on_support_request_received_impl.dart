import 'package:fakelab_records_bot/core/constants/constants.dart';
import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:fakelab_records_bot/feature/on_message/feature/on_support_request_received/data/add_message_to_support_request_repository.dart';
import 'package:fakelab_records_bot/feature/on_message/feature/on_support_request_received/domain/on_support_request_received.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnSupportRequestReceived)
class OnSupportRequestReceivedImpl implements OnSupportRequestReceived {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final AddMessageToSupportRequestRepository
      addMessageToSupportRequestRepository;

  OnSupportRequestReceivedImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.addMessageToSupportRequestRepository,
  });

  @override
  void call(TeleDartMessage message) async {
    try {
      final String? text = message.text;

      if (message.from == null || text == null) return;

      await addMessageToSupportRequestRepository(
        message.chat.id,
        message: text,
      );

      await teledart.sendMessage(
        message.chat.id,
        translations.texts.support_request_message_sent_text,
        parseMode: Constants.parseMode,
      );
    } catch (error) {
      logger.e(error);
    }
  }
}
