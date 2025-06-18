import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/view/advertising/controller/ad_controller.dart';
import 'package:leo_rigging_dashboard/view/advertising/widget/ad_gridview.dart';
import 'package:leo_rigging_dashboard/view/advertising/widget/ad_plans_gridview.dart';
import 'package:leo_rigging_dashboard/view/advertising/widget/create_edit_plan_pop.dart';
import 'package:leo_rigging_dashboard/widget/header.dart';

import '../../core/LoginResponce/global_user.dart';
import '../../widget/c_search_bar.dart';

class AdHomePage extends StatelessWidget {
  const AdHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdController());

    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              controller.changeTab(tabController.index);
            }
          });

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Header(title: "Advertisements"),
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
                                Icon(Icons.ad_units, size: 18),
                                SizedBox(width: 6),
                                Text("All Ads"),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              children: [
                                Icon(Icons.receipt_long_sharp, size: 18),
                                SizedBox(width: 6),
                                Text("Advertisers plans"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Obx(() => Row(
                            children: [
                              CsearchBar(
                                hintText: "Search",
                                onChanged: (value) {},
                              ),
                              const SizedBox(width: 8),
                              if (controller.selectedIndex.value == 1 &&  GlobalUser().currentUser!.admin.roles.adsPlanCreate == true)
                                Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.cRed100,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: TextButton.icon(
                                    onPressed: ()=>  addEditPlanPop(context),
                                    label: const Text(
                                      "Add New",
                                      style: TextStyle(
                                        color: AppColors.cPrimary,
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.add,
                                      color: AppColors.cPrimary,
                                    ),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                   Expanded(
                    child: TabBarView(
                      children: [
                       GlobalUser().currentUser!.admin.roles.adsView == true? AdGridView():   Center(child: Text("Permission Denied")),
                        GlobalUser().currentUser!.admin.roles.adsPlanView == true?  AdPlanGridView():Center(child: Text("Permission Denied")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
