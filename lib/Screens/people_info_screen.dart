// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:crypto_vault/Screens/chat_inner_screen.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

var vaultsData = [
  ['ID\'s and Personal Data'],
  ['Passwords'],
  ['Property & Household'],
  ['Estate'],
  ['Family'],
  ['Health'],
  ['Personal Business'],
  ['Archive'],
];

class PeopleInfoScreen extends StatefulWidget {
  final String adminStatus;
  final String userName;
  final List<bool> permissionList;
  PeopleInfoScreen(
      {Key? key,
      required this.userName,
      required this.permissionList,
      required this.adminStatus})
      : super(key: key);

  @override
  State<PeopleInfoScreen> createState() => _PeopleInfoScreenState();
}

class _PeopleInfoScreenState extends State<PeopleInfoScreen> {
  String dropdownValue = 'Member';
  bool statusCreateVaults = false;
  bool statusStartDirectMessages = false;

  AuthService _authService = AuthService();

  Future<void> setAdminStatusInfo(String userName, String newValue) async {
    if (newValue == 'Admin') {
      await _authService.setAdminStatus(userName);
    }
    if (newValue == 'Member') {
      await _authService.setMemberStatus(userName);
    }
  }

  Future<void> setPermissionListData(permissionList, userName, index) async {
    if (permissionList[index] == true) {
      await _authService.setVaultPermissionStatusTrue(userName, index);
    } else if (permissionList[index] == false) {
      await _authService.setVaultPermissionStatusFalse(userName, index);
    }
  }

  var degisken = false;

  final _isSelectedVaults = Map();

  @override
  Widget build(BuildContext context) {
    var adminStatus = widget.adminStatus;
    List<bool> permissionList = widget.permissionList;
    final size = MediaQuery.of(context).size;
    var userName = widget.userName;
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: kPrimaryLightColor,
        appBar: AppBar(
          foregroundColor: kPrimaryColor,
          elevation: 0.0,
          backgroundColor: kPrimaryLightColor,
          centerTitle: true,
          title: Text(
            userName,
            style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
          ),
        ),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewPortConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewPortConstraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      FutureBuilder<String>(
                        future: _authService.getAdminStatus(),
                        builder: (context, snapshot) {
                          bool admindata = false;
                          if (snapshot.hasError) {}
                          if (snapshot.data == 'Admin') {
                            admindata = true;
                          }
                          return admindata
                              ? FutureBuilder(
                                  future: _authService
                                      .getAdminStatusOfClickedPerson(userName),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    String? adminData =
                                        (snapshot.data ?? "") as String?;
                                    if (snapshot.hasError) {}
                                    return memberContainer(sizeWidth,
                                        sizeHeight, userName, adminData!);
                                  })
                              : SizedBox.shrink();
                        },
                      ),
                      FutureBuilder<String>(
                        future: _authService.getAdminStatus(),
                        builder: (context, snapshot) {
                          bool admindata = false;
                          if (snapshot.hasError) {}
                          if (snapshot.data == 'Admin') {
                            admindata = true;
                          }
                          return admindata
                              ? vaultsTheyAreInColumn(sizeWidth, sizeHeight,
                                  permissionList, userName)
                              : Center();
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: sizeHeight * 0.02, bottom: sizeHeight * 0.02),
                    child: SizedBox(
                      height: sizeHeight * 0.05,
                      width: sizeWidth * 0.50,
                      child: ElevatedButton(
                        onPressed: () async {
                          var clickedPersonUid =
                              await _authService.getClickedPersonUid(userName);
                          var whoSent =
                              await _authService.getCurrentUser()!.uid;
                          var currentUserName =
                              await _authService.getCurrentUserName();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatsInnerScreen(
                                        whoSent: whoSent,
                                        clickedPersonUid: clickedPersonUid,
                                        userName: userName,
                                        currentUserName: currentUserName,
                                      )));
                          await _authService.createChats(
                              clickedPersonUid, userName);
                        },
                        child: Text('DIRECT MESSAGE',
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

  Column vaultsTheyAreInColumn(double sizeWidth, double sizeHeight,
      List<bool> permissionList, String userName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Padding(
            padding: EdgeInsets.only(
              left: sizeWidth / 20,
            ),
            child: Text(
              'VAULTS THEY ARE IN',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            if (!_isSelectedVaults.containsKey(index)) {
              _isSelectedVaults[index] = false;
            }
            return vaultNamesContainer(context, sizeWidth, sizeHeight, index,
                vaultsData[index][0], permissionList, userName);
          },
          itemCount: vaultsData.length,
        )
      ],
    );
  }

  InkWell vaultNamesContainer(
      BuildContext context,
      double sizeWidth,
      double sizeHeight,
      index,
      String vaultName,
      List<bool> permissionList,
      String userName) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Container(
            width: sizeWidth,
            height: sizeHeight / 15,
            decoration: BoxDecoration(
                color: Colors.white, border: Border.all(color: Colors.white)),
            child: Padding(
              padding:
                  EdgeInsets.only(left: sizeWidth / 13, right: sizeWidth / 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(vaultName,
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  FlutterSwitch(
                      width: sizeWidth / 5,
                      height: sizeHeight / 20,
                      toggleSize: sizeHeight / 24,
                      value: permissionList[index],
                      borderRadius: 20.0,
                      activeColor: kPrimaryColor,
                      onToggle: (val) {
                        setState(() {
                          permissionList[index] = val;
                          setPermissionListData(
                              permissionList, userName, index);
                        });
                      }),
                ],
              ),
            )),
      ),
      onTap: () {},
    );
  }

  Padding memberContainer(double sizeWidth, double sizeHeight, String userName,
      String adminStatus) {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: Container(
        width: sizeWidth,
        height: sizeHeight / 15,
        decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: Colors.white)),
        child: Padding(
          padding: EdgeInsets.only(left: sizeWidth / 13, right: sizeWidth / 13),
          child: DropdownButton<String>(
            isExpanded: true,
            value: adminStatus,
            underline: Container(
              height: 0,
            ),
            icon: Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: TextStyle(color: Colors.black, fontSize: 16),
            onChanged: (String? newValue) async {
              setState(() {
                dropdownValue = newValue!;

                setAdminStatusInfo(userName, newValue);
              });
            },
            items: <String>['Member', 'Admin']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
