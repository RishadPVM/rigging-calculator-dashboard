import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/utils/assets.dart';
import 'package:leo_rigging_dashboard/widget/header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: "Settings"),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(onPressed: (){}, child: Text("Create Subscription"))),
            SizedBox(height: 20),
            Row(
              spacing: 16,
              children: [
                SubscrptionSeeingCard(
                  imagePath: Assets.adIcon,
                  title: "Create Ads Price",
                  price: "500",
                ),
                SubscrptionSeeingCard(
                  imagePath: Assets.craneIcon,
                  title: "Create Crane Price",
                  price: "100",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SubscrptionSeeingCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  const SubscrptionSeeingCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
        },
        child: Container(
          height: 260,
          width: 200,
          decoration: BoxDecoration(
            color: AppColors.cGrey100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.cRed100),
                child: Center(
                  child: SvgPicture.asset(
                    imagePath,
                    colorFilter: ColorFilter.mode(
                      AppColors.cPrimary,
                      BlendMode.srcIn,
                    ),
        
                    fit: BoxFit.cover,
                    height: 48,
                    width: 48,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: 4),
                    Text(
                      "Rs/- $price",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
