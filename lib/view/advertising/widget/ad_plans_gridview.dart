import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/view/advertising/widget/ad_plan_card.dart';

import '../controller/ad_controller.dart';

class AdPlanGridView extends StatelessWidget {
  const AdPlanGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final AdController adController = Get.put(AdController());
    return Obx(() {
      if (adController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (adController.ads.isEmpty) {
        return const Center(
          child: Text(
            "No Plans available.",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        );
      }

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 200,
        ),
        itemCount: adController.plans.length,
        itemBuilder: (context, index) {
          final plan = adController.plans[index];
          return PlanCard(plan: plan);
        },
      );
    });
  }
}
