import 'package:flutter/material.dart';

import '../../../model/dashboard_data_model.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/assets.dart';

class DashboardCountBox extends StatelessWidget {
  final List<DataCount> dataCount;
  const DashboardCountBox({super.key, required this.dataCount});

  

  @override
  Widget build(BuildContext context) {
    
    return Row(
      children: List.generate(
        dataCount.length,
        (index) => Flexible(
          child: Container(
            margin: EdgeInsets.only(right: index < 3 ? 16.0 : 0),
            padding: const EdgeInsets.only(top: 8),
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 208, 208, 208),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    dataCount[index].name,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: AppColors.cGrey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    dataCount[index].value.toString(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                const Spacer(),
                Image.asset(Assets.graph2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}