import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/view/cranes/Widget/brand_category_dialoge.dart';

import '../controller/crane_controller.dart';

class CategoryGridView extends StatelessWidget {
  const CategoryGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final CraneController controller = Get.find<CraneController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.filteredCategory.isEmpty) {
        return const Center(child: Text('No categories found'));
      }

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 20,
          mainAxisSpacing: 16,
          mainAxisExtent: 200,
        ),
        itemCount: controller.filteredCategory.length,
        itemBuilder: (context, index) {
          final category = controller.filteredCategory[index];
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (context) => BrandCategoryDialoge(
                      iscreate: false,
                      isbrand: false,
                      image: category.categoryImageUrl,
                      name: category.categoryName,
                      id: category.id,
                    ),
              );
            },
            child: Container(
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
                    category.categoryImageUrl,
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.categoryName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 4),
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
            ),
          );
        },
      );
    });
  }
}
