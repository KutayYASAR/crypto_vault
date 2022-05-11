// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:crypto_vault/Screens/create_account_private_key_screen.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypto_vault/constants.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
    } catch (e) {}
  }

  Widget build(BuildContext context) {
    if (isEmailVerified) {
      return CreateAccountPrivateKeyScreen();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Confirm Your Email"),
          backgroundColor: kPrimaryColor,
          elevation: 0.0,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                  decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20))),
                  height: MediaQuery.of(context).size.height / 2),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      height: 110,
                      width: 110,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 18.0),
                      child: Text(
                        'CRYPTO VAULT',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5),
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      height: MediaQuery.of(context).size.height / 2.47,
                      width: double.infinity,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                              child: Text('Please Verify Your Gmail ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                              child: Text(
                                'Verification email has been sent to your mail.',
                                style: TextStyle(
                                    color: Color.fromRGBO(129, 129, 129, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 18,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size.fromHeight(50),
                                    ),
                                    icon: Icon(Icons.email, size: 32),
                                    label: Text('Resent Email',
                                        style: TextStyle(fontSize: 15)),
                                    onPressed: sendVerificationEmail,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 18,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size.fromHeight(50),
                                      ),
                                      icon: Icon(Icons.fork_left_outlined,
                                          size: 32),
                                      label: Text('Go Back',
                                          style: TextStyle(fontSize: 16)),
                                      onPressed: () async {
                                        await Phoenix.rebirth(context);
                                      })),
                            ),
                          ]),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}
