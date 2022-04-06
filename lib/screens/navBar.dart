import 'package:blind_app/screens/explorePage.dart';
import 'package:blind_app/screens/profilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chatPage.dart';
import 'homePage.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int currentIndex = 1;

  List<Widget> pages = [];

  @override
  void initState() {
    pages = [
      ChatPage(),
      //HomePage(),
      ExplorePage(),
      ProfilePage(),
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
          /*BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location_alt_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}