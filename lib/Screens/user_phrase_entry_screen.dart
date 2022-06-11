// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:crypto_vault/Screens/_page_selector.dart';
import 'package:crypto_vault/Screens/verify_email_signin_page.dart';
import 'package:crypto_vault/Screens/welcome_screen.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/models/api/firebase_api.dart';
import 'package:crypto_vault/models/firebase_file.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:crypto_vault/src/AES_encryption.dart';
import 'package:crypto_vault/src/keyGenerator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

import 'create_account_private_key_screen.dart';

class UserPhraseEntryScreen extends StatefulWidget {
  String email;
  String uid;
  UserPhraseEntryScreen({Key? key, required this.email, required this.uid})
      : super(key: key);

  @override
  State<UserPhraseEntryScreen> createState() => _UserPhraseEntryScreenState();
}

class _UserPhraseEntryScreenState extends State<UserPhraseEntryScreen> {
  final TextEditingController phraseController0 = TextEditingController();

  final TextEditingController phraseController1 = TextEditingController();

  final TextEditingController phraseController2 = TextEditingController();

  final TextEditingController phraseController3 = TextEditingController();

  final TextEditingController phraseController4 = TextEditingController();

  final TextEditingController phraseController5 = TextEditingController();

  final TextEditingController phraseController6 = TextEditingController();

  final TextEditingController phraseController7 = TextEditingController();

  final TextEditingController phraseController8 = TextEditingController();

  final TextEditingController phraseController9 = TextEditingController();

  final TextEditingController phraseController10 = TextEditingController();

  final TextEditingController phraseController11 = TextEditingController();

  final TextEditingController phraseController12 = TextEditingController();

  final TextEditingController phraseController13 = TextEditingController();

  final TextEditingController phraseController14 = TextEditingController();

  final TextEditingController phraseController15 = TextEditingController();

  final TextEditingController phraseController16 = TextEditingController();

  final TextEditingController phraseController17 = TextEditingController();

  final TextEditingController phraseController18 = TextEditingController();

  final TextEditingController phraseController19 = TextEditingController();

  final TextEditingController phraseController20 = TextEditingController();

  final TextEditingController phraseController21 = TextEditingController();

  final TextEditingController phraseController22 = TextEditingController();

  final TextEditingController phraseController23 = TextEditingController();

  AuthService _authService = AuthService();

  late Future<List<FirebaseFile>> futureFiles;

  Future passwordReset() async {
    var email = widget.email;
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) async {})
        .catchError((dynamic error) {
      print(error);
    });
  }

  @override
  void initState() {
    var uid = widget.uid;
    super.initState();
    futureFiles = FirebaseApi.listAll('$uid/check');
  }

  @override
  Widget build(BuildContext context) {
    var email = widget.email;
    String phrase = "";
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20))),
                height: size.height / 3.25),
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'ENTER YOUR PRIVATE KEY',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Please enter your private key to reset  your password',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController0,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController1,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController2,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController3,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController4,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController5,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController6,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController7,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController8,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController9,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController10,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController11,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController12,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController13,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController14,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController15,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController16,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController17,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController18,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController19,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController20,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController21,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController22,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 33,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15.5, 15, 0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: phraseController23,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Word',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: kTextDarkColor),
                                          ),
                                        )),
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Container(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  phrase = "${phraseController0.text.trim()}" +
                                      " " +
                                      "${phraseController1.text.trim()}" +
                                      " " +
                                      "${phraseController2.text.trim()}" +
                                      " " +
                                      "${phraseController3.text.trim()}" +
                                      " " +
                                      "${phraseController4.text.trim()}" +
                                      " " +
                                      "${phraseController5.text.trim()}" +
                                      " " +
                                      "${phraseController6.text.trim()}" +
                                      " " +
                                      "${phraseController7.text.trim()}" +
                                      " " +
                                      "${phraseController8.text.trim()}" +
                                      " " +
                                      "${phraseController9.text.trim()}" +
                                      " " +
                                      "${phraseController10.text.trim()}" +
                                      " " +
                                      "${phraseController11.text.trim()}" +
                                      " " +
                                      "${phraseController12.text.trim()}" +
                                      " " +
                                      "${phraseController13.text.trim()}" +
                                      " " +
                                      "${phraseController14.text.trim()}" +
                                      " " +
                                      "${phraseController15.text.trim()}" +
                                      " " +
                                      "${phraseController16.text.trim()}" +
                                      " " +
                                      "${phraseController17.text.trim()}" +
                                      " " +
                                      "${phraseController18.text.trim()}" +
                                      " " +
                                      "${phraseController19.text.trim()}" +
                                      " " +
                                      "${phraseController20.text.trim()}" +
                                      " " +
                                      "${phraseController21.text.trim()}" +
                                      " " +
                                      "${phraseController22.text.trim()}" +
                                      " " +
                                      "${phraseController23.text.trim()}";
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  String seed =
                                      KeyGenerator.phraseToSeed(phrase);

                                  final files = await futureFiles;
                                  final filex = files[0];
                                  final dir =
                                      await getApplicationDocumentsDirectory();
                                  final file =
                                      File('${dir.path}/${filex.ref.name}');
                                  await filex.ref.writeToFile(file);

                                  var f2Path =
                                      EncryptData.decrypt_file(file.path, seed);

                                  if (f2Path.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: 'Given Phrase is Not Correct.',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                    file.delete();
                                  } else {
                                    final fileCheck = File(f2Path);
                                    final contents =
                                        await fileCheck.readAsString();

                                    if (contents == 'true') {
                                      prefs.setString('phrase', phrase);
                                      prefs.setString('email', email);
                                      await passwordReset();
                                      file.delete();
                                      fileCheck.delete();
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
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
                                                                  15,
                                                                  15,
                                                                  15,
                                                                  10),
                                                          child: Text(
                                                            'Success!',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
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
                                                            'PASSWORD RESET MAIL HAS BEEN SENT TO YOUR ACCOUNTS MAIL!',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                            textAlign: TextAlign
                                                                .center,
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
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pushAndRemoveUntil(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                WelcomeScreen()),
                                                                        (route) =>
                                                                            false);
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
                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10))),
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all(
                                                                              kPrimaryColor)),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ]),
                                                ),
                                              ));
                                    }
                                  }
                                },
                                child: const Text('Enter Private Key',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    backgroundColor: MaterialStateProperty.all(
                                        kPrimaryColor)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
