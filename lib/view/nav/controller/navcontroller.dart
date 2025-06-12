import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/core/LoginResponce/global_user.dart';
import 'package:leo_rigging_dashboard/view/admins/manageAdmins.dart';
import 'package:leo_rigging_dashboard/view/dashboard/dashboard.dart';

import '../../advertising/ads_home.dart';
import '../../cranes/cranes_home.dart';
import '../../users/users.dart';

class Navcontroller extends GetxController {
  List pages = [
    Dashboard(),
    const UserHomePage(),
    CraneHomePage(),
    const AdHomePage(),
    if (GlobalUser().currentUser!.admin.type == 'SUPPERADMIN')
      const AdminsPage(),
  ];

  late Rx<Widget> selectedBody = Rx<Widget>(pages[0]);
  RxInt selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
    selectedBody.value = pages[index];
  }

  void overlappingNav(Widget page) {
    selectedBody.value = page;
  }

  void overlappingNavClose() {
    selectedBody.value = pages[selectedIndex.value];
  }
}
