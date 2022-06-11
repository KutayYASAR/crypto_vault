// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, curly_braces_in_flow_control_structures

import 'package:crypto_vault/Screens/create_account_private_key_screen.dart';
import 'package:crypto_vault/Screens/welcome_screen.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddUserScreen extends StatefulWidget {
  AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = false;

  final TextEditingController _nameSurnameController = TextEditingController();

  AuthService _authService = AuthService();

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
                                'Add User',
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
                                'Fill the spaces bellow to add users to your vault.',
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
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none)),
                                  fillColor: kPrimaryLightColor,
                                  filled: true,
                                  hintText: 'E-Mail',
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
                                      Icons.mail_outline,
                                      size: 24,
                                      color: Color.fromRGBO(119, 119, 119, 1),
                                    ),
                                  )),
                              textInputAction: TextInputAction.next),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextField(
                              controller: _nameSurnameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                fillColor: kPrimaryLightColor,
                                filled: true,
                                hintText: 'Name / Surname',
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
                                    Icons.face,
                                    size: 24,
                                    color: Color.fromRGBO(119, 119, 119, 1),
                                  ),
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
                              onPressed: () {
                                {
                                  _isEmailValid = EmailValidator.validate(
                                      _emailController.text);
                                  if (_isEmailValid) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              contentPadding:
                                                  EdgeInsets.only(top: 10),
                                              content: Container(
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                15, 15, 15, 10),
                                                        child: Text(
                                                          'Caution!',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 36,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20,
                                                                right: 20,
                                                                bottom: 10),
                                                        child: Text(
                                                          'IF YOU WANT TO ADD USER TO YOUR VAULT, APP WILL HAVE TO RESTART!',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    10,
                                                                    10,
                                                                    5,
                                                                    20),
                                                            child: SizedBox(
                                                              height: 40,
                                                              width:
                                                                  size.width *
                                                                      0.35,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    'GO BACK',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                style: ButtonStyle(
                                                                    shape: MaterialStateProperty.all<
                                                                            RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                10))),
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(
                                                                            kPrimaryColor)),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    5,
                                                                    10,
                                                                    10,
                                                                    20),
                                                            child: SizedBox(
                                                              height: 40,
                                                              width:
                                                                  size.width *
                                                                      0.35,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  await _authService.addUser(
                                                                      _emailController
                                                                          .text,
                                                                      _nameSurnameController
                                                                          .text);

                                                                  await _authService
                                                                      .signOut();
                                                                  Navigator.of(context).pushAndRemoveUntil(
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              WelcomeScreen()),
                                                                      (Route<dynamic>
                                                                              route) =>
                                                                          false);
                                                                },
                                                                child: Text(
                                                                    'RESTART',
                                                                    style: TextStyle(
                                                                        color:
                                                                            kPrimaryColor,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                style: ButtonStyle(
                                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        side: BorderSide(
                                                                            color:
                                                                                kPrimaryColor,
                                                                            width:
                                                                                2))),
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(
                                                                            Colors.white)),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ]),
                                              ),
                                            ));
                                  } else if (_emailController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: 'Email Alanı Boş Olamaz',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                  } else if (_nameSurnameController
                                      .text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: 'İsim Soyisim Alanı Boş Olamaz',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Lütfen Geçerli Bir Mail Adresi Giriniz',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                  }
                                }
                              },
                              child: Text('Add User',
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
