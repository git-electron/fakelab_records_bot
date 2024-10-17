import '../feature/on_contact_received/domain/on_contact_received.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:injectable/injectable.dart';
import 'on_message_listener.dart';

@Singleton(as: OnMessageListener)
class OnMessageListenerImpl implements OnMessageListener {
  final Logger logger;
  final OnContactReceived onContactReceived;

  OnMessageListenerImpl({
    required this.logger,
    required this.onContactReceived,
  });

  @override
  void call(TeleDartMessage message) {
    if (message.contact != null) {
      final Contact contact = message.contact!;
      onContactReceived(message, contact: contact);
    }
  }
}
