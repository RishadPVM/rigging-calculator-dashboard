import 'package:flutter/material.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/widget/c_search_bar.dart';

import '../../widget/header.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                            Text("Advertisers"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CseaechBar(hintText: "Search..."),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildTable(context, 'Users', false),
                    _buildTable(context, 'Sponsors', true),
                    _buildTable(context, 'Advertisers', false),
                  ],
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
    String tabType,
    bool isSponsors,
  ) {
    final List<Map<String, String>> companies = List.generate(20, (index) {
      return {
        'sn': (index + 1).toString(),
        'company': '$tabType Company $index',
        'email': '$tabType$index@example.com',
        'country': 'Country $index',
        'lastActive': '14-04-2025',
        'createdDate': '01-03-2025',
        'ads': isSponsors ? '4' : '',
        'price': isSponsors ? '500' : '',
      };
    });

    final List<String> headers = [
      'SN',
      'Company info',
      'E-mail',
      'Country',
      ...isSponsors ? ['Ads', 'Price'] : [],
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
              columnWidths:
                  isSponsors
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
                  children:
                      headers
                          .map(
                            (header) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Text(
                                header,
                                style: Theme.of(context).textTheme.bodyLarge
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
              final data = companies[index];
              Color rowColor =
                  index.isEven ? AppColors.cWhite : AppColors.cGrey100;

              return Container(
                color: rowColor,
                child: Table(
                  columnWidths:
                      isSponsors
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
                        _buildCell(context, data['sn']!),
                        _buildCompanyInfoCell(data['company']!),
                        _buildCell(context, data['email']!),
                        _buildCell(context, data['country']!),
                        if (isSponsors) _buildCell(context, data['ads']!),
                        if (isSponsors) _buildCell(context, data['price']!),
                        _buildCell(context, data['lastActive']!),
                        _buildCell(context, data['createdDate']!),
                      ],
                    ),
                  ],
                ),
              );
            }, childCount: companies.length),
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

  static Widget _buildCompanyInfoCell(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.business, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: AppColors.cBlack),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
