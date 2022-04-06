import 'package:blind_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'geolocation/geolocation.dart';
import 'database/database.dart';
import 'python/pythonapi.dart';

var db = MongoDatabase();
var geo = GeoLocation();
var py = Python();

String localUserId = 'middle-mole-4206';

void main() {
  db.connect();
  runApp(MyApp());
  pushCurrentLocationToDB(localUserId);
  //getResponse(localUserId);
}

pushCurrentLocationToDB(String userId) async {
  await geo.getCurrentLocation();
  await updateLocation(userId, geo.currentPosition);
}

updateLocation(String userId, Position position) async {

  await db.updateLocation(userId, position);

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