// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:crypto_vault/Screens/chat_inner_screen.dart';
import 'package:crypto_vault/Screens/messages.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:flutter/material.dart';

var chatsPersonData = [
  [Icons.chat_bubble, 'Chat Name 1'],
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
                  FutureBuilder<List<String>>(
                      future: _authService.getPeopleChats(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        List<String> chatNameList = snapshot.data ?? [];
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  iconData = chatsPersonData[0][0] as IconData?;
                                  stringData = chatNameList[index].toString();
                                  return InkWell(
                                    child: chatsCard(
                                        context, iconData, stringData),
                                    onTap: () async {
                                      var clickedPersonUid = await _authService
                                          .getClickedPersonUid(
                                              chatNameList[index]);
                                      var whoSent = await _authService
                                          .getCurrentUser()!
                                          .uid;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatsInnerScreen(
                                                    whoSent: whoSent,
                                                    clickedPersonUid:
                                                        clickedPersonUid,
                                                    userName:
                                                        chatNameList[index],
                                                  )));
                                      print(chatNameList);
                                    },
                                    borderRadius: BorderRadius.circular(15),
                                  );
                                },
                                itemCount: chatNameList.length,
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                      })
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
