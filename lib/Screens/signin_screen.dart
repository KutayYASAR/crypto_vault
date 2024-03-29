// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:crypto_vault/Screens/reset_password_screen.dart';
import 'package:crypto_vault/Screens/user_phrase_entry_screen.dart';
import 'package:crypto_vault/Screens/user_phrase_reset_password.dart';
import 'package:crypto_vault/Screens/verify_email_signin_page.dart';
import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = false;

  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscure = true;
  late AnimationController controllerEmail;
  late AnimationController controllerPassword;

  @override
  void initState() {
    controllerEmail = AnimationController(
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
      ),
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20))),
                height: size.height / 3),
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
                              'SIGN IN',
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
                              'Sign in to your Vault using your e-mail and password',
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
                  padding: EdgeInsets.fromLTRB(35, 0, 35, (size.height / 5)),
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
                                padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
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
                                          Icons.mail_outline,
                                          size: 24,
                                          color:
                                              Color.fromRGBO(119, 119, 119, 1),
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
                          animation: offsetAnimationPassword,
                          builder: (buildContext, child) {
                            return Container(
                              padding: EdgeInsets.only(
                                  left: offsetAnimationPassword.value + 24.0,
                                  right: 24.0 - offsetAnimationPassword.value),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: TextField(
                                  obscureText: _isPasswordObscure,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            width: 0, style: BorderStyle.none)),
                                    fillColor: kPrimaryLightColor,
                                    filled: true,
                                    hintText: 'Password',
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
                                          _isPasswordObscure
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color:
                                              Color.fromRGBO(119, 119, 119, 1)),
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
                        padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              bool _isEverythingValid = false;
                              if (_emailController.text.isEmpty) {
                                controllerEmail.forward(from: 0.0);
                                Fluttertoast.showToast(
                                    msg:
                                        'Lütfen Hesabınızın Mail Adresini Giriniz.',
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
                                    .signIn(_emailController.text,
                                        _passwordController.text)
                                    .then((value) async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  String? prefsEmail = prefs.getString('email');
                                  if (prefsEmail ==
                                      _emailController.text.trim()) {
                                    return Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VerifyEmailSignInScreen()),
                                        (route) => false);
                                  } else {
                                    String uid =
                                        await _authService.getVaultUid();
                                    return Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserPhraseEntryScreen(
                                                    email:
                                                        _emailController.text,
                                                    uid: uid)),
                                        (route) => false);
                                  }
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
                                  if (error.code.contains('user-not-found')) {
                                    Fluttertoast.showToast(
                                        msg: 'Hesap Bulunamadı.',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                    controllerEmail.forward(from: 0.0);
                                  }
                                  if (error.code.contains('wrong-password')) {
                                    Fluttertoast.showToast(
                                        msg: 'Yanlış Şifre.',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                    controllerPassword.forward(from: 0.0);
                                  }
                                });
                              }
                            },
                            child: Text('SIGN IN',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: kPrimaryColor, width: 2))),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 25),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ResetPasswordScreen()));
                            },
                            child: Text(
                              'Forgot Your Password?',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            )),
                      )
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
