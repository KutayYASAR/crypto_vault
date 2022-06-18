// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:crypto_vault/Screens/_page_selector.dart';
import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';

class CreateAccountPrivateKeyScreen extends StatefulWidget {
  final String phrase;
  CreateAccountPrivateKeyScreen({Key? key, required this.phrase})
      : super(key: key);

  @override
  State<CreateAccountPrivateKeyScreen> createState() =>
      _CreateAccountPrivateKeyScreenState();
}

class _CreateAccountPrivateKeyScreenState
    extends State<CreateAccountPrivateKeyScreen> {
  @override
  Widget build(BuildContext context) {
    var phrase = widget.phrase;
    List result = phrase.split(' ');
    var privateKeyCreateData = [
      [result[0], result[1]],
      [result[2], result[3]],
      [result[4], result[5]],
      [result[6], result[7]],
      [result[8], result[9]],
      [result[10], result[11]],
      [result[12], result[13]],
      [result[14], result[15]],
      [result[16], result[17]],
      [result[18], result[19]],
      [result[20], result[21]],
      [result[22], result[23]],
    ];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
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
                height: size.height / 2.37),
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 70,
                    ),
                    child: Center(
                      child: Text(
                        'YOUR PRIVATE KEY',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, top: 12),
                      child: RichText(
                        text: TextSpan(
                            text: 'SAVE THIS KEY! ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    'Your data is Encrypted using this key. You will need it to access your encypted data in the case that you lose your password.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                            ]),
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return createAccountPrivateKeyCard(
                                context,
                                privateKeyCreateData[index][0],
                                privateKeyCreateData[index][1]);
                          },
                          itemCount: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 15),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding:
                                              EdgeInsets.only(top: 10),
                                          content: Container(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        15, 15, 15, 10),
                                                    child: Text(
                                                      'CAUTION !',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 36,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20,
                                                        right: 20,
                                                        bottom: 10),
                                                    child: Text(
                                                      'LOSING THIS KEY WILL RESULT IN LOSING ACCESS TO YOUR DATA. ARE YOU SURE THAT YOU SAVED THE KEY?',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w700),
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
                                                                10, 10, 20, 20),
                                                        child: SizedBox(
                                                          height: 40,
                                                          width:
                                                              size.width * 0.3,
                                                          child: ElevatedButton(
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
                                                                        FontWeight
                                                                            .w600)),
                                                            style: ButtonStyle(
                                                                shape: MaterialStateProperty.all<
                                                                        RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10))),
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                            kPrimaryColor)),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 10, 10, 20),
                                                        child: SizedBox(
                                                          height: 40,
                                                          width:
                                                              size.width * 0.3,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              pagesSelector()),
                                                                  (route) =>
                                                                      false);
                                                            },
                                                            child: Text(
                                                                'SAVED IT',
                                                                style: TextStyle(
                                                                    color:
                                                                        kPrimaryColor,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
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
                                                                    MaterialStateProperty
                                                                        .all(Colors
                                                                            .white)),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ]),
                                          ),
                                        ));
                              },
                              child: Text('I SAVED IT',
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
                                  backgroundColor:
                                      MaterialStateProperty.all(kPrimaryColor)),
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

  Padding createAccountPrivateKeyCard(
      BuildContext context, String privateKeyText1, privateKeyText2) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Card(
              color: kPrimaryLightColor,
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 9, 15, 9),
                  child: Center(
                    child: Text(
                      privateKeyText1,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: kTextDarkColor),
                    ),
                  )),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Card(
              color: kPrimaryLightColor,
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 9, 15, 9),
                  child: Center(
                    child: Text(
                      privateKeyText2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: kTextDarkColor),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
