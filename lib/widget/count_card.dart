
import 'package:flutter/material.dart';

import '../utils/appcolors.dart';

class CountCard extends StatelessWidget {
  final String title;
  final String count;
  const CountCard({super.key, required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 88,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.cGrey100,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyLarge),

              Text(count, style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ),
      ),
    );
  }
}
