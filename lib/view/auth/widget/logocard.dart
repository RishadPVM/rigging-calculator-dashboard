
import 'package:flutter/material.dart';

import '../../../utils/appcolors.dart';

class LogoCard extends StatelessWidget {
  const LogoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: AppColors.cPrimary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icon/LEO_logo.png',
            fit: BoxFit.cover,
            height: 100,
          ),
          SizedBox(height: 8),
          Text(
            "LIFTING ENGINEERS ORGANIZATION",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.cWhite,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Expert Engineering Confers Safe Results",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.cWhite,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
