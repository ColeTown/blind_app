import 'package:blind_app/screens/profilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'friendsPage.dart';
import 'homePage.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int currentIndex = 1;
  // void changeActivePage(int index) {
  //   setState(() {
  //     currentIndex = index;
  //   });
  // }

  List<Widget> pages = [];

  @override
  void initState() {
    pages = [
      FriendsPage(),
      HomePage(),
      ProfilePage(),
      //PythonPage(),
    ];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.account_circle_outlined),
          //   label: 'Python',
          // ),
        ],
      ),
    );
  }
}