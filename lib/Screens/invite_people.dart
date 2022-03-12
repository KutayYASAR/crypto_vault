// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:crypto_vault/Screens/chats_inner_screen.dart';
import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

var vaultsData = [
  ['Family'],
  ['Estate'],
  ['ID\'s and Personal Data'],
];

var permissionData = [
  ['Create Vaults'],
  ['Start Direct Messages'],
];

class InvitePeopleScreen extends StatefulWidget {
  const InvitePeopleScreen({Key? key}) : super(key: key);

  @override
  State<InvitePeopleScreen> createState() => _InvitePeopleState();
}

class _InvitePeopleState extends State<InvitePeopleScreen> {
  String dropdownValue = 'Member';
  bool statusCreateVaults = false;
  bool statusStartDirectMessages = false;

  var degisken = false;

  final _isSelectedPermissions = Map();
  final _isSelectedVaults = Map();

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          foregroundColor: kPrimaryColor,
          elevation: 0.0,
          backgroundColor: kPrimaryLightColor,
          centerTitle: true,
          title: Text(
            'Invite People',
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
                        Icons.settings,
                        color: kPrimaryColor,
                      )),
                ],
              ),
            )
          ],
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
                      memberContainer(sizeWidth),
                      permissionsColumn(sizeWidth),
                      vaultsTheyAreInColumn(sizeWidth)
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                        bottom: MediaQuery.of(context).size.height * 0.02),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('CREATE INVITE LINK',
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

  Column permissionsColumn(double sizeWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(
                left: sizeWidth / 20,
              ),
              child: Text(
                'PERMISSIONS',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            if (!_isSelectedPermissions.containsKey(index)) {
              _isSelectedPermissions[index] = false;
            }
            return permissionsContainer(
                context, sizeWidth, index, permissionData[index][0]);
          },
          itemCount: permissionData.length,
        )
      ],
    );
  }

  InkWell permissionsContainer(
      BuildContext context, double sizeWidth, index, String permissionName) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 15,
            decoration: BoxDecoration(
                color: Colors.white, border: Border.all(color: Colors.white)),
            child: Padding(
              padding:
                  EdgeInsets.only(left: sizeWidth / 13, right: sizeWidth / 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(permissionName,
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  FlutterSwitch(
                      width: MediaQuery.of(context).size.width / 5,
                      height: MediaQuery.of(context).size.height / 20,
                      toggleSize: MediaQuery.of(context).size.height / 24,
                      value: _isSelectedPermissions[index],
                      borderRadius: 20.0,
                      activeColor: kPrimaryColor,
                      onToggle: (val) {
                        setState(() {
                          _isSelectedPermissions[index] = val;
                        });
                      }),
                ],
              ),
            )),
      ),
    );
  }

  Column vaultsTheyAreInColumn(double sizeWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
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
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            if (!_isSelectedVaults.containsKey(index)) {
              _isSelectedVaults[index] = false;
            }
            return vaultNamesContainer(
                context, sizeWidth, index, vaultsData[index][0]);
          },
          itemCount: vaultsData.length,
        )
      ],
    );
  }

  InkWell vaultNamesContainer(
      BuildContext context, double sizeWidth, index, String vaultName) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 15,
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
                      width: MediaQuery.of(context).size.width / 5,
                      height: MediaQuery.of(context).size.height / 20,
                      toggleSize: MediaQuery.of(context).size.height / 24,
                      value: _isSelectedVaults[index],
                      borderRadius: 20.0,
                      activeColor: kPrimaryColor,
                      onToggle: (val) {
                        setState(() {
                          _isSelectedVaults[index] = val;
                        });
                      }),
                ],
              ),
            )),
      ),
      onTap: () {},
    );
  }

  Padding memberContainer(double sizeWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 15,
        decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: Colors.white)),
        child: Padding(
          padding: EdgeInsets.only(left: sizeWidth / 13, right: sizeWidth / 13),
          child: DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue,
            underline: Container(
              height: 0,
            ),
            icon: Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: TextStyle(color: Colors.black, fontSize: 16),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
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
