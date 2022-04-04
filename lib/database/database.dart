import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {

  var userCollection;

  connect() async {
    var db = await Db.create('mongodb+srv://jmarks:Nzsp_C7pagvgm34@cluster0.8kwix.mongodb.net/BlindAppDB?retryWrites=true&w=majority');
    await db.open();
    userCollection = db.collection('Users');
  }

}