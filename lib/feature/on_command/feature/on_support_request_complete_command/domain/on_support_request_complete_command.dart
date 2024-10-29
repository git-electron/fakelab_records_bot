import 'package:teledart/model.dart';

abstract class OnSupportRequestCompleteCommand {
  void call(TeleDartMessage message);
}
