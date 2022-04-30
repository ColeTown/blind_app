import 'package:flutter/material.dart';
import 'navBar.dart';
import '../main.dart';
import '../models/profileUserModel.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  refresh() {
    setState(() {});
  }
  Future<List> getUserData() async {
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
          //fname: user[0]['fname'],
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

  final double bannerHeight = 144;

  @override
  Widget build(BuildContext context) {
    buildPageBanner(context);
    return FutureBuilder(
        future: getUserData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData){
            return Scaffold(
                body: ListView(
                    //padding: const EdgeInsets.only( top: 10, bottom: 10),
                    children: <Widget>[
                      Divider(height: 2),
                      buildUserBanner(snapshot),
                      Divider(height: 2),
                      buildUserBanner(snapshot),
                      Divider(height: 2),
                      buildUserBanner(snapshot),
                      Divider(height: 2),
                      buildUserBanner(snapshot),
                      Divider(height: 2),
                      buildUserBanner(snapshot),
                      Divider(height: 2),
                      buildUserBanner(snapshot)
                    ]
                )
            );
          }
          else{return Scaffold();}
        }
    );
  }

  Widget buildPageBanner(BuildContext context) {
    return Column (
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
              child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text("Explore", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                      ]
                  )
              )
          )
        ]
    );
  }

  Widget buildUserBanner(AsyncSnapshot snapshot) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,

            padding: const EdgeInsets.only(top: 3, bottom: 3, left: 6),
            margin: const EdgeInsets.only(top:2,bottom:2),
            decoration:
              const BoxDecoration(
                color: Colors.blue
                ),
            child: buildThumbnail(snapshot),
          ),
          Container(
            height: 126,
            decoration:
              BoxDecoration(
                color: Colors.blue),
            child: Container(
              height: 110,
              padding: const EdgeInsets.only(top: 3, bottom: 3),
              margin: const EdgeInsets.only(top:2,bottom:2,left:8,right:8),
              decoration:
              BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: buildUserBio(snapshot),
            ),
          ),

          Container(
            child: buildYesNo(context),
          )


    ]);
  }

  Widget buildUserThumbnail(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
      child: const Text('1'),
    );
  }

  Widget buildThumbnail(AsyncSnapshot snapshot) => CircleAvatar(
    radius: 60,
    backgroundColor: Colors.white,
    child: CircleAvatar(
      backgroundImage: MemoryImage(snapshot.data[0]!.imageData, scale: 1),
      /*NetworkImage("https://placeimg.com/640/480/any",),*/
      radius: 55,
    ),
  );

  Widget buildUserBio(AsyncSnapshot snapshot) {
    return SizedBox(
      width: 160.7,
      child: (
        Column (
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text( //Get the Users Name
                snapshot.data[0]!.name,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
            ),
            //SizedBox(height: 1),
            Text( //Get the Users Tags
            snapshot.data[0]!.tags.toString(),
            style: TextStyle(fontSize: 10, height: 1),
            textAlign: TextAlign.center
            )
          ]
        )
        )
      );
  }

  Widget buildYesNo(BuildContext context) {
    return Container(
      height: 126,
      width: 103,
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.black45,
                ),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.lightGreenAccent,
              ),
                height: 55,
                width: 90,
                child: Icon(Icons.arrow_upward)
            ),
            Container(
                margin: EdgeInsets.only(right: 6),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.black45,
                  ),
                  borderRadius: BorderRadius.circular(11.0),
                  color: Colors.red,
                ),
                height: 55,
                width: 90,
                child: Icon(Icons.arrow_downward)

            )
          ]
        )
    );
  }
}




/*return Scaffold(
body: Column(
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
SafeArea(
child: Padding(
padding: const EdgeInsets.only(
left: 16, right: 16, top: 10, bottom: 10),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: const <Widget>[
Text(
"Explore",
style:
TextStyle(
fontSize: 32, fontWeight: FontWeight.bold),
),
],
),
),
),
Padding(
padding: const EdgeInsets.only(bottom: 10),
child: Expanded(child: buildUserBanner(context)),
),
buildUserBanner(context),
]),
);*/