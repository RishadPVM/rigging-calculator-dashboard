import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/view/cranes/controller/crane_controller.dart';
import 'package:leo_rigging_dashboard/view/cranes/crane_details.dart';
import 'package:leo_rigging_dashboard/view/nav/controller/navcontroller.dart';

class CraneGridview extends StatelessWidget {
  const CraneGridview({
    super.key,
    required this.navcontroller,
  });

  final Navcontroller navcontroller;

  @override
  Widget build(BuildContext context) {
    final CraneController controller = Get.find<CraneController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final craneList = controller.filteredCrean;

      if (craneList.isEmpty) {
        return const Center(child: Text("No cranes available."));
      }

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 16,
          mainAxisExtent: 350,
        ),
        itemCount: craneList.length,
        itemBuilder: (context, index) {
          final crane = craneList[index];

          return GestureDetector(
            onTap: () {
              navcontroller.overlappingNav(CraneDetails());
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cGrey100,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 196,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: NetworkImage(
                          crane.imageUrl.isNotEmpty
                              ? crane.imageUrl.first
                              : "https://via.placeholder.com/350",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    crane.model,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    crane.serviceType,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.cPrimary),
                  ),
                  Text(
                    "Year - ${crane.manufacturerYear}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    "Capacity - ${crane.liftingCapacity}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    "Main boom - ${crane.mainBoom}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

