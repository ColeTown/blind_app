import 'package:blind_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'geolocation/geolocation.dart';
import 'database/database.dart';

var db = MongoDatabase();
var geo = GeoLocation();

String localUserId = 'then-dog-1993';

void main() {
  db.connect();
  runApp(MyApp());
  pushCurrentLocationToDB();
}

pushCurrentLocationToDB() async {
  await geo.getCurrentLocation();
  db.updateLocation(localUserId, geo.currentPosition);
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