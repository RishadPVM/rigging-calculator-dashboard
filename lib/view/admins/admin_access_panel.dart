import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/widget/header.dart';

import '../../model/admin_modal.dart';
import '../nav/controller/navcontroller.dart';
import 'controller/admin_controller.dart';

class AdminAccessPanel extends StatefulWidget {
  final AdminModel admin;

  const AdminAccessPanel({super.key, required this.admin});

  @override
  State<AdminAccessPanel> createState() => _AdminAccessPanelState();
}

class _AdminAccessPanelState extends State<AdminAccessPanel> {
  final Map<String, String> roleMapping = {
    "userView": "User View",
    "sponsorView": "Sponsor View",
    "craneSellerView": "Crane Seller View",
    "craneView": "Crane View",
    "brandView": "Brand View",
    "brandCreate": "Brand Create",
    "brandEdit": "Brand Edit",
    "categoryView": "Category View",
    "categoryCreate": "Category Create",
    "categoryEdit": "Category Edit",
    "adsView": "Ads View",
    "adsBlockOption": "Ads Block Option",
    "adsVerifiyOption": "Ads Verify Option",
    "adsPlanView": "Ads Plan View",
    "adsPlanCreate": "Ads Plan Create",
    "adsPlanEdit": "Ads Plan Edit",
  };

  final roleStates = <String, RxBool>{}.obs;
  final originalStates = <String, bool>{}.obs;

  final RxBool isBlocked = false.obs;
  final RxBool isSuperAdmin = false.obs;

  final AdminController adminController = Get.find<AdminController>();

  @override
  void initState() {
    super.initState();
    final roles = widget.admin.roles;
    final map = {
      "userView": roles.userView,
      "sponsorView": roles.sponsorView,
      "craneSellerView": roles.craneSellerView,
      "craneView": roles.craneView,
      "brandView": roles.brandView,
      "brandCreate": roles.brandCreate,
      "brandEdit": roles.brandEdit,
      "categoryView": roles.categoryView,
      "categoryCreate": roles.categoryCreate,
      "categoryEdit": roles.categoryEdit,
      "adsView": roles.adsView,
      "adsBlockOption": roles.adsBlockOption,
      "adsVerifiyOption": roles.adsVerifiyOption,
      "adsPlanView": roles.adsPlanView,
      "adsPlanCreate": roles.adsPlanCreate,
      "adsPlanEdit": roles.adsPlanEdit,
    };

    map.forEach((key, value) {
      roleStates[key] = value.obs;
      originalStates[key] = value;
    });

    isBlocked.value = widget.admin.isBlocked;
    isSuperAdmin.value = widget.admin.isSuperAdmin;
  }

  bool get hasUnsavedChanges =>
      roleStates.entries.any((e) => originalStates[e.key] != e.value.value);

  bool get areAllSelected => roleStates.values.every((e) => e.value);

  void toggleAll(bool value) {
    for (var rx in roleStates.values) {
      rx.value = value;
    }
  }

  void saveRoles() {
    final updatedRoles = Roles(
      adminId: widget.admin.id,
      userView: roleStates["userView"]?.value ?? false,
      sponsorView: roleStates["sponsorView"]?.value ?? false,
      craneSellerView: roleStates["craneSellerView"]?.value ?? false,
      craneView: roleStates["craneView"]?.value ?? false,
      brandView: roleStates["brandView"]?.value ?? false,
      brandCreate: roleStates["brandCreate"]?.value ?? false,
      brandEdit: roleStates["brandEdit"]?.value ?? false,
      categoryView: roleStates["categoryView"]?.value ?? false,
      categoryCreate: roleStates["categoryCreate"]?.value ?? false,
      categoryEdit: roleStates["categoryEdit"]?.value ?? false,
      adsView: roleStates["adsView"]?.value ?? false,
      adsBlockOption: roleStates["adsBlockOption"]?.value ?? false,
      adsVerifiyOption: roleStates["adsVerifiyOption"]?.value ?? false,
      adsPlanView: roleStates["adsPlanView"]?.value ?? false,
      adsPlanCreate: roleStates["adsPlanCreate"]?.value ?? false,
      adsPlanEdit: roleStates["adsPlanEdit"]?.value ?? false,
    );

    adminController.updateAdminRoles(widget.admin.id, updatedRoles).then((_) {
      updatedRoles.toJson().forEach((key, value) {
        if (roleStates.containsKey(key)) {
          roleStates[key]!.value = value;
          originalStates[key] = value;
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Roles updated successfully")),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    final Navcontroller navController = Get.find<Navcontroller>();

    return Obx(
      () => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => navController.overlappingNavClose(),
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: Header(title: "Admin Access Panel")),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Permissions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      icon: Icon(
                        areAllSelected ? Icons.remove_done : Icons.done_all,
                      ),
                      label: Text(
                        areAllSelected ? "Deselect All" : "Select All",
                      ),
                      onPressed: () => toggleAll(!areAllSelected),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  padding: const EdgeInsets.only(top: 8.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 16,
                    childAspectRatio: 4,
                  ),
                  itemCount: roleMapping.length,
                  itemBuilder: (context, index) {
                    final key = roleMapping.keys.elementAt(index);
                    final label = roleMapping[key]!;
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: CheckboxListTile(
                          value: roleStates[key]?.value ?? false,
                          title: Text(
                            label,
                            style: const TextStyle(color: Colors.black),
                          ),
                          onChanged: (bool? value) {
                            roleStates[key]?.value = value ?? false;
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isBlocked.value ? Colors.green : Colors.red,
                      ),
                      icon: Icon(
                        isBlocked.value ? Icons.lock_open : Icons.lock,
                      ),
                      label: Text(
                        isBlocked.value ? "Unblock Admin" : "Block Admin",
                      ),
                      onPressed: () async {
                        await adminController.toggleBlockStatus(
                          widget.admin.id,
                          !isBlocked.value,
                        );
                        isBlocked.value = !isBlocked.value;
                      },
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSuperAdmin.value ? Colors.red : Colors.blueGrey,
                      ),
                      icon: Icon(
                        isSuperAdmin.value
                            ? Icons.arrow_drop_down
                            : Icons.upgrade,
                      ),
                      label: Text(
                        isSuperAdmin.value
                            ? "Demote to Admin"
                            : "Promote to Superadmin",
                      ),
                      onPressed: () async {
                        final newType =
                            isSuperAdmin.value ? "ADMIN" : "SUPPERADMIN";
                        await adminController.updateAdminType(
                          widget.admin.id,
                          newType,
                        );
                        isSuperAdmin.value = !isSuperAdmin.value;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (hasUnsavedChanges)
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 140,
                      height: 38,
                      child: ElevatedButton(
                        onPressed:
                            adminController.isLoading.value ? null : saveRoles,
                        child:
                            adminController.isLoading.value
                                ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                                : const Text(
                                  "Save Changes",
                                  style: TextStyle(fontSize: 12),
                                ),
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
