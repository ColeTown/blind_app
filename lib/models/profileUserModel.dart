//Authors: Anderson 4/6/22

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class ProfileUser{
  String userId;
  String name;
  String bioText;
  /*String imageURL;*/
  List<String> tags;
  Uint8List imageData;

  ProfileUser({ required this.userId,  required this.name, required this.bioText, /*required this.imageURL,*/ required this.tags, required this.imageData});
}