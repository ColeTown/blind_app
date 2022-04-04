import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {

  var Connections;
  var Interactions;
  var Messages;
  var UserTags;
  var Users;

  connect() async {
    try {
      var db = await Db.create(
          'mongodb+srv://jmarks:Nzsp_C7pagvgm34@cluster0.8kwix.mongodb.net/BlindAppDB?retryWrites=true&w=majority');
      await db.open();
      Connections = db.collection('Connections');
      Interactions = db.collection('Interactions');
      Messages = db.collection('Messages');
      UserTags = db.collection('UserTags');
      Users = db.collection('Users');
    } catch(e) {
      print(e);
    }
  }

  getConnections(String userid1, String userid2) async {
    return await Connections.find(where.eq('userid1', userid1).eq('userid2', userid2)).toList();
  }

  getInteractions(String userid1, String userid2) async {
    return await Interactions.find(where.eq('userid1', userid1).eq('userid2', userid2)).toList();
  }

  getMessages(String sender, String receiver) async {
    return await Messages.find(where.eq('sender_id', sender).eq('receiver_id', receiver)).toList();
  }

  getUserTags(String givenId) async {
    return await UserTags.find(where.eq('userid', givenId)).toList();
  }

  getUsers(String givenId) async {
    return await Users.find(where.eq('userid', givenId)).toList();
  }

  insertConnection(String userid1, String userid2, DateTime connectionDate) async {
    return await Connections.insertOne({'userid1': userid1, 'userid2':userid2, 'connection_date': connectionDate});
  }

  insertInteractions(String userid1, String userid2, DateTime timeStamp) async {
    return await Interactions.insertOne({'userid1': userid1, 'userid2':userid2, 'time_stamp': timeStamp});
  }

  insertMessage(String messageId, String senderId, String receiverId, DateTime timeSent) async {
    return await Messages.insertOne({'message_id': messageId, 'sender_id': senderId, 'receiver_id': receiverId, 'time_sent': timeSent});
  }

  insertUserTag(String userId, String tag) async {
    return await UserTags.insertOne({'userid': userId, 'tag': tag});
  }

  insertUser(String userId, String email, String pw, String fName, String lName, DateTime joinDate) async {
    return await Users.insertOne({'userid': userId, 'email': email, 'pw': pw, 'fname': fName, 'lname':lName, 'joindate':joinDate});
  }

}