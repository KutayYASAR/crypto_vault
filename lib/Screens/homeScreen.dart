// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_element, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:crypto_vault/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var CardsCreate = [
  ['png.jpg1', 'File Example1'],
  ['png.jpg2', 'File Example2'],
  ['png.jpg3', 'File Example3']
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
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 200),
          child: Text(
            'Recent Files',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return createAccountPrivateKeyCard(
                  context, CardsCreate[index][0], CardsCreate[index][1]);
            },
            itemCount: CardsCreate.length,
          ),
        ),
      ],
    );
  }
}

Padding createAccountPrivateKeyCard(
    BuildContext context, String privateKeyText1, privateKeyText2) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Card(
            color: Colors.white,
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
      ],
    ),
  );
}
