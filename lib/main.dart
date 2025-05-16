import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:leo_rigging_dashboard/core/bindings/bindings.dart';
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
    return GetMaterialApp(
      initialBinding: InitalBindings(),
      title: 'LEO Dashboard',
      theme: CAppTheme.lightTheme,
      home: LoginPage(),
    );
  }
}
