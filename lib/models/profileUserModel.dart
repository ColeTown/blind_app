//Authors: Anderson 4/6/22

import 'package:flutter/cupertino.dart';

class ProfileUser{
  String userId;
  String name;
  String bioText;
  String imageURL;
  List<String> tags;
  ProfileUser({ required this.userId,  required this.name, required this.bioText, required this.imageURL, required this.tags});
}