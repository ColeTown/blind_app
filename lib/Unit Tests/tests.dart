import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../main.dart';

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


}