import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrl {
  
  static String baseurl = dotenv.env['API_BASE_URL']!;

  static String getAllUser = "${baseurl}users";
  static String getAllCrane = "${baseurl}crane/";
  static String getDashboardData="${baseurl}app/getAppAnalytics";
  static String getAllAds = "${baseurl}sponsor/getAllAds";
  static String getAllCategory = "${baseurl}crane/category/all";
  static String getAllBrand = "${baseurl}crane/brand/all";
   static String getAllCraneEnuiry = "${baseurl}crane/inquiry";
   
   static String loginPost = "${baseurl}adminAuth/adminLogin";
  
  static String postBrand = "${baseurl}crane/brand/";
  static String postCategory = "${baseurl}crane/category/create";
  static String editBrand = "${baseurl}crane/brand/";
  static String editCategory = "${baseurl}crane/category";
  static String getAllAdPlans = "${baseurl}sponsor/getAllPlans/";
}