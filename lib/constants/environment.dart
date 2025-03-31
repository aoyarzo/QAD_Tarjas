import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  
  static String url_devl = dotenv.env['URL_DEVL'] ?? '';
  static String url_test = dotenv.env['URL_TEST'] ?? '';
  static String url_prod = dotenv.env['URL_PROD'] ?? '';

}
