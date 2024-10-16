// ignore_for_file: non_constant_identifier_names

import 'package:dotenv/dotenv.dart';

class DotEnvConstants {
  static final DotEnv dotEnv = DotEnv()..load();

  static final String TELEGRAM_API_TOKEN = dotEnv['TELEGRAM_API_TOKEN']!;
  static final String FIREBASE_API_KEY = dotEnv['FIREBASE_API_KEY']!;
  static final String FIREBASE_AUTH_DOMAIN = dotEnv['FIREBASE_AUTH_DOMAIN']!;
  static final String FIREBASE_DATABASE_URL = dotEnv['FIREBASE_DATABASE_URL']!;
  static final String FIREBASE_PROJECT_ID = dotEnv['FIREBASE_PROJECT_ID']!;
  static final String FIREBASE_STORAGE_BUCKET = dotEnv['FIREBASE_STORAGE_BUCKET']!;
  static final String FIREBASE_MESSAGING_SENDER_ID = dotEnv['FIREBASE_MESSAGING_SENDER_ID']!;
  static final String FIREBASE_APP_ID = dotEnv['FIREBASE_APP_ID']!;
  static final String FIREBASE_MEASUREMENT_ID = dotEnv['FIREBASE_MEASUREMENT_ID']!;
}
