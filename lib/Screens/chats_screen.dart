// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:crypto_vault/Screens/chats_inner_screen.dart';
import 'package:crypto_vault/Screens/messages.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:flutter/material.dart';

var chatsPersonData = [
  [Icons.chat_bubble, 'Chat Name 1'],
  [Icons.chat_bubble, 'Chat Name 2'],
  [Icons.chat_bubble, 'Chat Name 3'],
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
  AuthService _authService = AuthService();
  IconData? iconData = Icons.abc;
  String? stringData = 'NULL';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewPortConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewPortConstraints.maxHeight),
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      iconData = chatsPersonData[index][0] as IconData?;
                      stringData = chatsPersonData[index][1] as String?;
                      return InkWell(
                        child: chatsCard(context, iconData, stringData),
                        onTap: () async{
                          var clickedPersonUid = await _authService.getClickedPersonUid();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => messages(
                                    whoSent: ,clickedPersonUid:  ,
                                    
                                  )));
                        },
                        borderRadius: BorderRadius.circular(15),
                      );
                    },
                    itemCount: chatsPersonData.length,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Padding chatsCard(BuildContext context, IconData? icon, String? chatName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: kTextDarkColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    chatName.toString(),
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
