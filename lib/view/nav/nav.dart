import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/utils/image_icon_path.dart';
import 'package:leo_rigging_dashboard/view/nav/controller/navcontroller.dart';

class NavPage extends StatelessWidget {
  const NavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Navcontroller controller = Get.put(Navcontroller());
    return Material(
      child: Row(
        children: [
          Container(
            width: 300,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: AppColors.cGrey300, width: 2),
              ),
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Image.asset(ImageAndIconPath.logoWithImg),
                      const SizedBox(height: 20),
                      SidebarTile(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(() => Expanded(flex: 4, child: controller.selectedBody.value)),
        ],
      ),
    );
  }
}

//Listtile section

class SidebarTile extends StatelessWidget {
  const SidebarTile({super.key});

  @override
  Widget build(BuildContext context) {
    final Navcontroller controller = Get.find<Navcontroller>();

    List<String> names = ["Users", "Cranes", "Advertisements", "Settings"];

    List<String> icons = [
      ImageAndIconPath.usersIcon,
      ImageAndIconPath.craneIcon,
      ImageAndIconPath.adIcon,
      ImageAndIconPath.settingsIcon,
    ];
    return ListView.builder(
      itemCount: controller.pages.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Obx(() {
          bool isSelected = controller.selectedIndex.value == index;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              splashColor: AppColors.cRed100,
              hoverColor: AppColors.cRed100,
              selectedTileColor: isSelected ? AppColors.cRed100 : null,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              selected: isSelected,
              leading: SvgPicture.asset(
                icons[index],
                height: 24,
                width: 24,
                colorFilter:
                    isSelected
                        ? const ColorFilter.mode(
                          AppColors.cPrimary,
                          BlendMode.srcIn,
                        )
                        : const ColorFilter.mode(
                          AppColors.cGrey,
                          BlendMode.srcIn,
                        ),
              ),
              title: Text(
                names[index],
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected ? AppColors.cPrimary : AppColors.cGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                controller.onItemTapped(index);
              },
            ),
          );
        });
      },
    );
  }
}
