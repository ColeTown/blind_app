import 'package:flutter/cupertino.dart';

class ChatMessage{
  String messageContent;
  String messageType;
  DateTime timeSent;
  ChatMessage({required this.messageContent, required this.messageType, required this.timeSent});
}