import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/widget/c_textfeild.dart';

import '../controller/crane_controller.dart';

class BrandCategoryDialoge extends StatelessWidget {
  final String? image;
  final String? name;
  final String? id;
  final bool iscreate;
  final bool isbrand;

  const BrandCategoryDialoge({
    super.key,
    this.image,
    this.name,
    this.id,
    required this.iscreate,
    required this.isbrand, 
  });

  @override
  Widget build(BuildContext context) {
    final CraneController controller = Get.find<CraneController>();
    if (!iscreate) {
      controller.nameController.text = name!;
    }
    final double requiredAspectRatio = isbrand ? 2.35 / 1 : 1 / 1;

    return AlertDialog(
      backgroundColor: AppColors.cWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isbrand
                ? iscreate
                    ? "Create Brand"
                    : "Edit Brand"
                : iscreate
                ? "Create Category"
                : "Edit Category",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: SizedBox(
        width: 280,
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => controller.pickAndValidateImage(isbrand),
                child: Container(
                  width: double.maxFinite,
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.cGrey300,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color:
                          controller.isAspectRatioIssue.value
                              ? AppColors.cPrimary
                              : const Color.fromARGB(255, 213, 213, 213),
                    ),
                  ),
                  child: Obx(
                    () =>
                        controller.selectedImage.value != null
                            ? AspectRatio(
                              aspectRatio: requiredAspectRatio,
                              child: 
                              Image.file(
                                File(controller.selectedImage.value!.path),
                                fit: BoxFit.contain,
                              ),
                            )
                            : iscreate
                            ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.add_a_photo_outlined),
                                const SizedBox(height: 8),
                                Text(
                                  "Upload Image (Aspect Ratio ${isbrand ? '2.35:1 ' : '1:1'})",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            )
                            : image != null
                            ? AspectRatio(
                              aspectRatio: requiredAspectRatio,
                              child: Image.network(image!, fit: BoxFit.contain),
                            )
                            : const Center(
                              child: Icon(Icons.image_not_supported),
                            ),
                  ),
                ),
              ),
              if (controller.isAspectRatioIssue.value)
                Text(
                  "upload an image with ${isbrand ? '2.35:1 ' : '1:1'} aspect ratio",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              const SizedBox(height: 8),
              CTextField(
                labelText: isbrand ? "Brand name" : "Category name",
                suffixIcon: Icon( Icons.email_outlined),
                controller: controller.nameController,
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed:
              () {
               iscreate?
               controller.handleSubmit(context, iscreate, isbrand, image):
               controller.handleUpdate(context, id!, iscreate, isbrand);
              } ,
          child: Text(iscreate ? "Create" : "Update"),
        ),
      ],
    );
  }
}
