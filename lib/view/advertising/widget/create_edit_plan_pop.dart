import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/model/ad_plan_model.dart';
import 'package:leo_rigging_dashboard/view/advertising/controller/ad_controller.dart';
import 'package:leo_rigging_dashboard/widget/c_textfeild.dart';

Future<dynamic> addEditPlanPop(
  BuildContext context, {
  bool isEditMode = false,
  AdsPlanModel? plan,
}) {
  AdController controller = Get.find<AdController>();

  if (isEditMode) {
    controller.planNameController.text = plan?.title ?? '';
    controller.planBadgeController.text = plan?.badge ?? '';
    controller.planMinViewController.text = plan?.minViews.toString() ?? '';
    controller.planMaxViewController.text = plan?.maxViews.toString() ?? '';
    controller.planDescriptionController.text = plan?.description ?? '';
    controller.planPriceController.text = plan?.originalPrice.toString() ?? '';
    controller.planOfferPriceController.text = plan?.offerPrice.toString() ?? '';
  } else {
    controller.planNameController.clear();
    controller.planBadgeController.clear();
    controller.planMinViewController.clear();
    controller.planMaxViewController.clear();
    controller.planDescriptionController.clear();
    controller.planPriceController.clear();
    controller.planOfferPriceController.clear();
  }

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 450,
            maxWidth: 450,
            minHeight: 200,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Obx(
              () => Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isEditMode ? "Edit Plan" : "Create New Plan",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          splashRadius: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CTextField(
                            labelText: 'Plan Name',
                            controller: controller.planNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: CTextField(
                            labelText: 'Plan Badge',
                            controller: controller.planBadgeController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CTextField(
                            labelText: 'Min Views',
                            controller: controller.planMinViewController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Min views are required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: CTextField(
                            labelText: 'Max Views',
                            controller: controller.planMaxViewController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Max views are required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CTextField(
                            labelText: 'Price',
                            controller: controller.planPriceController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Price is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: CTextField(
                            labelText: 'Offer Price',
                            controller: controller.planOfferPriceController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CTextField(
                      labelText: 'Description',
                      controller: controller.planDescriptionController,
                      
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.planNameController.clear();
                              controller.planBadgeController.clear();
                              controller.planMinViewController.clear();
                              controller.planMaxViewController.clear();
                              controller.planDescriptionController.clear();
                              controller.planPriceController.clear();
                              controller.planOfferPriceController.clear();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: const Text(
                              "Clear",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 69, 69, 69),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 3,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (controller.formKey.currentState?.validate() ?? false) {
                                if (isEditMode) {
                                  await controller.updateAdPlan(planId: plan?.id ?? '');
                                } else {
                                  await controller.createAdPlan();
                                }
                                Get.close(1);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            child: controller.isCreateUpdating.value
                                ? const Center(child: SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)))
                                : Text(
                                    isEditMode ? "Update Plan" : "Create Plan",
                                    style: const TextStyle(fontSize: 14, color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
