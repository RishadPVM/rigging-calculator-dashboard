import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/view/dashboard/dashboard.dart';

import '../../ad/ads.dart';
import '../../cranes/cranes_list.dart';
import '../../settings/settings.dart';
import '../../users/users.dart';

class Navcontroller extends GetxController {
  List pages = [
    Dashboard(),
    const UsersPage(),
    const CraneListPage(),
    const AdsPage(),
    const SettingsPage(),
  ];

  late Rx<Widget> selectedBody = Rx<Widget>(pages[0]);
  RxInt selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
    selectedBody.value = pages[index];
  }
  void overlappingNav(Widget page) {
    selectedBody.value =page;
  }
  void overlappingNavClose() {
    selectedBody.value=pages[selectedIndex.value];
  }
}
