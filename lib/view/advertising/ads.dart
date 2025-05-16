import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/view/advertising/ad_details.dart';
import 'package:leo_rigging_dashboard/widget/header.dart';

import '../../widget/c_search_bar.dart';
import '../nav/controller/navcontroller.dart';
import 'controller/ad_controller.dart';

class AdsPage extends StatelessWidget {
  const AdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AdController adController = Get.put(AdController());
    final Navcontroller navController = Get.find<Navcontroller>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          spacing: 20,
          children: [
            const Header(title: "Advertisements"),
            const Align(
              alignment: Alignment.centerRight,
              child: CsearchBar(hintText: "Search"),
            ),
           
            Expanded(
              child: Obx(
                () {
                  if (adController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (adController.ads.isEmpty) {
                    return const Center(
                      child: Text(
                        "No advertisements available.",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  }

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 320,
                    ),
                    itemCount: adController.ads.length,
                    itemBuilder: (context, index) {
                      final ad = adController.ads[index];
                      return GestureDetector(
                        onTap: () {
                          navController.overlappingNav(AdDetails(ad: ad));
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
                                      ad.image,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        color: Colors.grey,
                                        child: const Icon(
                                          Icons.broken_image,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        ad.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.more_vert_outlined),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  ad.webUrl,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${ad.readUsers.length} views • ${ad.clickUsers.length} website views",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
