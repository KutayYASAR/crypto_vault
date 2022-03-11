// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:crypto_vault/Screens/create_account_private_key_screen.dart';
import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';

class CreateVaultScreen extends StatelessWidget {
  const CreateVaultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
      ),
      body: Container(
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextField(
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
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: Icon(
                                  Icons.face,
                                  size: 24,
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none)),
                              fillColor: kPrimaryLightColor,
                              filled: true,
                              hintText: 'Vault Name',
                              contentPadding:
                                  EdgeInsets.only(top: 25, bottom: 25),
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: Icon(
                                  Icons.lock,
                                  size: 24,
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextField(
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
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: Icon(
                                  Icons.pin_outlined,
                                  size: 24,
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 45, 20, 45),
                          child: SizedBox(
                            width: double.infinity,
                            height: 70,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateAccountPrivateKeyScreen()));
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
