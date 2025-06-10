import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/view/admins/controller/adminController.dart';

class AdminGridview extends StatefulWidget {
  const AdminGridview({super.key});

  @override
  State<AdminGridview> createState() => _AdminGridviewState();
}

class _AdminGridviewState extends State<AdminGridview> {
  final Map<int, Set<String>> selectedRoles = {};
  final List<String> roleOptions = ['Admin', 'Editor', 'Viewer'];

  void _showRoleDialog(BuildContext context, int index, String name) {
    Set<String> currentRoles = Set.from(selectedRoles[index] ?? <String>{});

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Roles for $name"),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return SizedBox(
                width: 400,
                child: ListView(
                  shrinkWrap: true,
                  children: roleOptions.map((role) {
                    final isSelected = currentRoles.contains(role);
                    return CheckboxListTile(
                      value: isSelected,
                      title: Text(role,style: TextStyle(color: Colors.black),),
                      onChanged: (bool? value) {
                        setDialogState(() {
                          setState(() {
                            if (value == true) {
                              currentRoles.add(role);
                            } else {
                              currentRoles.remove(role);
                            }
                            selectedRoles[index] = currentRoles;
                          });
                        });
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Done"),
            ),
          ],
        );
      },
    );
  }

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
              // controller.fetchAdminEnquiry(admin.id);
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
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.cPrimary),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        _showRoleDialog(context, index, admin.adminName),
                    child: const Text("Select Roles"),
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
