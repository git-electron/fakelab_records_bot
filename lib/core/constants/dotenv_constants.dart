import 'package:dotenv/dotenv.dart';

class DotEnvConstants {
  static final DotEnv dotEnv = DotEnv()..load();

  static final String apiToken = dotEnv['API_TOKEN']!;
}
