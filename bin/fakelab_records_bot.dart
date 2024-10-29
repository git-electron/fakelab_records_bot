import 'dart:async';

import 'package:firebase_dart/firebase_dart.dart';
import 'package:logger/logger.dart';
import 'package:teledart/teledart.dart';

import 'core/di/di.dart';
import 'feature/on_callback/on_callback.dart';
import 'feature/on_command/on_command.dart';
import 'feature/on_message/on_message.dart';

late final bool isDevelopment;

Future<void> main(List<String> args) async {
  final String? environment = args.elementAtOrNull(0);
  isDevelopment = environment == '--development';

  FirebaseDart.setup();
  await configureDependencies();

  injector<Logger>().i('Starting configuration');
  injector<Logger>().i('Dependencies injected');

  final TeleDart teledart = injector.get();

  teledart.start();

  if (isDevelopment) {
    injector<Logger>().i(
      'Started as «Fakelab Records DEV»\nUrl: https://t.me/fklb_rcrds_test_bot',
    );
  } else {
    injector<Logger>().i(
      'Started as «Fakelab Records Bot»\nUrl: https://t.me/fakelab_records_bot',
    );
  }

  teledart.onCommand().listen(injector<OnCommandListener>());

  teledart.onMessage().listen(injector<OnMessageListener>());

  teledart.onCallbackQuery().listen(injector<OnCallbackListener>());
}
