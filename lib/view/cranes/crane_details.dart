import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/view/cranes/controller/crane_controller.dart';
import 'package:leo_rigging_dashboard/widget/header.dart';

import '../../model/crane_modal.dart';
import '../nav/controller/navcontroller.dart';

class CraneDetails extends StatelessWidget {
  const CraneDetails({super.key, required this.crane});
  final CraneModal crane;

  @override
  Widget build(BuildContext context) {
    final List specifications = crane.specifications;

    final Navcontroller controller = Get.find<Navcontroller>();
    final CraneController craneController = Get.find<CraneController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => controller.overlappingNavClose(),
                      icon: Icon(Icons.arrow_back_ios_new),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: Header(title: "Crane Details")),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 24,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jhonson",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "jhonson@gmail.com",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.cPrimary),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                image: DecorationImage(
                                  image: NetworkImage(crane.imageUrl.first),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row(
                            //   children: [
                            //     CountCard(count: "200", title: "Total Views"),
                            //     SizedBox(width: 16),
                            //     CountCard(count: "100", title: "Total Enquiries"),
                            //   ],
                            // ),
                            // SizedBox(height: 16),
                            Text(
                              crane.model,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              crane.category.categoryName,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Price - ${crane.price ?? "not "}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "Service type - ${crane.serviceType}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: Text(
                                    'Specifications',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                // Row(
                                //   children: [
                                //     Text(
                                //       'Metric',
                                //       style:
                                //           Theme.of(context).textTheme.bodyLarge,
                                //     ),
                                //     Radio<String>(
                                //       value: 'metric',
                                //       groupValue: 'metric',
                                //       onChanged: (value) {},
                                //     ),
                                //     const SizedBox(width: 8),
                                //     Text(
                                //       'Imperial',
                                //       style:
                                //           Theme.of(context).textTheme.bodyLarge,
                                //     ),
                                //     Radio(
                                //       value: 'Imperial',
                                //       groupValue: 'Imperial',
                                //       onChanged: (value) {},
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Year - ${crane.manufacturerYear}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              "Capacity - ${crane.maxLiftingCapacity}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              "Hour - ${crane.hour}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              "Jib - ${crane.jib}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              "Counterweight - ${crane.counterWeight}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              "slcounterweight - ${crane.slCounterWeight}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              "Liftingcapacity - ${crane.liftingCapacity}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              "Maxliftingcapacity - ${crane.maxLiftingCapacity}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              "Main boom - ${crane.mainBoom}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Column(
                              children: List.generate(specifications.length, (
                                index,
                              ) {
                                final spec = specifications[index];
                                final key = spec.keys.first;
                                final value = spec[key];
                                return  Text(
                              "$key - $value",
                              style: Theme.of(context).textTheme.bodyMedium,
                            );
                                
                              }),
                            ),
                            SizedBox(height: 24),
                            Text(
                              crane.description ??
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Obx(() {
                if (craneController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final enuiry = craneController.craneEnquiry;

                if (enuiry.isEmpty) {
                  return const Center(child: Text("No cranes available."));
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 320,
                  ),
                  itemCount: enuiry.length,
                  itemBuilder:
                      (context, index) => Container(
                        decoration: BoxDecoration(
                          color: AppColors.cGrey100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            spacing: 4,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                enuiry[index].name,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Row(
                                spacing: 4,
                                children: [
                                  Icon(Icons.email_outlined),
                                  Text(
                                    enuiry[index].email,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 4,
                                children: [
                                  Icon(Icons.phone_outlined),
                                  Text(
                                    enuiry[index].phoneNumber,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                enuiry[index].message,
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
