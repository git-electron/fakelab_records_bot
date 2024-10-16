import 'package:teledart/model.dart';

abstract class OnMenuCommand {
  void call(TeleDartMessage message);
}
