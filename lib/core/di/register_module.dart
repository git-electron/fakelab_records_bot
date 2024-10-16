import 'package:logger/logger.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:firebase_dart/core.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_dart/database.dart' as db;
import 'di.dart';
import '../constants/dotenv_constants.dart';

import '../i18n/app_localization.g.dart';

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
  Telegram get telegram => Telegram(DotEnvConstants.TELEGRAM_API_TOKEN);

  @singleton
  @preResolve
  Future<Event> get event async => Event((await telegram.getMe()).username!);

  @singleton
  TeleDart get teledart =>
      TeleDart(DotEnvConstants.TELEGRAM_API_TOKEN, injector.get());

  @singleton
  @preResolve
  Future<FirebaseApp> get app async => await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: DotEnvConstants.FIREBASE_API_KEY,
          authDomain: DotEnvConstants.FIREBASE_AUTH_DOMAIN,
          databaseURL: DotEnvConstants.FIREBASE_DATABASE_URL,
          projectId: DotEnvConstants.FIREBASE_PROJECT_ID,
          storageBucket: DotEnvConstants.FIREBASE_STORAGE_BUCKET,
          messagingSenderId: DotEnvConstants.FIREBASE_MESSAGING_SENDER_ID,
          appId: DotEnvConstants.FIREBASE_APP_ID,
          measurementId: DotEnvConstants.FIREBASE_MEASUREMENT_ID,
        ),
      );

  @singleton
  db.FirebaseDatabase get database => db.FirebaseDatabase(
        app: injector.get(),
        databaseURL: DotEnvConstants.FIREBASE_DATABASE_URL,
      );

  @singleton
  db.DatabaseReference get reference =>
      injector<db.FirebaseDatabase>().reference();

  @singleton
  Translations get t => AppLocale.ru.build();
}
