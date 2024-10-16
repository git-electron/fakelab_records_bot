import 'package:teledart/model.dart';

abstract class OnStartCommand {
  void call(TeleDartMessage message);
}
