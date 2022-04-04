import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollection = db.collection(USER_COLLECTION);
  }

}