import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/view/dashboard/controller/dasboard_controller.dart';
import 'package:leo_rigging_dashboard/view/dashboard/widget/doughnutChart.dart';

import '../../widget/header.dart';
import 'widget/country_map.dart';
import 'widget/data_count_box.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final DasboardController controller = Get.put(DasboardController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return Column(
            children: [
              const Header(title: "Dashboard"),
              const SizedBox(height: 16),
              DashboardCountBox(
                dataCount: controller.dashboardData.value.dataCounts!,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 208, 208, 208),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            children: [
                              Text("Users based on country",style: Theme.of(context).textTheme.bodyLarge ,),
                              SizedBox(height: 16,),
                              Expanded(
                                child: InteractiveViewer(
                                  child: MapScreen(
                                    mapData:
                                        controller
                                            .dashboardData
                                            .value
                                            .countryMapsDatas!,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 208, 208, 208),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DoughnutChart(
                            user: controller.dashboardData.value.users!,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

