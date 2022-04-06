import 'package:flutter/cupertino.dart';

class ChatUsers{
  String userId;
  String name;
  String messageText;
  String imageURL;
  DateTime lastTime;
  ChatUsers({required this.userId, required this.name,required this.messageText,required this.imageURL,required this.lastTime});
}