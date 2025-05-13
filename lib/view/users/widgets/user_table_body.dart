import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leo_rigging_dashboard/model/user_model.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/utils/country_decode.dart';
import 'package:leo_rigging_dashboard/utils/enum.dart';

class UserTable extends StatelessWidget {
  final List<UserModel> users;
  final UserRole userRole;

  const UserTable({
    super.key,
    required this.users,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {

     if (users.isEmpty) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No ${userRole == UserRole.craneSeller ? 'Crane Seller' : userRole == UserRole.sponsors ? "Sponsors" : "Users"} available',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
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
                        if (userRole.name == UserRole.sponsors.name)
                          _buildCell(context, user.sponsorAds.length.toString()),
                        if (userRole.name == UserRole.sponsors.name)
                          _buildCell(context, 'N/A'),
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