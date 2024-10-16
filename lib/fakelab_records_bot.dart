import 'dart:async';

import 'package:logger/logger.dart';
import 'package:teledart/teledart.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:fakelab_records_bot/feature/on_inline/on_inline.dart';
import 'package:fakelab_records_bot/feature/on_command/on_command.dart';
import 'package:fakelab_records_bot/feature/on_message/on_message.dart';

import 'core/di/di.dart';

Future<void> configure() async {
  FirebaseDart.setup();
  await configureDependencies();

  injector<Logger>().i('Starting configuration');
  injector<Logger>().i('Dependencies injected');

  final TeleDart teledart = injector.get();

  teledart.start();

  injector<Logger>().i(
    'Started as «Fakelab Records Bot»\nUrl: https://t.me/fakelab_records_bot',
  );

  teledart.onCommand().listen(injector<OnCommandListener>());

  teledart.onMessage().listen(injector<OnMessageListener>());

  teledart.onChosenInlineResult().listen(injector<OnInlineListener>());

  teledart.onCallbackQuery().listen((data) {
    print(data.data);
    teledart.answerCallbackQuery(data.id);
  });
}
