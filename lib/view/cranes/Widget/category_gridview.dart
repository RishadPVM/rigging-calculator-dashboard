import 'package:flutter/material.dart';

class CategoryGridView extends StatelessWidget {
  const CategoryGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 20,
            mainAxisSpacing: 16,
            mainAxisExtent: 200,
          ),
      itemCount: 20,
      itemBuilder:
          (context, index) => Container(
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
                Image.asset("assets/images/all_terrain.png"),
                Text(
                  "All Terrain",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                 SizedBox(height: 4),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    activeColor: Colors.green,
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
