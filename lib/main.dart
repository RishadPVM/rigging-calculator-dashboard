import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:leo_rigging_dashboard/core/LoginResponce/global_user.dart';
import 'package:leo_rigging_dashboard/core/bindings/bindings.dart';
import 'package:leo_rigging_dashboard/model/auth_model.dart';
import 'package:leo_rigging_dashboard/utils/themes.dart';
import 'package:leo_rigging_dashboard/view/nav/nav.dart';
import 'package:shared_preferences/shared_preferences.dart'; 

import 'view/auth/login/login.dart';

Future<void> main()async { 
  await dotenv.load(fileName: '.env');
  // Check login status
  final prefs = await SharedPreferences.getInstance();
  final String isLoggenResponce = prefs.getString('adminData') ?? '';

  runApp(MyApp(isLoggedIn: isLoggenResponce.isNotEmpty)); 
  
  if (isLoggenResponce.isNotEmpty) {
     Map<String, dynamic> decodeduserdata = json.decode(isLoggenResponce);
        LoginResponse user =  LoginResponse.fromJson(decodeduserdata,);
        GlobalUser().setUser(user);
  } 
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitalBindings(),
      title: 'LEO Dashboard',
      theme: CAppTheme.lightTheme,
      home:isLoggedIn ?  NavPage() : LoginPage(),
    );
  }
}
