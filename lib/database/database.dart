import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  var Connections;
  var Interactions;
  var Messages;
  var UserTags;
  var Users;
  var db;

  connect() async {
    try {
      db = await Db.create(
          'mongodb+srv://jmarks:Nzsp_C7pagvgm34@cluster0.8kwix.mongodb.net/BlindAppDB?retryWrites=true&w=majority');
      await db.open();
      Connections = db.collection('Connections');
      Interactions = db.collection('Interactions');
      Messages = db.collection('Messages');
      UserTags = db.collection('UserTags');
      Users = db.collection('Users');
    } catch (e) {
      print(e);
    }
  }

  getConnections(String userid1, String userid2) async {
    try {
      return await Connections.find(
              where.eq('userid1', userid1).eq('userid2', userid2))
          .toList();
    } catch (e) {
      print(e);
    }
  }

  getInteractions(String userid1, String userid2) async {
    try {
      return await Interactions.find(
              where.eq('userid1', userid1).eq('userid2', userid2))
          .toList();
    } catch (e) {
      print(e);
    }
  }

  getMessages(String sender, String receiver) async {
    try {
      return await Messages.find(
              where.eq('sender_id', sender).eq('receiver_id', receiver))
          .toList();
    } catch (e) {
      print(e);
    }
  }

  getUserTags(String givenId) async {
    try {
      return await UserTags.find(where.eq('userid', givenId)).toList();
    } catch (e) {
      print(e);
    }
  }

  getUsers(String givenId) async {
    try {
      return await Users.find(where.eq('userid', givenId)).toList();
    } catch (e) {
      print(e);
    }
  }

  insertConnection(
      String userid1, String userid2, DateTime connectionDate) async {
    try {
      return await Connections.insertOne({
        'userid1': userid1,
        'userid2': userid2,
        'connection_date': connectionDate
      });
    } catch (e) {
      print(e);
    }
  }

  insertInteractions(String userid1, String userid2, DateTime timeStamp) async {
    try {
      return await Interactions.insertOne(
          {'userid1': userid1, 'userid2': userid2, 'time_stamp': timeStamp});
    } catch (e) {
      print(e);
    }
  }

  insertMessage(String messageText, String senderId, String receiverId,
      DateTime timeSent) async {
    try {
      return await Messages.insertOne({
        'text': messageText,
        'sender_id': senderId,
        'receiver_id': receiverId,
        'time_sent': timeSent
      });
    } catch (e) {
      print(e);
    }
  }

  insertUserTag(String userId, String tag) async {
    try {
      return await UserTags.insertOne({'userid': userId, 'tag': tag});
    } catch (e) {
      print(e);
    }
  }

  insertUser(String userId, String email, String pw, String fName, String lName,
      DateTime joinDate) async {
    try {
      return await Users.insertOne({
        'userid': userId,
        'email': email,
        'pw': pw,
        'fname': fName,
        'lname': lName,
        'joindate': joinDate
      });
    } catch (e) {
      print(e);
    }
  }
}
