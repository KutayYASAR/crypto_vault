import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';

var chatsImageData = [
  ['Image 1'],
  ['Image 2']
];

var chatsPersonData = [
  ['Chat 1 Name'],
  ['Chat 2 Name']
];

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: kBackgroundColor,
          title: const Center(
            child: Text(
              'Chats',
              style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
            ),
          )),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: chatsCard(
                      chatsImageData[index][0], chatsPersonData[index][0]),
                  onTap: () {
                    debugPrint('a');
                  },
                  borderRadius: BorderRadius.circular(20),
                );
              },
              itemCount: chatsImageData.length,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Vaults',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chats',
          ),
        ],
        backgroundColor: kPrimaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
      ),
    );
  }

  Padding chatsCard(String image, String chatName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
