// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:crypto_vault/Screens/chats_inner_screen.dart';
import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';

var chatsPersonData = [
  ['Image 1', 'Chat Name 1'],
  ['Image 2', 'Chat Name 2'],
  ['Image 3', 'Chat Name 3'],
];

AppBar AppBarChats() {
  return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: kPrimaryLightColor,
      title: Text(
        'Chats',
        style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
      ));
}

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                child: chatsCard(context, chatsPersonData[index][0],
                    chatsPersonData[index][1]),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatsInnerScreen()));
                },
                borderRadius: BorderRadius.circular(20),
              );
            },
            itemCount: chatsPersonData.length,
          ),
        ],
      ),
    );
  }

  Padding chatsCard(BuildContext context, String image, String chatName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Row(
              children: [
                Text(image),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    chatName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_right_outlined,
                  color: kPrimaryColor,
                  size: 30,
                ),
              ],
            )),
      ),
    );
  }
}
