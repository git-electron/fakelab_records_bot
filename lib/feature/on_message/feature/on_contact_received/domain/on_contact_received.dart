import 'package:teledart/model.dart';

abstract class OnContactReceived {
  void call(Contact contact);
}
