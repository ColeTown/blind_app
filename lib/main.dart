import 'package:blind_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'Unit Tests/tests.dart';
import 'geolocation/geolocation.dart';
import 'database/database.dart';
//import 'python/pythonapi.dart';

var db = MongoDatabase();
var geo = GeoLocation();
//var py = Python();

String localUserId = '';

// *** TEST USER EMAILS ***
// phastings@guerrillamail.com
// sestrada@guerrillamail.com
// hhook@guerrillamail.com
// ckhan@guerrillamail.com
// cmill@guerrillamail.com
// avang@guerrillamail.com
// pleigh@guerrillamail.com
// acolon@guerrillamail.com
//  lguy@guerrillamail.com
//  jnoble@guerrillamail.com

// >>> All passwords for test profiles = 'asdf1234'

//'middle-mole-4206', 'then-dog-1993', 'american-hyena-8431', 'charming-cat-972'

Future<void> main() async {
  await db.connect();
  runApp(MyApp());
  pushCurrentLocationToDB(localUserId);
  //getResponse(localUserId);
  unitTests();
}

pushCurrentLocationToDB(String userId) async {
  await geo.getCurrentLocation();
  await updateLocation(userId, geo.currentPosition);
}

updateLocation(String userId, Position position) async {

  await db.updateLocation(userId, position);

}

//getResponse(String userId) async {
//
//  await py.getResponse(userId);
//
//}

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