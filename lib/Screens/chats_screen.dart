// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_vault/Screens/chat_inner_screen.dart';
import 'package:crypto_vault/Screens/group_chat_inner_screen.dart';
import 'package:crypto_vault/Screens/settings_screen.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:flutter/material.dart';

var chatsPersonData = [
  [Icons.chat_bubble, 'Chat Name 1'],
];

AppBar AppBarChats(BuildContext context) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: kPrimaryLightColor,
    title: Text(
      'Chats',
      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 9, 10, 9),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsScreen()));
                },
                icon: Icon(
                  Icons.settings,
                  color: kPrimaryColor,
                )),
          ],
        ),
      )
    ],
  );
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
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Card(
                        elevation: 5,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.chat_bubble,
                                  size: 32,
                                  color: kTextDarkColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Vault Chat',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: kPrimaryColor,
                                  size: 30,
                                ),
                              ],
                            )),
                      ),
                    ),
                    onTap: () async {
                      var whoSent = await _authService.getCurrentUser()!.uid;
                      var currentUserName =
                          await _authService.getCurrentUserName();
                      String vaultUid = "";
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .where('userUid',
                              isEqualTo: _authService.getCurrentUser()?.uid)
                          .get()
                          .then((QuerySnapshot querySnapshot) {
                        for (var doc in querySnapshot.docs) {
                          vaultUid = doc['vault_uid'].toString();
                        }
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GroupChatInnerScreen(
                                    whoSent: whoSent,
                                    currentUserName: currentUserName,
                                    vaultUid: vaultUid,
                                  )));
                    },
                    borderRadius: BorderRadius.circular(15),
                  ),
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
                                      var currentUserName = await _authService
                                          .getCurrentUserName();
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
                                                      currentUserName:
                                                          currentUserName)));
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
                  Icons.keyboard_arrow_right,
                  color: kPrimaryColor,
                  size: 30,
                ),
              ],
            )),
      ),
    );
  }
}
