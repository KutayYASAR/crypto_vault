// ignore_for_file: prefer_const_constructors

import 'package:crypto_vault/Screens/signin_screen.dart';
import 'package:crypto_vault/Screens/welcome_screen.dart';
import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kPrimaryLightColor
      ),
      home: WelcomeScreen(),
    );
  }
}
