// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:crypto_vault/Screens/invite_people.dart';
import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';

var chatsPersonData = [
  ['Image 1', 'People Name 1'],
  ['Image 2', 'People Name 2'],
  ['Image 1', 'People Name 1'],
];

AppBar AppBarPeople() {
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

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewPortConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: viewPortConstraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: peopleCard(context, chatsPersonData[index][0],
                        chatsPersonData[index][1]),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InvitePeopleScreen()));
                    },
                    borderRadius: BorderRadius.circular(15),
                  );
                },
                itemCount: chatsPersonData.length,
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.03, bottom: size.height * 0.03),
                child: SizedBox(
                  height: size.height * 0.05,
                  width: size.width * 0.50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('CREATE INVITE LINK',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                        color: kPrimaryColor, width: 1))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Padding peopleCard(BuildContext context, String image, String chatName) {
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
