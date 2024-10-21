import 'package:fakelab_records_bot/feature/on_message/feature/on_support_request_received/domain/on_support_request_received.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';

@Singleton(as: OnSupportRequestReceived)
class OnSupportRequestReceivedImpl implements OnSupportRequestReceived {
  final Logger logger;

  OnSupportRequestReceivedImpl({
    required this.logger,
  });

  @override
  void call(TeleDartMessage message) async {}
}
