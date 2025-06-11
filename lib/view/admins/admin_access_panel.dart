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
    "brandEdit": "Brand Edit",
    "categoryView": "Category View",
    "categoryEdit": "Category Edit",
    "adsView": "Ads View",
  };

  final Map<String, bool> roleStates = {};
  Map<String, bool> originalStates = {};

  final AdminController adminController = Get.find<AdminController>();

  @override
  void initState() {
    super.initState();
    final roles = widget.admin.roles;

    roleStates.addAll({
      "userView": roles?.userView ?? false,
      "sponsorView": roles?.sponsorView ?? false,
      "craneSellerView": roles?.craneSellerView ?? false,
      "craneView": roles?.craneView ?? false,
      "brandView": roles?.brandView ?? false,
      "brandEdit": roles?.brandEdit ?? false,
      "categoryView": roles?.categoryView ?? false,
      "categoryEdit": roles?.categoryEdit ?? false,
      "adsView": roles?.adsView ?? false,
    });

    originalStates = Map.from(roleStates);
  }

  bool get _hasUnsavedChanges {
    return roleStates.entries.any((entry) =>
        originalStates[entry.key] != entry.value);
  }

  bool get _areAllSelected => roleStates.values.every((e) => e);

  void _toggleAllRoles(bool value) {
    setState(() {
      for (var key in roleStates.keys) {
        roleStates[key] = value;
      }
    });
  }

  void saveRoles() {
    final updatedRoles = Roles(
      adminId: widget.admin.id,
      userView: roleStates["userView"] ?? false,
      sponsorView: roleStates["sponsorView"] ?? false,
      craneSellerView: roleStates["craneSellerView"] ?? false,
      craneView: roleStates["craneView"] ?? false,
      brandView: roleStates["brandView"] ?? false,
      brandEdit: roleStates["brandEdit"] ?? false,
      categoryView: roleStates["categoryView"] ?? false,
      categoryEdit: roleStates["categoryEdit"] ?? false,
      adsView: roleStates["adsView"] ?? false,
    );

    adminController.updateAdminRoles(widget.admin.id, updatedRoles).then((_) {
      originalStates = Map.from(roleStates);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Roles updated successfully")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Navcontroller navController = Get.find<Navcontroller>();

    return Scaffold(
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton.icon(
                    icon: Icon(_areAllSelected ? Icons.remove_done : Icons.done_all),
                    label: Text(_areAllSelected ? "Deselect All" : "Select All"),
                    onPressed: () => _toggleAllRoles(!_areAllSelected),
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
                  final isSelected = roleStates[key] ?? false;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: CheckboxListTile(
                        value: isSelected,
                        title: Text(
                          label,
                          style: const TextStyle(color: Colors.black),
                        ),
                        onChanged: (bool? value) {
                          setState(() {
                            roleStates[key] = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Obx(() {
                final isSaving = adminController.isLoading.value;
                if (!_hasUnsavedChanges) return const SizedBox.shrink();

                return Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 140,
                    height: 38,
                    child: ElevatedButton(
                      onPressed: isSaving ? null : saveRoles,
                      child: isSaving
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                            "Save Changes",
                            style: TextStyle(fontSize: 12),
                          ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
