import 'package:teledart/model.dart';

abstract class OnSupportCommand {
  void call(TeleDartMessage message);
}
