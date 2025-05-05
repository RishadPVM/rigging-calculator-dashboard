import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/view/ad/ad_details.dart';
import 'package:leo_rigging_dashboard/widget/header.dart';

import '../../widget/c_search_bar.dart';
import '../nav/controller/navcontroller.dart';

class AdsPage extends StatelessWidget {
  const AdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Navcontroller controller = Get.find<Navcontroller>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          spacing: 16,
          children: [
            Header(title: "Advertisements"),
            Align(
              alignment: Alignment.centerRight,
              child: CseaechBar(hintText: "Search"),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 320,
                ),
                itemCount: 20,
                itemBuilder:
                    (context, index) => GestureDetector(
                      onTap: () {
                        controller.overlappingNav(AdDetails());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.cGrey100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: 1.9 / 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrm8FbBCkf8oElWjAdJDoyRZ8IqL8dCTNvBw&s",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "There are many variations of passages of Lorem Ipsum available,",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.more_vert_outlined),
                                ],
                              ),

                              Text(
                                "https:www.figma.comdesignU9Q0mJy2yuyCVRWop..",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "700 Website views",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
