import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:injectable/injectable.dart';
import 'package:fakelab_records_bot/feature/on_command/domain/on_command_listener.dart';

@Singleton(as: OnCommandListener)
class OnCommandListenerImpl implements OnCommandListener {
  final Logger logger;

  OnCommandListenerImpl({required this.logger});

  @override
  void call(TeleDartMessage message) {
    print('command received');
  }
}
