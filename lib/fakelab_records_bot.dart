import 'dart:async';

import 'package:fakelab_records_bot/core/constants/constants.dart';
import 'package:fakelab_records_bot/core/domain/model/build_info_model.dart';
import 'package:fakelab_records_bot/core/extensions/date_time_extensions.dart';
import 'package:fakelab_records_bot/core/extensions/duration_extensions.dart';
import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:logger/logger.dart';
import 'package:teledart/teledart.dart';

import 'core/di/di.dart';
import 'feature/on_callback/on_callback.dart';
import 'feature/on_command/on_command.dart';
import 'feature/on_message/on_message.dart';

late final bool isDevelopment;

Future<void> configure(List<String> args) async {
  final String? environment = args.elementAtOrNull(0);
  isDevelopment = environment == '--development';

  final DateTime dateTimeStarted = DateTime.now();

  FirebaseDart.setup();
  await configureDependencies();

  injector<Logger>().i('Starting configuration');
  injector<Logger>().i('Dependencies injected');

  final TeleDart teledart = injector.get();

  teledart.start();

  final BuildInfoModel buildInfo = BuildInfoModel.retrieve();

  injector<Logger>().i(
    'Started as «Fakelab Records ${isDevelopment ? "DEV" : "Bot"} v${buildInfo.version}»\nUrl: https://t.me/fklb_rcrds_test_bot',
  );

  await Future.forEach(Constants.adminAccountIds, (int userId) async {
    await teledart.sendMessage(
      userId,
      injector<Translations>()
          .admin
          .notifications
          .bot_reloaded_text(version: buildInfo.version),
    );
    await _sendUptimeInfo(
      teledart: teledart,
      buildInfo: buildInfo,
      dateTimeStarted: dateTimeStarted,
    );
  });

  Timer.periodic(
    const Duration(days: 1),
    (Timer timer) async => _sendUptimeInfo(
      teledart: teledart,
      buildInfo: buildInfo,
      dateTimeStarted: dateTimeStarted,
    ),
  );

  injector<Logger>().i('Admins notified');

  teledart.onCommand().listen(injector<OnCommandListener>());

  teledart.onMessage().listen(injector<OnMessageListener>());

  teledart.onCallbackQuery().listen(injector<OnCallbackListener>());
}

Future<void> _sendUptimeInfo({
  required TeleDart teledart,
  required DateTime dateTimeStarted,
  required BuildInfoModel buildInfo,
}) async {
  await Future.forEach(Constants.adminAccountIds, (int userId) async {
    final DateTime now = DateTime.now();
    final String uptime = now.difference(dateTimeStarted).formatted;
    await teledart.sendMessage(
      userId,
      injector<Translations>().admin.notifications.uptime_text(
            uptime: uptime,
            version: buildInfo.version,
            reloadedDateTime:
                dateTimeStarted.toUtc().add(Duration(hours: 3)).formatted,
          ),
      parseMode: Constants.parseMode,
    );
  });
}
