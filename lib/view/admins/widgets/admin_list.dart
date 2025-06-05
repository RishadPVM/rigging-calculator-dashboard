import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/view/admins/controller/adminController.dart';

class AdminGridview extends StatelessWidget {
  const AdminGridview({super.key});
  
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

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 16,
          mainAxisExtent: 350,
        ),
        itemCount: adminList.length,
        itemBuilder: (context, index) {
          final admin = adminList[index];

          return GestureDetector(
            onTap: () {
            //  controller.fetchAdminEnquiry(admin.id);

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
                      // image: DecorationImage(
                      //   // image: NetworkImage(
                      //   //   crane.imageUrl.isNotEmpty
                      //   //       ? crane.imageUrl.first
                      //   //       : "https://via.placeholder.com/350",
                      //   // ),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    admin.adminName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    admin.email,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.cPrimary),
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

