import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/view/cranes/Widget/brand_category_dialoge.dart';
import 'package:leo_rigging_dashboard/view/cranes/Widget/brand_gridview.dart';
import 'package:leo_rigging_dashboard/view/cranes/Widget/category_gridview.dart';
import 'package:leo_rigging_dashboard/view/cranes/Widget/crane_gridview.dart';
import 'package:leo_rigging_dashboard/view/nav/controller/navcontroller.dart';
import 'package:leo_rigging_dashboard/widget/c_search_bar.dart';
import 'package:leo_rigging_dashboard/widget/header.dart';

import 'controller/crane_controller.dart';

class CraneListPage extends StatefulWidget {
  const CraneListPage({super.key});

  @override
  State<CraneListPage> createState() => _CraneListPageState();
}

class _CraneListPageState extends State<CraneListPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final CraneController _craneController = Get.put(CraneController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      _craneController.updateTabIndex(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Navcontroller navController = Get.find<Navcontroller>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Obx(
          ()=> Column(
            spacing: 16,
            children: [
              const Header(title: "Cranes"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TabBar(
                    controller: _tabController,
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
                      Tab(child: Text("Cranes")),
                      Tab(child: Text("Brand")),
                      Tab(child: Text("Category")),
                    ],
                  ),
                  Row(
                    children: [
                       CsearchBar(hintText: "Search", 
                      onChanged: (value) {
                        _craneController.searchCategoryAndBrand(value); // Trigger search
                      },),
                    _craneController.showAddButton.value
                          ? Row(
                              children: [
                                const SizedBox(width: 8),
                                Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.cRed100,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      _craneController.resetDialogState();
                                      showDialog(
                                        context: context,
                                        builder: (context) => BrandCategoryDialoge(
                                          isbrand: _craneController.tabIndex.value == 1,
                                          iscreate: true,
                                        ),
                                      ).then((result) {
                                        if (result != null) {
                                          developer.log('Dialog result: $result');
                                        }
                                      });
                                    },
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
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    CraneGridview(navcontroller: navController),
                    BrandGridview(),
                    CategoryGridView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}