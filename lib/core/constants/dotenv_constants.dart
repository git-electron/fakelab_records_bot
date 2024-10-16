import 'package:dotenv/dotenv.dart';

class DotEnvConstants {
  static final DotEnv dotEnv = DotEnv()..load();

  static final String apiToken = dotEnv['API_TOKEN']!;

  static final String realtimeDatabaseUrl = dotEnv['REALTIME_DATABASE_URL']!;
}
