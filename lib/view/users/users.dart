import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/core/LoginResponce/global_user.dart';
import 'package:leo_rigging_dashboard/utils/enum.dart';
import 'package:leo_rigging_dashboard/view/users/widgets/user_table_body.dart';

import '../../utils/appcolors.dart';
import '../../widget/c_search_bar.dart';
import '../../widget/header.dart';
import 'controller/user_controller.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize UserController
    final UserController userController = Get.put(UserController());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(title: "Users"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TabBar(
                    dividerHeight: 48,
                    dividerColor: AppColors.cGrey100,
                    isScrollable: true,
                    tabAlignment: TabAlignment.center,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: const Color(0xFF9B1C1C),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    tabs: const [
                      Tab(
                        child: Row(
                          children: [
                            Icon(Icons.groups_2, size: 18),
                            SizedBox(width: 6),
                            Text("Users"),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: [
                            Icon(Icons.business_center, size: 18),
                            SizedBox(width: 6),
                            Text("Sponsors"),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: [
                            Icon(Icons.campaign, size: 18),
                            SizedBox(width: 6),
                            Text("Crane Sellers"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CsearchBar(
                    hintText: "Search...",
                    onChanged: (value) {
                      userController.searchUsers(value); // Trigger search
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              Expanded(
                child: Obx(
                  () => userController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : TabBarView(
                          children: [
                            GlobalUser().currentUser!.admin.roles.userView != true?
                            Center(child: Text("Permission Denied")):
                            
                          UserTable(
                            users: userController.filteredUsers,
                            userRole: UserRole.allUsers,
                          ),
                           GlobalUser().currentUser!.admin.roles.sponsorView != true?
                            Center(child: Text("Permission Denied")):
                          UserTable(
                            users: userController.filteredUsers.where((user) => user.sponsorAds.isNotEmpty).toList(),
                            userRole: UserRole.sponsors,
                          ),
                           GlobalUser().currentUser!.admin.roles!.craneSellerView != true?
                            Center(child: Text("Permission Denied")):
                          UserTable(
                            users: userController.filteredUsers.where((user) => user.cranes.isNotEmpty).toList(),
                            userRole: UserRole.craneSeller,
                          ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}