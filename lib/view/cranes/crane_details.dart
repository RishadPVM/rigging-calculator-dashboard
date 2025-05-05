import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/widget/header.dart';

import '../../widget/count_card.dart';
import '../nav/controller/navcontroller.dart';

class CraneDetails extends StatelessWidget {
  const CraneDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final Navcontroller controller = Get.find<Navcontroller>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.overlappingNavClose();
                      },
                      icon: Icon(Icons.arrow_back_ios_new),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: Header(title: "Crane Details")),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              image: const DecorationImage(
                                image: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrm8FbBCkf8oElWjAdJDoyRZ8IqL8dCTNvBw&s",
                                ),
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
                          Row(
                            children: [
                              CountCard(count: "200", title: "Total Views"),
                              SizedBox(width: 16),
                              CountCard(count: "100", title: "Total Enquiries"),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Terex Challenger 3160",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            "All Terrain Crane",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Text(
                                  'Specifications',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Metric',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Radio<String>(
                                    value: 'metric',
                                    groupValue: 'metric',
                                    onChanged: (value) {},
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Imperial',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Radio(
                                    value: 'Imperial',
                                    groupValue: 'Imperial',
                                    onChanged: (value) {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Year - 2010",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "Capacity - 45 tonne",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "Main boom - 40 tonne",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(height: 24),
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 320,
                ),
                itemCount: 20,
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
                              "Rishad",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Row(
                              spacing: 4,
                              children: [
                                Icon(Icons.email_outlined),
                                Text(
                                  "rishad@gmail.com",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Row(
                              spacing: 4,
                              children: [
                                Icon(Icons.phone_outlined),
                                Text(
                                  "9456851523",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an industry's standard dummy text ever since the 1500s, when an ",
                              style: Theme.of(context).textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
              ),
            ],
          ),
      
        ),
      ),
    );
  }
}
