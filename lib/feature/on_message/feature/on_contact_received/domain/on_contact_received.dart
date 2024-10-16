import 'package:teledart/model.dart';

abstract class OnContactReceived {
  void call(TeleDartMessage message, {required Contact contact});
}
