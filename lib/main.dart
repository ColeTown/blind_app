import 'package:blind_app/screens/friendsPage.dart';
import 'package:blind_app/screens/navBar.dart';
import 'package:flutter/material.dart';

import 'database/database.dart';
var db = MongoDatabase();

void main() {
  db.connect();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: NavBar(),
    );
  }
}