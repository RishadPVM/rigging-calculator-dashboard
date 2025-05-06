import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/widget/c_search_bar.dart';
import 'package:leo_rigging_dashboard/widget/header.dart';

import '../nav/controller/navcontroller.dart';
import 'crane_details.dart';

class CraneListPage extends StatelessWidget {
  const CraneListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Navcontroller controller = Get.find<Navcontroller>();
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          spacing: 16,
          children: [
            const Header(title: "Cranes"),
            
             Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TabBar(
                      dividerHeight: 48,
                      dividerColor: AppColors.cGrey100,
                      isScrollable: true,
                      tabAlignment: TabAlignment.center,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: const Color(0xFF9B1C1C),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      tabs: const [
                        Tab(
                          child:  Text("Cranes"),
                        ),
                        Tab(
                          child: Text("Brand"),
                        ),
                       
                      ],
                    ),
                    CseaechBar(hintText: "Search"),
                    
                  ],
                ),

            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(children: [
               GridView.builder(
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
               ),
              GridView.builder(
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 6,
                   crossAxisSpacing: 20,
                   mainAxisSpacing: 16,
                   mainAxisExtent: 200,
                 ),
                 itemCount: 20,
                itemBuilder: (context, index) => Container(
                 decoration: BoxDecoration(
                   border: Border.all(color: const Color.fromARGB(255, 213, 213, 213)),
                   borderRadius: BorderRadius.circular(4),
                   image: const DecorationImage(
                     image:AssetImage("assets/images/brandlogo.png")
                   ),
                 ),
                ),)
                        
              ]),
            )
                
      
           
          ],
        ),
      ),
    );
  }
}
