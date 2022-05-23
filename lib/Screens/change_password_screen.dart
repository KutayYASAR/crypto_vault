// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, curly_braces_in_flow_control_structures

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  bool _isEmailValid = false;

  final TextEditingController _newPasswordController = TextEditingController();

  AuthService _authService = AuthService();

  bool _isOldPasswordObscure = true;
  bool _isNewPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
      ),
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                  decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20))),
                  height: size.height / 3.25),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Change Password',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Fill the spaces bellow to change your password.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(35, (size.height / 18), 35, 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 45, 20, 0),
                          child: TextField(
                              obscureText: _isOldPasswordObscure,
                              controller: _oldPasswordController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                fillColor: kPrimaryLightColor,
                                filled: true,
                                hintText: 'Old Password',
                                contentPadding:
                                    EdgeInsets.only(top: 25, bottom: 25),
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(119, 119, 119, 1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 20),
                                  child: Icon(
                                    Icons.pin_outlined,
                                    size: 24,
                                    color: Color.fromRGBO(119, 119, 119, 1),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      _isOldPasswordObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color.fromRGBO(119, 119, 119, 1)),
                                  onPressed: () {
                                    setState(() {
                                      _isOldPasswordObscure =
                                          !_isOldPasswordObscure;
                                    });
                                  },
                                ),
                              ),
                              textInputAction: TextInputAction.next),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextField(
                              obscureText: _isNewPasswordObscure,
                              controller: _newPasswordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                fillColor: kPrimaryLightColor,
                                filled: true,
                                hintText: 'New Password',
                                contentPadding:
                                    EdgeInsets.only(top: 25, bottom: 25),
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(119, 119, 119, 1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 20),
                                  child: Icon(
                                    Icons.pin_outlined,
                                    size: 24,
                                    color: Color.fromRGBO(119, 119, 119, 1),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      _isNewPasswordObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color.fromRGBO(119, 119, 119, 1)),
                                  onPressed: () {
                                    setState(() {
                                      _isNewPasswordObscure =
                                          !_isNewPasswordObscure;
                                    });
                                  },
                                ),
                              ),
                              textInputAction: TextInputAction.next),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 45, 20, 45),
                          child: SizedBox(
                            width: double.infinity,
                            height: 70,
                            child: ElevatedButton(
                              onPressed: () async {
                                {
                                  await _authService.changePassword(
                                      _oldPasswordController.text,
                                      _newPasswordController.text,
                                      context);
                                }
                              },
                              child: Text('CHANGE PASSWORD',
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                              color: kPrimaryColor, width: 2))),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
