import 'dart:async';

import 'package:firebase_dart/firebase_dart.dart';
import 'package:logger/logger.dart';
import 'package:teledart/teledart.dart';

import 'core/di/di.dart';

Future<void> configure() async {
  await configureDependencies();
  FirebaseDart.setup();

  injector<Logger>().i('Starting configuration');
  injector<Logger>().i('Dependencies injected');

  final TeleDart teledart = injector.get();

  teledart.start();

  injector<Logger>().i(
    'Started as «Fakelab Records Bot»\nUrl: https://t.me/fakelab_records_bot',
  );

  teledart.onCommand();

  teledart.onMessage().listen((message) {
    injector<Logger>().i(message.from?.id);
  });

  teledart.onChosenInlineResult();
}
