// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:crypto_vault/Screens/change_password_screen.dart';
import 'package:crypto_vault/Screens/welcome_screen.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var isSwitched = false;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: kPrimaryLightColor,
        appBar: AppBar(
          foregroundColor: kPrimaryColor,
          elevation: 0.0,
          backgroundColor: kPrimaryLightColor,
          centerTitle: true,
          title: const Text(
            'Settings',
            style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
          ),
          actions: [],
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: kPrimaryColor,
                        size: 27,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '  Account',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePasswordScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Change Password',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600]),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.03, bottom: size.height * 0.03),
                child: SizedBox(
                  height: size.height * 0.05,
                  width: size.width * 0.50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _authService.signOut();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('dark', false);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()),
                          (Route<dynamic> route) => false);
                    },
                    child: Text('SIGN OUT',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        color: kPrimaryColor, width: 1))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
