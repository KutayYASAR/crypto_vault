// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';

import 'create_account_private_key_screen.dart';

var privateKeyData = [
  ['pkt1', 'pkt2'],
  ['pkt3', 'pkt4'],
  ['pkt5', 'pkt6'],
  ['pkt7', 'pkt8'],
  ['pkt9', 'pkt10'],
  ['pkt11', 'pkt12'],
  ['pkt13', 'pkt14'],
  ['pkt15', 'pkt16'],
  ['pkt17', 'pkt18'],
  ['pkt19', 'pkt20'],
  ['pkt21', 'pkt22'],
  ['pkt23', 'pkt24'],
];

class ResetPasswordKeyScreen extends StatelessWidget {
  const ResetPasswordKeyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          fontWeight: FontWeight.w300),
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
                          padding: const EdgeInsets.only(top: 25),
                          child: Container(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return createAccountPrivateKeyCard(context);
                              },
                              itemCount: privateKeyData.length,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 15),
                          child: Container(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateAccountPrivateKeyScreen()));
                                },
                                child: const Text('RESET PASSWORD',
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

  Padding createAccountPrivateKeyCard(BuildContext context) {
    return Padding(
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
                    padding: EdgeInsets.fromLTRB(15, 15.5, 15, 0),
                    child: TextField(
                      textInputAction: TextInputAction.next,
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
                    padding: EdgeInsets.fromLTRB(15, 15.5, 15, 0),
                    child: TextField(
                      textInputAction: TextInputAction.next,
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
    );
  }
}
