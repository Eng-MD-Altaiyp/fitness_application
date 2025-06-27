import 'package:fitness_application/Databease/DataBase_Functions.dart';
import 'package:fitness_application/Load/loginpage.dart';
import 'package:fitness_application/Load/onboarding_screen.dart';
import 'package:fitness_application/Load/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: checkUserData(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? LoginPage(signcheck: true)
              : OnboardingScreen();
        },
      ),
    );
  }

  Future<bool> checkUserData() async {
    var user = await data_metter.readData('SELECT * FROM users');
    Map<String, dynamic> userData = user.first;
    bool a;
    if (userData['username'] == null)
      a = false;
    else
      a = true;
    return a;
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
