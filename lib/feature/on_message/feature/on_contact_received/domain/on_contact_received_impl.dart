import 'package:fakelab_records_bot/feature/on_message/feature/on_contact_received/domain/on_contact_received.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';

@Singleton(as: OnContactReceived)
class OnContactReceivedImpl implements OnContactReceived {
  final Logger logger;

  OnContactReceivedImpl({
    required this.logger,
  });

  @override
  void call(Contact contact) {
    print(contact.phoneNumber);
  }
}
