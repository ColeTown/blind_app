//import 'package:test/expect.dart';
//import 'package:test/scaffolding.dart';
import '../main.dart';
<<<<<<< HEAD
import '../python/api.dart';
import 'dart:convert';


=======
import 'package:flutter_test/flutter_test.dart';
>>>>>>> 391af3c87773addba3d8ff9de603b2e299427a2e

void unitTests() async {
  test('TCCT01: Testing pulling user data from database', () async {

      var results = await db.getUsers('then-dog-1993');
      results[0]['pfp'] = "";
      var expected = '[{_id: ObjectId("62489a46d0ce025858c69c2d"), '
          'fname: Pierre, lname: Hastings, userid: then-dog-1993, '
          'email: phastings@guerrillamail.com, pw: asdf1234, '
          'joindate: 2022-04-02 05:00:00.000Z, bio: Hi! I am a test profile., '
          'pfp: }]';

      expect(results.toString(), expected);
  });

<<<<<<< HEAD
  test('TCCP01: Testing matching algorithm', () async {

    String url = "";

    var data = "";

    String usrName = 'then-dog-1993';

    url = 'http://10.0.2.2:5000/api?query=' + usrName;
    data =  await getData(url);
    
    var decoded = jsonDecode(data);

    var expected = '[charming-cat-972, middle-mole-4206]';


    expect(decoded['output'].toString(), expected);

  });


}
=======
  test('TCJM01: Testing user authentication function', () async {
    List results = [];
    results.add(await db.authUser('hhook@guerrillamail.com', 'asdf1234'));
    results.add(localUserId);

    var expected = '[true, american-hyena-8431]';

    expect(results.toString(), expected);
  });

>>>>>>> 391af3c87773addba3d8ff9de603b2e299427a2e

