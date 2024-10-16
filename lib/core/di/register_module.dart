import 'package:fakelab_records_bot/core/constants/dotenv_constants.dart';
import 'package:fakelab_records_bot/core/di/di.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

@module
abstract class RegisterModule {
  @singleton
  Logger get logger => Logger(
        printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          dateTimeFormat: DateTimeFormat.dateAndTime,
        ),
      );

  @singleton
  Telegram get telegram => Telegram(DotEnvConstants.apiToken);

  @singleton
  @preResolve
  Future<Event> get event async => Event((await telegram.getMe()).username!);

  @singleton
  TeleDart get teledart => TeleDart(DotEnvConstants.apiToken, injector.get());
}
