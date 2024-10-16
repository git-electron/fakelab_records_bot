import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:injectable/injectable.dart';
import 'package:fakelab_records_bot/feature/on_message/domain/on_message_listener.dart';

@Singleton(as: OnMessageListener)
class OnMessageListenerImpl implements OnMessageListener {
  final Logger logger;

  OnMessageListenerImpl({required this.logger});

  @override
  void call(TeleDartMessage message) {
    print('message received');
  }
}
