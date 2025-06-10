import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/view/admins/controller/admin_controller.dart';
import 'package:leo_rigging_dashboard/view/cranes/controller/crane_controller.dart';
import 'package:leo_rigging_dashboard/view/dashboard/controller/dasboard_controller.dart';

class InitalBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CraneController(),);
    Get.lazyPut(() => DasboardController(),);
    Get.lazyPut(() => AdminController(),);
  }
  
}