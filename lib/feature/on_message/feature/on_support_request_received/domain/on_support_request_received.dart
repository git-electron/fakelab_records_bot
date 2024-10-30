import 'package:teledart/model.dart';

abstract class OnSupportRequestReceived {
  void call(TeleDartMessage message);
}
