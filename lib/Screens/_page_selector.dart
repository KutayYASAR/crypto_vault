import 'package:crypto_vault/Screens/chats_screen.dart';
import 'package:crypto_vault/Screens/homeScreen.dart';
import 'package:crypto_vault/Screens/people_screen.dart';
import 'package:crypto_vault/Screens/vaults_main_screen.dart';

import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';

class pagesSelector extends StatefulWidget {
  const pagesSelector({Key? key}) : super(key: key);

  @override
  State<pagesSelector> createState() => _pagesSelectorState();
}

class _pagesSelectorState extends State<pagesSelector> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    VaultsMainScreen(),
    PeopleScreen(),
    ChatsScreen()
  ];

  static List<AppBar> _appbarOptions = <AppBar>[
    AppBarHome(),
    AppBarVaults(),
    AppBarPeople(),
    AppBarChats(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appbarOptions.elementAt(_selectedIndex),
      body: _widgetOptions.elementAt(_selectedIndex),
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
        backgroundColor: Colors.white,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kPrimaryColor,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
