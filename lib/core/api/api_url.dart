import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrl {
  
  static String baseurl = dotenv.env['API_BASE_URL']!;

  static String getAllUser = "${baseurl}users";
  static String getAllAds = "${baseurl}sponsor/getAllAds";
}
