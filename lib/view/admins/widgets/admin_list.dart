import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/view/admins/admin_access_panel.dart';
import 'package:leo_rigging_dashboard/view/admins/controller/admin_controller.dart';

import '../../nav/controller/navcontroller.dart';

class AdminGridview extends StatefulWidget {
  const AdminGridview({super.key});

  @override
  State<AdminGridview> createState() => _AdminGridviewState();
}

class _AdminGridviewState extends State<AdminGridview> {
  @override
  Widget build(BuildContext context) {
    final AdminController controller = Get.find<AdminController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final adminList = controller.filteredAdmin;

      if (adminList.isEmpty) {
        return const Center(child: Text("No admins available."));
      }
        final Navcontroller navController = Get.find<Navcontroller>();

      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 240,
          crossAxisSpacing: 20,
          mainAxisSpacing: 16,
          childAspectRatio: 4 / 4,
        ),
        itemCount: adminList.length,
        itemBuilder: (context, index) {
          final admin = adminList[index];

          return GestureDetector(
               onTap: () {
              navController.overlappingNav( AdminAccessPanel(),);
            },
           
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cGrey100,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(radius: 30),
                  const SizedBox(height: 8),
                  Text(
                    admin.adminName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    admin.email,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.cGrey),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
