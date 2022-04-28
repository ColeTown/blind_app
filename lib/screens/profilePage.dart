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
          /*imageURL: "https://randomuser.me/api/portraits/lego/" +
              r.nextInt(10).toString() + ".jpg",*/
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

  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProfileUser(),
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          return Scaffold(
            body: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  buildTop(snapshot),
                  buildContent(snapshot),
                ]
            ),
          );
        }
        else{
          return Scaffold();
        }
      }
    );
  }

  Widget buildTop(AsyncSnapshot snapshot) {
    final double bottom = profileHeight / 2;
    final double top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child:  buildCoverImage(snapshot),
        ),
        Positioned(
            top: top,
            child: buildProfileImage(snapshot)),
      ],
    );
  }

  Widget buildCoverImage(AsyncSnapshot snapshot) => Container(
    color: Colors.grey,
    child: Image.network(
      "https://placeimg.com/640/480/grayscale",
        width: double.infinity,
      height: coverHeight,
      fit: BoxFit.cover
    ),
  );

  Widget buildProfileImage(AsyncSnapshot snapshot) => CircleAvatar(
    radius: profileHeight / 2,
    backgroundColor: Colors.white,
    child: CircleAvatar(
      backgroundImage: MemoryImage(snapshot.data[0]!.imageData, scale: 1),
      /*NetworkImage("https://placeimg.com/640/480/any",),*/
      radius: 60,
    ),
  );

  Widget buildContent(AsyncSnapshot snapshot) => Column(
    children: [
      const SizedBox(height: 8),
      Text(
        snapshot.data[0]!.name,
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.normal)
      ),
      const SizedBox(height: 8),
      const Text(
        'Software Engineer',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      const SizedBox(height: 1),
      const Divider(),
      const SizedBox(height: 1),
      buildAbout(snapshot),
    ],
  );

  Widget buildAbout(AsyncSnapshot snapshot) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          snapshot.data[0]!.bioText,
            style: TextStyle(fontSize: 16, height: 1),
        ),
        SizedBox(height: 16),
        const Text(
          'Interests',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          snapshot.data[0]!.tags.toString(),
          style: TextStyle(fontSize: 16, height: 1),
        )
      ],
    ),
  );

}