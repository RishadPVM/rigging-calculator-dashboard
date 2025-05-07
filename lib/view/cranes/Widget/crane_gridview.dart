import 'package:flutter/material.dart';

import '../../../utils/appcolors.dart';
import '../../nav/controller/navcontroller.dart';
import '../crane_details.dart';

class CraneGridview extends StatelessWidget {
  const CraneGridview({
    super.key,
    required this.controller,
  });

  final Navcontroller controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 20,
            mainAxisSpacing: 16,
            mainAxisExtent: 350,
          ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            controller.overlappingNav(CraneDetails());
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cGrey100,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 196,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrm8FbBCkf8oElWjAdJDoyRZ8IqL8dCTNvBw&s",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Crane Name",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "For Sale",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: AppColors.cPrimary),
                ),
                Text(
                  "Year - 2010",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "Capacity - 45 tonne",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "Main boom - 40 tonne",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

