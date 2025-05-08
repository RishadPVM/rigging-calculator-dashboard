import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leo_rigging_dashboard/utils/enum.dart';

import '../../core/country_decode.dart';
import '../../model/user_model.dart';
import '../../utils/appcolors.dart';
import '../../widget/c_search_bar.dart';
import '../../widget/header.dart';
import 'controller/user_controller.dart'; // For formatting dates

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize UserController
    final UserController userController = Get.put(UserController());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(title: "Users"),
              const SizedBox(height: 20),
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
                        child: Row(
                          children: [
                            Icon(Icons.groups_2, size: 18),
                            SizedBox(width: 6),
                            Text("Users"),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: [
                            Icon(Icons.business_center, size: 18),
                            SizedBox(width: 6),
                            Text("Sponsors"),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: [
                            Icon(Icons.campaign, size: 18),
                            SizedBox(width: 6),
                            Text("Crane Sellers"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CsearchBar(
                    hintText: "Search...",
                    onChanged: (value) {
                      userController.searchUsers(value); // Trigger search
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              Expanded(
                child: Obx(
                  () => userController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : TabBarView(
                          children: [
                            _buildTable(
                              context,
                            
                              userController.filteredUsers,
                              UserRole.allUsers,
                            ),
                            _buildTable(
                              context,
                           
                              userController.filteredUsers.where((user) => user.sponsorAds.isNotEmpty).toList(), 
                              UserRole.sponsors,
                            ),
                            _buildTable(
                              context,
                            
                              userController.filteredUsers.where((user) => user.cranes.isNotEmpty).toList(),
                              UserRole.advertisers,
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildTable(
    BuildContext context,
    
    List<UserModel> users,
    UserRole userRole,
  ) {
    // Filter users based on tabType if needed (e.g., Sponsors might have isPaymentStatus == true)
   
   
    final List<String> headers = [
      'SN (${users.length})',
      'Company info',
      'E-mail',
      'Country',
      if (userRole.name == UserRole.sponsors.name) ...['Ads', 'Price'],
      'Last active',
      'Created date',
    ];

    return SingleChildScrollView(
      child: CustomScrollView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Table(
              columnWidths: userRole.name == UserRole.sponsors.name
                  ? const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(1.5),
                      4: FlexColumnWidth(1),
                      5: FlexColumnWidth(1),
                      6: FlexColumnWidth(1.5),
                      7: FlexColumnWidth(1.5),
                    }
                  : const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(1.5),
                      4: FlexColumnWidth(1.5),
                      5: FlexColumnWidth(1.5),
                    },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey[300]),
                  children: headers
                      .map(
                        (header) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Text(
                            header,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final user = users[index];
              Color rowColor =
                  index.isEven ? AppColors.cWhite : AppColors.cGrey100;

              // Format dates
              final dateFormatter = DateFormat('dd-MM-yyyy');
              final lastActive = user.lastActiveAt != null
                  ? dateFormatter.format(user.lastActiveAt!)
                  : 'N/A';
              final createdDate = dateFormatter.format(user.createdAt);

              return Container(
                color: rowColor,
                child: Table(
                  columnWidths: userRole.name == UserRole.sponsors.name
                      ? const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(1.5),
                          4: FlexColumnWidth(1),
                          5: FlexColumnWidth(1),
                          6: FlexColumnWidth(1.5),
                          7: FlexColumnWidth(1.5),
                        }
                      : const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(1.5),
                          4: FlexColumnWidth(1.5),
                          5: FlexColumnWidth(1.5),
                        },
                  children: [
                    TableRow(
                      children: [
                        _buildCell(context, (index + 1).toString()),
                        _buildCompanyInfoCell(
                          user.companyName ?? 'N/A',
                          user.companyLogo,
                        ),
                        _buildCell(context, user.email),
                        _buildCell(context, countryMap[user.country] ?? 'N/A'),
                        if (userRole.name == UserRole.sponsors.name) _buildCell(context, user.sponsorAds.length.toString()),
                        if (userRole.name == UserRole.sponsors.name) _buildCell(context, 'N/A'),
                        _buildCell(context, lastActive),
                        _buildCell(context, createdDate),
                      ],
                    ),
                  ],
                ),
              );
            }, childCount: users.length),
          ),
        ],
      ),
    );
  }

  static Widget _buildCell(BuildContext context, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
    );
  }

  static Widget _buildCompanyInfoCell(String companyName, String? companyLogo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: companyLogo != null
                  ? DecorationImage(
                      image: NetworkImage(companyLogo),
                      fit: BoxFit.cover,
                    )
                  : null,
              color: companyLogo == null ? Colors.grey : null,
            ),
            child: companyLogo == null
                ? const Icon(Icons.business, size: 16, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              companyName,
              style: TextStyle(color: AppColors.cBlack),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}