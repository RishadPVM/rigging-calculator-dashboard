import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/LoginResponce/global_user.dart';
import '../../admins/manageAdmins.dart';
import '../../advertising/ads_home.dart';
import '../../cranes/cranes_home.dart';
import '../../dashboard/dashboard.dart';
import '../../users/users.dart';

class Navcontroller extends GetxController {
  final RxList<Widget> pages = <Widget>[].obs;
  late Rx<Widget> selectedBody;
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializePages();
    refreshPages();
  }

  void _initializePages() {
    pages.clear();
    pages.addAll([
      Dashboard(),
      const UserHomePage(),
      CraneHomePage(),
      const AdHomePage(),
    ]);

    if (GlobalUser().currentUser?.admin.type == 'SUPPERADMIN') {
      pages.add(const AdminsPage());
    }

    selectedBody = Rx<Widget>(pages[0]);
  }

  void refreshPages() {
    _initializePages();
    selectedBody.value = pages[selectedIndex.value];
  }

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
