import 'package:flutter/material.dart';
import 'package:leo_rigging_dashboard/utils/themes.dart';

import 'view/auth/login/login.dart';

void main() { 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CAppTheme.lightTheme,
      home: LoginPage(),
    );
  }
}
