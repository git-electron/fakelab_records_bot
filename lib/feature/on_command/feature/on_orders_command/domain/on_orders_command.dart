import 'package:teledart/model.dart';

abstract class OnOrdersCommand {
  void call(TeleDartMessage message);
}
