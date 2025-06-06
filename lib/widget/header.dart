import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/view/auth/controller/auth_controller.dart';
import 'package:leo_rigging_dashboard/view/auth/login/login.dart';

import '../utils/appcolors.dart';
import '../utils/assets.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Row(
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.headlineLarge),
        ),
        Row(
          spacing: 16,
          children: [
            SizedBox(
              height: 48,
              width: 48,
              child: IconButton.filled(
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  backgroundColor: AppColors.cGrey100,
                ),
                icon: SvgPicture.asset(Assets.notificationIcon),
                onPressed: () {
                    // userController.fetchUsers();
                },
              ),
            ),
            Container(
              height: 48,
              width: 100,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.cGrey100,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      Assets.demoProfileImg,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  PopupMenuButton(
                    color: AppColors.cWhite,

                    icon: SvgPicture.asset(Assets.arrowDownIcon),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 1,
                          child: Text(
                            "Logout",
                            style: TextStyle(color: AppColors.cPrimary),
                          ),
                          onTap: ()async {
                           await authController.logout();
                           Get.offAll(()=> LoginPage());
                          },
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
