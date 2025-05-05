import 'package:flutter/material.dart';

import '../../widget/header.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            Header(title: "Dashboard"),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Center(
                  child: Text("Dashboard Content Here"),
                ),
              ),
            ),
          ],                                      
        ),
      )
    );
  }
}