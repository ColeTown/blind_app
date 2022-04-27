import 'dart:typed_data';
import 'package:flutter/cupertino.dart';

class ChatUsers{
  String userId;
  String name;
  String messageText;
  String imageURL;
  DateTime lastTime;

  Uint8List imageData;

  ChatUsers({required this.userId, required this.name,required this.messageText,required this.imageURL,required this.lastTime, required this.imageData});
}