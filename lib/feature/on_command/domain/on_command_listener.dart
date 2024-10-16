import 'package:teledart/model.dart';

abstract class OnCommandListener {
  void call(TeleDartMessage message);
}
