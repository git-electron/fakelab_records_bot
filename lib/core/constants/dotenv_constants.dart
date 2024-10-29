// ignore_for_file: non_constant_identifier_names

import 'package:dotenv/dotenv.dart';
import '../../fakelab_records_bot.dart';

class DotEnvConstants {
  static final DotEnv dotEnv = DotEnv()..load();

  static String get TELEGRAM_API_TOKEN => isDevelopment
      ? dotEnv['TELEGRAM_API_TOKEN_DEV']!
      : dotEnv['TELEGRAM_API_TOKEN_PROD']!;

  static String get FIREBASE_API_KEY => isDevelopment
      ? dotEnv['FIREBASE_API_KEY_DEV']!
      : dotEnv['FIREBASE_API_KEY_PROD']!;

  static String get FIREBASE_AUTH_DOMAIN => isDevelopment
      ? dotEnv['FIREBASE_AUTH_DOMAIN_DEV']!
      : dotEnv['FIREBASE_AUTH_DOMAIN_PROD']!;

  static String get FIREBASE_DATABASE_URL => isDevelopment
      ? dotEnv['FIREBASE_DATABASE_URL_DEV']!
      : dotEnv['FIREBASE_DATABASE_URL_PROD']!;

  static String get FIREBASE_PROJECT_ID => isDevelopment
      ? dotEnv['FIREBASE_PROJECT_ID_DEV']!
      : dotEnv['FIREBASE_PROJECT_ID_PROD']!;

  static String get FIREBASE_STORAGE_BUCKET => isDevelopment
      ? dotEnv['FIREBASE_STORAGE_BUCKET_DEV']!
      : dotEnv['FIREBASE_STORAGE_BUCKET_PROD']!;

  static String get FIREBASE_MESSAGING_SENDER_ID => isDevelopment
      ? dotEnv['FIREBASE_MESSAGING_SENDER_ID_DEV']!
      : dotEnv['FIREBASE_MESSAGING_SENDER_ID_PROD']!;

  static String get FIREBASE_APP_ID => isDevelopment
      ? dotEnv['FIREBASE_APP_ID_DEV']!
      : dotEnv['FIREBASE_APP_ID_PROD']!;

  static String get FIREBASE_MEASUREMENT_ID => isDevelopment
      ? dotEnv['FIREBASE_MEASUREMENT_ID_DEV']!
      : dotEnv['FIREBASE_MEASUREMENT_ID_PROD']!;
}
