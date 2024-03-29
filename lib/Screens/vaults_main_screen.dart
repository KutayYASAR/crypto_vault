// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:crypto_vault/Screens/settings_screen.dart';
import 'package:crypto_vault/Screens/vault_inner_screen.dart';
import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';
import 'package:crypto_vault/services/auth_service.dart';

AppBar AppBarVaults(BuildContext context) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: kPrimaryLightColor,
    title: Text(
      'Vaults',
      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 9, 10, 9),
        child: Row(
          children: [
            IconButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsScreen()));
                },
                icon: Icon(
                  Icons.settings_outlined,
                  color: kPrimaryColor,
                  size: 27,
                )),
          ],
        ),
      )
    ],
  );
}

var cardData = [];

late bool forceStop;

class VaultsMainScreen extends StatefulWidget {
  VaultsMainScreen({Key? key}) : super(key: key);

  @override
  State<VaultsMainScreen> createState() => _VaultsMainScreenState();
}

class _VaultsMainScreenState extends State<VaultsMainScreen> {
  AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    cardData = [
      [Icons.credit_card_outlined, 'ID\'s and Personal Info'],
      [Icons.key, 'Passwords'],
      [Icons.apartment, 'Property & Household'],
      [Icons.real_estate_agent, 'Estate'],
      [Icons.family_restroom, 'Family'],
      [Icons.local_hospital, 'Health'],
      [Icons.business_center_outlined, 'Personal Business'],
      [Icons.folder_copy_outlined, 'Archive']
    ];
    forceStop = true;
  }

  @override
  Widget build(BuildContext context) {
    IconData? iconData = Icons.abc;
    String? stringData = 'NULL';
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 25, bottom: 25),
              child: FutureBuilder<List<bool>>(
                future: _authService.getPermissionData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center();
                  }
                  List<bool> permissionList = snapshot.data ?? [];
                  List<int> deleting = [];
                  if (forceStop) {
                    for (var i = 0; i <= 7; i++) {
                      if (permissionList[i] == false) {
                        deleting.add(i);
                      }
                    }
                    for (var i = deleting.length - 1; i >= 0; i--) {
                      cardData.removeAt(deleting[i]);
                    }
                    forceStop = false;
                  }
                  return snapshot.hasData
                      ? GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 25,
                                  childAspectRatio: 160 / 128),
                          itemCount: cardData.length,
                          itemBuilder: (BuildContext context, int index) {
                            iconData = cardData[index][0] as IconData?;
                            stringData = cardData[index][1] as String?;
                            return InkWell(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: gridElement(iconData, stringData),
                              ),
                              onTap: () async {
                                var uid = await _authService.getVaultUid();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VaultInnerScreen(
                                      uid: uid,
                                      vaultName: cardData[index][1].toString(),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container gridElement(IconData? icon, String? text) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: kTextDarkColor,
              offset: Offset(0, 5),
              blurRadius: 3,
              spreadRadius: -1)
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            icon,
            size: 32,
            color: kTextDarkColor,
          ),
          Text(
            text.toString(),
            style: TextStyle(
                color: kTextDarkColor,
                fontWeight: FontWeight.w500,
                fontSize: 20),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
