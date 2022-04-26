//Authors: Anderson 4/6/22

import 'dart:math';

import 'package:flutter/material.dart';
import '../models/profileUserModel.dart';
import '../main.dart';
import 'package:intl/intl.dart';
import 'navBar.dart';

class ProfilePage extends StatefulWidget{
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{
  refresh() {
    setState(() {});
  }

  Future<List> getProfileUser() async {
    Random r = Random();
    try {
      var user = await db.getUsers(localUserId);
      var userTags = await db.getUserTags(localUserId);
      List<String> tagList = [];
      for (var tag in userTags) {
        tagList.add(tag['tag']);
      }

      ProfileUser thisUserProfile = ProfileUser(
          userId: localUserId,
          imageURL: "https://randomuser.me/api/portraits/lego/" +
              r.nextInt(10).toString() + ".jpg",
          name: user[0]['fname'] + " " + user[0]['lname'],
          bioText: user[0]['bio'],
          tags: tagList,

          imageData: await db.getPfp(localUserId)
      );
      List<ProfileUser> profile = [];
      profile.add(thisUserProfile);
      return profile;
    } catch (e) {
      print("Profile Page getProfileUser(): " + e.toString());
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProfileUser(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData){
          return Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            "Profile Page",
                            style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  <Widget>[
                          Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  backgroundImage: MemoryImage(snapshot.data[0]!.imageData, scale: 1),// NetworkImage(snapshot.data[0]!.imageURL),
                                  maxRadius: 80,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: 16, left: 16, right: 16),
                            child:  Text(
                                snapshot.data[0]!.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)
                              ),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                            child: Text(
                                "City, State"
                              ),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                            child: Text(
                                "About Me:"
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
                            child:
                            Container(
                              decoration: const BoxDecoration(color: Colors.cyan),
                              width: 300,
                              height: 60,
                              child:  Text(
                                  snapshot.data[0]!.bioText
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                            child: Text(
                                "Tags:"
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
                            child:
                            Container(
                                decoration: const BoxDecoration(color: Colors.cyan),
                                width: 300,
                                height: 60,
                                child: Text(
                                  snapshot.data[0]!.tags.toString()
                                ),
                            ),
                          ),
                        ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else{
          return Scaffold(
                //This will be done later
          );
        } //endelse
      } //builder
    );
  }
}