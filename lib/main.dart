import 'package:blind_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'geolocation/geolocation.dart';
import 'database/database.dart';

var db = MongoDatabase();
<<<<<<< HEAD
var geo = GeoLocation();
var b;

void main() async {
String localUserId = 'then-dog-1993';

void main() {
  db.connect();
  runApp(MyApp());
  pushCurrentLocationToDB();
}

pushCurrentLocationToDB() async {
  await geo.getCurrentLocation();
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
      home: LoginPage(),
    );
  }
}