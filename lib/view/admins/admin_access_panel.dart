import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/widget/header.dart';

import '../nav/controller/navcontroller.dart';

class AdminAccessPanel extends StatefulWidget {
  const AdminAccessPanel({super.key});

  @override
  State<AdminAccessPanel> createState() => _AdminAccessPanelState();
}

class _AdminAccessPanelState extends State<AdminAccessPanel> {
  final List<String> roleOptions = [
    "Admin",
    "Editor",
    "Viewer",
    "Operator",
    "Manager",
    "Supervisor",
    "Technician",
    "Guest",
  ];

  final Set<String> selectedRoles = <String>{};

  @override
  Widget build(BuildContext context) {
    final Navcontroller navController = Get.find<Navcontroller>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                  IconButton(
                      onPressed: () {
                        navController.overlappingNavClose();
                      },
                      icon: Icon(Icons.arrow_back_ios_new),
                    ),
                    const SizedBox(width: 16),
                Expanded(child: Header(title: "Admin access panel")),
              ],
            ),
         
            Expanded(
              child: GridView.builder(
               padding: const EdgeInsets.only(top: 24.0),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 16,
                  childAspectRatio: 4,
                ),
                itemCount: roleOptions.length,
                itemBuilder: (context, index) {
                  final role = roleOptions[index];
                  final isSelected = selectedRoles.contains(role);
        
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: CheckboxListTile(
                        value: isSelected,
                        title: Text(
                          role,
                          style: const TextStyle(color: Colors.black),
                        ),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedRoles.add(role);
                            } else {
                              selectedRoles.remove(role);
                            }
                          });
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
            ),
          ],
        ),
      ),
    );
  }
}
