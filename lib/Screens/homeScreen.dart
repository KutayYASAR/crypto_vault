// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_element, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:crypto_vault/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var CardsCreate = [
  ['File Example1'],
  ['File Example2'],
  ['File Example3']
];

AppBar AppBarHome() {
  return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: kPrimaryLightColor,
      title: Text(
        'Home',
        style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
      ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 25),
            child: Text(
              'Available Vault Space',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 100),
              child: Text(
                'Recent Files',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return createAccountPrivateKeyCard(
                      context, CardsCreate[index][0]);
                },
                itemCount: CardsCreate.length,
              ),
            ),
          ],
        ),
        Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('EXPAND YOUR VAULT',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side:
                                  BorderSide(color: kPrimaryColor, width: 1))),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Padding createAccountPrivateKeyCard(BuildContext context, String cardText1) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Card(
            color: Colors.white,
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Center(
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 9, bottom: 9),
                          child: Icon(
                            Icons.file_copy,
                            color: kPrimaryColor,
                            size: 44.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            width: 1,
                            color: kPrimaryLightColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            cardText1,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: kTextDarkColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ],
    ),
  );
}
