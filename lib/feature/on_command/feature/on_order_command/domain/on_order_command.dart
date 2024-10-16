import 'package:teledart/model.dart';

abstract class OnOrderCommand {
  void call(TeleDartMessage message);
}
