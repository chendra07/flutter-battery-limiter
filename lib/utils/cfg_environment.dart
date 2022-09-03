import 'package:flutter_dotenv/flutter_dotenv.dart';

class CfgEnvironment {
  static String get filename {
    // return kReleaseMode ? '.env.production' : '.env.development';
    return '.env';
  }

  static String get baseUrl {
    return dotenv.env['BASE_URL'] ?? 'urlNotFound';
  }

  //Example:

  // static String get localUrl {
  //   return dotenv.env['LOCAL_URL'] ?? 'urlNotFound';
  // }

  // static String get googleAPIKey {
  //   return dotenv.env['GOOGLE_API_KEY'] ?? 'APINotFound';
  // }
}
