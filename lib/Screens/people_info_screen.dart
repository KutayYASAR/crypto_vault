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

class PeopleInfoScreen extends StatefulWidget {
  const PeopleInfoScreen({Key? key}) : super(key: key);

  @override
  State<PeopleInfoScreen> createState() => _PeopleInfoScreenState();
}

class _PeopleInfoScreenState extends State<PeopleInfoScreen> {
  String dropdownValue = 'Member';
  bool statusCreateVaults = false;
  bool statusStartDirectMessages = false;

  var degisken = false;

  final _isSelectedPermissions = Map();
  final _isSelectedVaults = Map();

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          foregroundColor: kPrimaryColor,
          elevation: 0.0,
          backgroundColor: kPrimaryLightColor,
          centerTitle: true,
          title: Text(
            'People Name 1',
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
                        size: 30,
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
                      memberContainer(sizeWidth, sizeHeight),
                      permissionsColumn(sizeWidth, sizeHeight),
                      vaultsTheyAreInColumn(sizeWidth, sizeHeight)
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: sizeHeight * 0.02, bottom: sizeHeight * 0.02),
                    child: SizedBox(
                      height: sizeHeight * 0.05,
                      width: sizeWidth * 0.50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatsInnerScreen()));
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

  Column permissionsColumn(double sizeWidth, double sizeHeight) {
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
            return permissionsContainer(context, sizeWidth, sizeHeight, index,
                permissionData[index][0]);
          },
          itemCount: permissionData.length,
        )
      ],
    );
  }

  InkWell permissionsContainer(BuildContext context, double sizeWidth,
      double sizeHeight, index, String permissionName) {
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
                  Text(permissionName,
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  FlutterSwitch(
                      width: sizeWidth / 5,
                      height: sizeHeight / 20,
                      toggleSize: sizeHeight / 24,
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

  Column vaultsTheyAreInColumn(double sizeWidth, double sizeHeight) {
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
                context, sizeWidth, sizeHeight, index, vaultsData[index][0]);
          },
          itemCount: vaultsData.length,
        )
      ],
    );
  }

  InkWell vaultNamesContainer(BuildContext context, double sizeWidth,
      double sizeHeight, index, String vaultName) {
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

  Padding memberContainer(double sizeWidth, double sizeHeight) {
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
