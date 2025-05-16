import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/crane_controller.dart';

class BrandGridview extends StatelessWidget {
  const BrandGridview({super.key});

  @override
  Widget build(BuildContext context) {
    final CraneController controller = Get.find<CraneController>();
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.filteredBrand.isEmpty) {
        return const Center(
          child: Text('No Brand Found'),
        );
      }

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 20,
          mainAxisSpacing: 16,
          mainAxisExtent: 200,
        ),
        itemCount: controller.filteredBrand.length,
        itemBuilder: (context, index) {
          final brand = controller.filteredBrand[index];
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 213, 213, 213),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Image.network(
                    brand.imageUrl,
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                  ),
                Text(
                  brand.brandName,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 8),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    activeColor: Colors.green,
                      value: controller.isSwitched.value,
                    onChanged: (value) {
                        controller.toggleSwitch(value);
                      },
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
