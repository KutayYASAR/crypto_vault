
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';

var cardData =[
[Icons.credit_card,'ID\'s and Personal Info'],
[Icons.key,'Passwords'],
[Icons.apartment,'Property & Household'],
[Icons.real_estate_agent,'Estate'],
[Icons.family_restroom,'Family'],
[Icons.local_hospital,'Health'],
[Icons.business_center_rounded,'Personal Business'],
[Icons.folder_copy,'Archive'],
];

AppBar AppBarVaults() {
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
                onPressed: () {},
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

class VaultsMainScreen extends StatelessWidget {
  const VaultsMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData? iconData = Icons.abc;
    String? stringData = 'NULL';
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left:25,right: 25,top: 25,bottom: 25),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 25,
                childAspectRatio: 160/128
              ),
              itemCount: cardData.length,
              itemBuilder: (BuildContext context, int index) {
                iconData = cardData[index][0] as IconData?;
                stringData = cardData[index][1] as String?;
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: gridElement(iconData,stringData),
                  ),
                  onTap: (){},
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Container gridElement(IconData? icon, String? text) {
    return Container(
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: kTextDarkColor,offset: Offset(0,5),blurRadius: 3,spreadRadius:-1)],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(icon,size: 32,color: kTextDarkColor,),
                    Text(text.toString(),style: TextStyle(color: kTextDarkColor,fontWeight: FontWeight.w500,fontSize:20),textAlign: TextAlign.center,)
                  ],
                ),
              );
  }
}