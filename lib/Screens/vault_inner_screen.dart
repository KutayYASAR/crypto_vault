// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';

var cardsCreate = [
  ['File Example1'],
];

AppBar AppBarVaultsInnerScreen() {
  return AppBar(
    foregroundColor: kPrimaryColor,
    elevation: 0.0,
    backgroundColor: kPrimaryLightColor,
    centerTitle: true,
    title: Text(
      'Vault Name',
      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 9, 10, 9),
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: kPrimaryColor,
                  size: 30,
                )),
          ],
        ),
      )
    ],
  );
}

class VaultInnerScreen extends StatefulWidget {
  const VaultInnerScreen({Key? key}) : super(key: key);

  @override
  State<VaultInnerScreen> createState() => _VaultInnerState();
}

class _VaultInnerState extends State<VaultInnerScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBarVaultsInnerScreen(),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewPortConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewPortConstraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width,
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child: createRecentFileCard(
                                  size, context, cardsCreate[index][0]),
                              onTap: () {},
                            );
                          },
                          itemCount: cardsCreate.length,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.02, bottom: size.height * 0.02),
                    child: SizedBox(
                      height: size.height * 0.05,
                      width: size.width * 0.50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('ADD FILE',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        color: kPrimaryColor, width: 1))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }

  Padding createRecentFileCard(
      Size size, BuildContext context, String cardText1) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: size.width * 0.85,
            child: Card(
              color: Colors.white,
              elevation: 3,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
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
}
