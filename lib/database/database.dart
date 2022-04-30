import 'package:flutter/services.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:blind_app/main.dart';

class MongoDatabase {
  var Connections;
  var Interactions;
  var Messages;
  var UserLocations;
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
      UserLocations = db.collection('UserLocations');
      UserTags = db.collection('UserTags');
      Users = db.collection('Users');
    } catch (e) {
      print(e);
    }
  }

  //will return a list of connections that userid1 is a part of
  getConnections(String userid1) async {
    try {
      List<String> connections = [];
      List connections1 = await Connections.find(
          where.eq('userid1', userid1))
          .toList();
      print(connections1);
      for(var con in connections1) {
        connections.add(con['userid2']);
      }
      List connections2 = await Connections.find(
          where.eq('userid2', userid1))
          .toList();
      print(connections2);
      for(var con in connections2) {
        connections.add(con['userid1']);
      }
      print(connections);
      return connections;
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

  //returns a list of messages from sender sent to receiver
  getMessages(String sender, String receiver) async {
    try {
      return await Messages.find(
              where.eq('sender_id', sender).eq('receiver_id', receiver))
          .toList();
    } catch (e) {
      print("getMessages: " + e.toString());
    }
  }


  getMostRecentMessage(String userId1, String userId2) async {
    try {
      List messages = await getMessages(userId1, userId2);
      messages.addAll(await getMessages(userId2, userId1));
      messages.sort((a,b) => b['time_sent'].compareTo(a['time_sent']));
      return messages.first;
    } catch (e) {
      print("getMostRecentMessage: " + e.toString());
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

  updateLocation(String userId, Position position) async {
    try {
     if(await UserLocations.findOne(where.eq('userid', userId))==null){
        return await UserLocations.insertOne({
          'userid': userId,
          'location': [position.longitude, position.latitude]
        });
      }
     else {
        await UserLocations.updateOne(where.eq('userid', userId),
            modify.set('location', [position.longitude, position.latitude]));
     }
    } catch (e) {
      print(e);
    }
  }

  getLocation(String userId) async {
    try{
      var location = await UserLocations.findOne(where.eq('userid', userId));
      return Position(longitude: location['location'][0], latitude: location['location'][1]);
    } catch (e) {
      print(e);
    }
  }

  // Returns an Image object converted from base64 of pfp for a given userId
  getPfp(String userId) async {
    try{
      Uint8List imgData;
      var user = await Users.findOne(where.eq('userid', userId));
      //String imgBin = user['pfp'];
      if(user['pfp'] != null) {
        imgData = base64Decode(user['pfp']);
      }
      else{
        imgData = (await rootBundle.load("lib/images/OOjs_UI_icon_userAvatar.svg.png")).buffer.asUint8List();
      }


      return imgData;
    } catch (e) {
      print(e);
    }
  }

  setPfp(String userId, MemoryImage image) async {
    try{
      return await Users.updateOne(where.eq('userid', userId), modify.set('pfp', base64Encode(image.bytes)));
    } catch (e) {
      print(e);
    }
  }

  setBio(String userId, String newBio) async{
    try{
      return await Users.updateOne(where.eq('userid', userId), modify.set('bio', newBio));
    } catch (e){
      print(e);
    }
  }

  // Check a user's credentials against database and return corresponding user
  authUser(String email, String pw) async {
    try{
      var user = await Users.findOne(where.eq('email', email));
      if(user != null && pw == user['pw']){
        localUserId = user['userid'];
        return true;
      }
      else{
        return false;
      }

    }
    catch (e) {
      print(e);
    }
  }


}
