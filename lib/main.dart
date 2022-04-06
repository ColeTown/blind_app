import 'package:blind_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'geolocation/geolocation.dart';
import 'database/database.dart';
import 'python/pythonapi.dart';

var db = MongoDatabase();
var geo = GeoLocation();
var py = Python();

String localUserId = 'then-dog-1993';

void main() {
  db.connect();
  runApp(MyApp());
  pushCurrentLocationToDB();
  getResponse(localUserId);
}

pushCurrentLocationToDB() async {
  await geo.getCurrentLocation();
}

getResponse(String userId) {

  py.getResponse(userId);

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