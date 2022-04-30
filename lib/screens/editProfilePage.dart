
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/profileUserModel.dart';
import '../main.dart';
import 'package:intl/intl.dart';
import 'navBar.dart';
import '../widgets/EditPageWidgets.dart';

class editProfilePage extends StatefulWidget{
  @override
  _editProfilePageState createState() => _editProfilePageState();
}

class _editProfilePageState extends State<editProfilePage>{
  TextEditingController aboutController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
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
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child:  buildCoverImage(snapshot),
        ),
        Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              SizedBox(height: 350, width: profileHeight),
              Positioned(
                top: 200,
                child:
                buildProfileImage(snapshot),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: ClipOval(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.white,
                    child: ClipOval(
                        child: Container(
                            color: Colors.blue,
                            child: IconButton(
                              iconSize: 25,
                              icon: Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              ),
                              onPressed: () {  },
                            )
                        )
                    ),
                  ),
                ),
              )
            ]
        ),
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
      radius: 65,
    ),
  );

  Widget buildContent(AsyncSnapshot snapshot) => Column(
    children: [
      const SizedBox(height: 8),
      Text( //Get the Users Name
          snapshot.data[0]!.name,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.normal)
      ),
      const SizedBox(height: 8),
      const Text(  //Get the Users Occupation
        'Occupation',
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
        editingTextField(
          controller: aboutController,
          maxLines: 5,
          existingText: snapshot.data[0]!.bioText,
          onChanged: (later) {},
        ),
        SizedBox(height: 16),
        const Text(
          'Interests',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        editingTextField(
          controller: tagsController,
          maxLines: 2,
          existingText: snapshot.data[0]!.tags.toString(),
          onChanged: (later) {},
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.blue, fontSize: 15),
          )
        )
      ],
    ),
  );

}