// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:crypto_vault/Screens/verify_email_page.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/models/api/firebase_api.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:crypto_vault/src/AES_encryption.dart';
import 'package:crypto_vault/src/keyGenerator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path/path.dart';

class CreateVaultScreen extends StatefulWidget {
  CreateVaultScreen({Key? key}) : super(key: key);

  @override
  State<CreateVaultScreen> createState() => _CreateVaultScreenState();
}

class _CreateVaultScreenState extends State<CreateVaultScreen>
    with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _nameSurnameController = TextEditingController();

  final TextEditingController _vaultNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscure = true;
  late AnimationController controllerEmail;
  late AnimationController controllernameSurname;
  late AnimationController controllerVaultName;
  late AnimationController controllerPassword;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/check.txt');
  }

  Future<File> writeCounter(String counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(counter);
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '0';
    }
  }

  @override
  void initState() {
    controllerEmail = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    controllernameSurname = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    controllerVaultName = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    controllerPassword = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimationEmail = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controllerEmail)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controllerEmail.reverse();
        }
      });
    final Animation<double> offsetAnimationNameSurname =
        Tween(begin: 0.0, end: 24.0)
            .chain(CurveTween(curve: Curves.elasticIn))
            .animate(controllernameSurname)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controllernameSurname.reverse();
            }
          });
    final Animation<double> offsetAnimationVaultName =
        Tween(begin: 0.0, end: 24.0)
            .chain(CurveTween(curve: Curves.elasticIn))
            .animate(controllerVaultName)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controllerVaultName.reverse();
            }
          });
    final Animation<double> offsetAnimationPassword =
        Tween(begin: 0.0, end: 24.0)
            .chain(CurveTween(curve: Curves.elasticIn))
            .animate(controllerPassword)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controllerPassword.reverse();
            }
          });

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
                                'CREATE A VAULT',
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
                                'Fill the spaces bellow to create your own vault',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
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
                        AnimatedBuilder(
                            animation: offsetAnimationEmail,
                            builder: (buildContext, child) {
                              return Container(
                                padding: EdgeInsets.only(
                                    left: offsetAnimationEmail.value + 24,
                                    right: 24 - offsetAnimationEmail.value),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 45, 0, 0),
                                  child: TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none)),
                                        fillColor: kPrimaryLightColor,
                                        filled: true,
                                        hintText: 'E-Mail',
                                        contentPadding: EdgeInsets.only(
                                            top: 25, bottom: 25),
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                119, 119, 119, 1),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20, left: 20),
                                          child: Icon(
                                            Icons.mail_outline,
                                            size: 24,
                                            color: Color.fromRGBO(
                                                119, 119, 119, 1),
                                          ),
                                        )),
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r'[ ]')),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        AnimatedBuilder(
                            animation: offsetAnimationNameSurname,
                            builder: (buildContext, child) {
                              return Container(
                                padding: EdgeInsets.only(
                                    left:
                                        offsetAnimationNameSurname.value + 24.0,
                                    right: 24.0 -
                                        offsetAnimationNameSurname.value),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: TextFormField(
                                      controller: _nameSurnameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none)),
                                        fillColor: kPrimaryLightColor,
                                        filled: true,
                                        hintText: 'Name / Surname',
                                        contentPadding: EdgeInsets.only(
                                            top: 25, bottom: 25),
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                119, 119, 119, 1),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20, left: 20),
                                          child: Icon(
                                            Icons.face,
                                            size: 24,
                                            color: Color.fromRGBO(
                                                119, 119, 119, 1),
                                          ),
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next),
                                ),
                              );
                            }),
                        AnimatedBuilder(
                            animation: offsetAnimationVaultName,
                            builder: (buildContext, child) {
                              return Container(
                                padding: EdgeInsets.only(
                                    left: offsetAnimationVaultName.value + 24.0,
                                    right:
                                        24.0 - offsetAnimationVaultName.value),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: TextFormField(
                                      controller: _vaultNameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none)),
                                        fillColor: kPrimaryLightColor,
                                        filled: true,
                                        hintText: 'Vault Name',
                                        contentPadding: EdgeInsets.only(
                                            top: 25, bottom: 25),
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                119, 119, 119, 1),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20, left: 20),
                                          child: Icon(
                                            Icons.lock,
                                            size: 24,
                                            color: Color.fromRGBO(
                                                119, 119, 119, 1),
                                          ),
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next),
                                ),
                              );
                            }),
                        AnimatedBuilder(
                            animation: offsetAnimationPassword,
                            builder: (buildContext, child) {
                              return Container(
                                padding: EdgeInsets.only(
                                    left: offsetAnimationPassword.value + 24.0,
                                    right:
                                        24.0 - offsetAnimationPassword.value),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: TextFormField(
                                    obscureText: _isPasswordObscure,
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none)),
                                      fillColor: kPrimaryLightColor,
                                      filled: true,
                                      hintText: 'Password',
                                      contentPadding:
                                          EdgeInsets.only(top: 25, bottom: 25),
                                      hintStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(119, 119, 119, 1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20, left: 20),
                                        child: Icon(
                                          Icons.pin_outlined,
                                          size: 24,
                                          color:
                                              Color.fromRGBO(119, 119, 119, 1),
                                        ),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            _isPasswordObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Color.fromRGBO(
                                                119, 119, 119, 1)),
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordObscure =
                                                !_isPasswordObscure;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 45),
                          child: SizedBox(
                            width: double.infinity,
                            height: 70,
                            child: ElevatedButton(
                              onPressed: () async {
                                bool _isEverythingValid = false;
                                if (_emailController.text.isEmpty) {
                                  controllerEmail.forward(from: 0.0);
                                  Fluttertoast.showToast(
                                      msg: 'Email Alanı Boş Olamaz.',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 1,
                                      fontSize: 16.0);
                                } else if (_nameSurnameController
                                    .text.isEmpty) {
                                  controllernameSurname.forward(from: 0.0);
                                  Fluttertoast.showToast(
                                      msg: 'İsim Soyisim Alanı Boş Olamaz.',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 1,
                                      fontSize: 16.0);
                                } else if (_vaultNameController.text.isEmpty) {
                                  controllerVaultName.forward(from: 0.0);
                                  Fluttertoast.showToast(
                                      msg: 'Kasa İsmi Alanı Boş Olamaz.',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 1,
                                      fontSize: 16.0);
                                } else if (_passwordController.text.isEmpty) {
                                  controllerPassword.forward(from: 0.0);
                                  Fluttertoast.showToast(
                                      msg: 'Şifre Alanı Boş Olamaz.',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 1,
                                      fontSize: 16.0);
                                } else {
                                  _isEverythingValid = true;
                                }

                                if (_isEverythingValid) {
                                  _authService
                                      .createVault(
                                          _emailController.text,
                                          _nameSurnameController.text.trim(),
                                          _vaultNameController.text.trim(),
                                          _passwordController.text)
                                      .then((value) async {
                                    String phrase =
                                        KeyGenerator.randomPhraseGenerator();

                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('phrase', phrase);

                                    prefs.setString(
                                        'email', _emailController.text);

                                    writeCounter('true');

                                    var vaultUid =
                                        await _authService.getVaultUid();

                                    var seed =
                                        KeyGenerator.phraseToSeed(phrase);

                                    String savefilepth =
                                        EncryptData.encrypt_file(
                                            await _localPath + '/check.txt',
                                            seed);

                                    var name = basename(savefilepth);

                                    FirebaseApi.uploadFile(
                                        '$vaultUid/check/$name',
                                        File(savefilepth));

                                    return Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VerifyEmailScreen(
                                                  phrase: phrase,
                                                )),
                                        (route) => false);
                                  }).catchError((dynamic error) {
                                    if (error.code.contains('invalid-email')) {
                                      Fluttertoast.showToast(
                                          msg: 'Mail Adresi Geçersizdir.',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                      controllerEmail.forward(from: 0.0);
                                    }
                                    if (error.code
                                        .contains('email-already-in-use')) {
                                      Fluttertoast.showToast(
                                          msg:
                                              'Bu Mail Adresi Kullanılmaktadır.',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                      controllerEmail.forward(from: 0.0);
                                    }
                                    if (error.code.contains('weak-password')) {
                                      Fluttertoast.showToast(
                                          msg:
                                              'Şifreniz En Az 6 Karakter Olmalıdır.',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                      controllerPassword.forward(from: 0.0);
                                    }
                                  });
                                }
                              },
                              child: Text('CREATE A VAULT',
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
