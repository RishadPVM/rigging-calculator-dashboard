

import 'dart:developer';

import 'package:leo_rigging_dashboard/core/api/api_service.dart';
import 'package:leo_rigging_dashboard/core/api/api_url.dart';
import 'package:leo_rigging_dashboard/view/auth/controller/auth_controller.dart';

import '../../model/auth_model.dart';
import '../LoginResponce/global_user.dart';

AuthController authcontroller = AuthController();
 final apiService = ApiService();

Future refreshUser() async {
  try {
    final response = await apiService.get("${ApiUrl.getOneadmin}/${GlobalUser().currentUser!.admin.id}");
      if (response['success'] == true && response['token'] != null) {
        log("*********** FUNCTION WORKING **************");
        final user = LoginResponse.fromJson(response);
         log(user.toString());
        await authcontroller.saveLoginData(user);
        GlobalUser().setUser(user);
        // final Navcontroller controller = Get.find<Navcontroller>();
        // controller.refreshPages();
        // Get.offAll(() => const NavPage());
      } else {
         log("*********** FUNCTION NOT WORKING **************");
      throw Exception("Error: ${response.statusCode}");
    }
  } catch (e) {
      log("*********** FUNCTION NOT WORKING CATCH **************");
    throw Exception("Error: $e");
  }
}