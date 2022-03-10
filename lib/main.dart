// ignore_for_file: prefer_const_constructors
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/create_account_private_key_screen.dart';
import 'package:crypto_vault/resetPassword.dart';
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
          scaffoldBackgroundColor: kPrimaryLightColor),
      home: ResetPasswordScreen(),
    );
  }
}
