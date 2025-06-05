import 'package:flutter/material.dart';
import 'package:leo_rigging_dashboard/view/admins/widgets/admin_list.dart';
import 'package:leo_rigging_dashboard/widget/header.dart';

class AdminsPage extends StatelessWidget {
  const AdminsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: "Admins"),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton.icon(
               onPressed: (){},
               icon: Icon(Icons.add),
               label: Text("Create "),
              ),
            ),
            SizedBox(height: 20),
            Expanded(child: AdminGridview()),
          ],
        ),
      ),
    );
  }
}
