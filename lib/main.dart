import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_nieve/components/auth/login_register_view.dart';
import 'package:test_nieve/utils/local_storage.dart';
import 'package:test_nieve/widget/text_label.dart';
import 'package:firebase_core/firebase_core.dart';

import 'utils/utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalStorage.prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'NIEVE TEST',
        theme: ThemeData(
          fontFamily: 'InterRegular',
        ),
        locale: Get.deviceLocale,
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loadingNextRoute();
    super.initState();
  }

  void loadingNextRoute() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAll(LoginRegister());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Utility.baseColor2,
        body: Center(
          child: TextLabel(text: "Test Nieve", weigh: FontWeight.bold),
        ));
  }
}
