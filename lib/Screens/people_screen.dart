// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_vault/Screens/add_user_screen.dart';
import 'package:crypto_vault/Screens/chat_inner_screen.dart';
import 'package:crypto_vault/Screens/invite_people.dart';
import 'package:crypto_vault/Screens/people_info_screen.dart';
import 'package:crypto_vault/Screens/settings_screen.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:flutter/material.dart';

var chatsPersonData = [
  [Icons.family_restroom, 'People Name 1'],
];

AppBar AppBarPeople(BuildContext context) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: kPrimaryLightColor,
    title: Text(
      'People',
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

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  late bool isAdmin;
  AuthService _authService = AuthService();
  IconData? iconData = Icons.abc;
  String? stringData = 'NULL';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      iconData = chatsPersonData[index][0] as IconData?;
                      stringData = chatsPersonData[index][1] as String?;
                      return InkWell(
                        child: peopleCard(context, iconData, stringData),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PeopleInfoScreen()));
                        },
                        borderRadius: BorderRadius.circular(15),
                      );
                    },
                    itemCount: chatsPersonData.length,
                  ),
                  */

                  FutureBuilder<List<String>>(
                    future: _authService.getPeopleName(),
                    builder: (context, snapshot) {
                      List<String> nameList = snapshot.data ?? [];
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: nameList.length,
                              itemBuilder: (BuildContext context, int index) {
                                iconData = chatsPersonData[0][0] as IconData?;
                                stringData = nameList[index].toString();
                                return InkWell(
                                  child:
                                      peopleCard(context, iconData, stringData),
                                  onTap: () async {
                                    List<bool> permissionList =
                                        await _authService
                                            .getClickedPersonPermissionData(
                                                nameList[index]);
                                    String adminStatus = await _authService
                                        .getAdminStatusOfClickedPerson(
                                            nameList[index]);
                                    String adminStatusOfUser =
                                        await _authService.getAdminStatus();
                                    var clickedPersonUid =
                                        await _authService.getClickedPersonUid(
                                            nameList[index].toString());
                                    var whoSent = await _authService
                                        .getCurrentUser()!
                                        .uid;
                                    var currentUserName =
                                        await _authService.getCurrentUserName();
                                    if (adminStatusOfUser == 'Admin') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PeopleInfoScreen(
                                                    adminStatus: adminStatus,
                                                    userName: nameList[index]
                                                        .toString(),
                                                    permissionList:
                                                        permissionList,
                                                  )));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatsInnerScreen(
                                                    whoSent: whoSent,
                                                    clickedPersonUid:
                                                        clickedPersonUid,
                                                    userName: nameList[index]
                                                        .toString(),
                                                    currentUserName:
                                                        currentUserName,
                                                  )));
                                      await _authService.createChats(
                                          clickedPersonUid,
                                          nameList[index].toString());
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(15),
                                );
                              },
                            )
                          : Center(child: CircularProgressIndicator());
                    },
                  ),
                  FutureBuilder<String>(
                    future: _authService.getAdminStatus(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      if (snapshot.data == "Admin") {
                        isAdmin = true;
                      } else {
                        isAdmin = false;
                      }
                      return isAdmin
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.03,
                                  bottom: size.height * 0.03),
                              child: SizedBox(
                                height: size.height * 0.05,
                                width: size.width * 0.50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddUserScreen()));
                                  },
                                  child: Text('ADD USER',
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(5),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              side: BorderSide(
                                                  color: kPrimaryColor,
                                                  width: 1))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                ),
                              ),
                            )
                          : Center();
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Padding peopleCard(BuildContext context, IconData? icon, String? chatName) {
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
