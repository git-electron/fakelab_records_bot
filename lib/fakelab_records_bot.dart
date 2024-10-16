import 'dart:async';

import 'package:logger/logger.dart';
import 'package:teledart/teledart.dart';

import 'core/di/di.dart';

Future<void> configure() async {
  await configureDependencies();

  injector<Logger>().i('Starting configuration');
  injector<Logger>().i('Dependencies injected');

  injector<TeleDart>().start();

  injector<Logger>().i(
    'Started as «Fakelab Records Bot»\nUrl: https://t.me/fakelab_records_bot',
  );
}
