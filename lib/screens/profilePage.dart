import 'package:flutter/material.dart';

import 'navBar.dart';

class ProfilePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SafeArea (
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Text(
              "Profile Page",
              style: TextStyle(
                  fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}