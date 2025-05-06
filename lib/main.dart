import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:leo_rigging_dashboard/utils/themes.dart';

import 'view/auth/login/login.dart';

Future<void> main()async { 
  await dotenv.load(fileName: '.env');
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
