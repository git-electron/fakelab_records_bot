import 'package:teledart/model.dart';

abstract class OnSupportMessageSentToUser {
  void call(TeleDartMessage message);
}
