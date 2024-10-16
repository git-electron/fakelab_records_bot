import 'package:teledart/model.dart';

abstract class OnMessageListener {
  void call(TeleDartMessage message);
}
