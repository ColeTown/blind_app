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

  Future getProfileUser() async {
    Random r = Random();
    ProfileUser thisUserProfile = ProfileUser(imageURL: "https://randomuser.me/api/portraits/lego/" + r.nextInt(10).toString() +".jpg", userId: '', tags: [], name: '', bioText: '');
    /*try {
      ProfileUser thisUserProfile = ProfileUser(
        userId: localUserId,
        imageURL: "https://randomuser.me/api/portraits/lego/" + r.nextInt(10).toString() +".jpg",
        name: db.getName(localUserId),
        bioText: db.getBio(localUserId),
        tags: db.getUserTags(localUserId)
      );
    } catch (e) {
      print("Profile Page getProfileUser(): " + e.toString());
    // */
    return thisUserProfile;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProfileUser(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData){
          String name = snapshot.data!.name;
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
                                  backgroundImage: NetworkImage(snapshot.data!.imageURL),
                                  maxRadius: 80,
                                ),
                              ],
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

          );
        } //endelse
      } //builder
    );
  }
}