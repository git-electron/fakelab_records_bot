import 'package:teledart/model.dart';

abstract class OnSendCommand {
  void call(TeleDartMessage message);
}
