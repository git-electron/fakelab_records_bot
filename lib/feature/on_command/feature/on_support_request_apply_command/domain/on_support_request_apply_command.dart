import 'package:teledart/model.dart';

abstract class OnSupportRequestApplyCommand {
  void call(TeleDartMessage message);
}
