import 'package:teledart/model.dart';

abstract class OnSupportMessageSentToAdmin {
  void call(TeleDartMessage message);
}
