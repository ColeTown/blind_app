import 'package:flutter/material.dart';
import 'navBar.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  refresh() {
    setState(() {});
  }
  Future<List> getUserData() async {
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
                    children: <Widget>[
                      buildUserBanner(snapshot),
                      buildUserBanner(snapshot),
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
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      buildThumbnail(snapshot),
      buildUserBio(context),
      buildYesNo(context),
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
    radius: bannerHeight / 2,
    backgroundColor: Colors.white,
    child: CircleAvatar(
      backgroundImage: MemoryImage(snapshot.data[0]!.imageData, scale: 1),
      /*NetworkImage("https://placeimg.com/640/480/any",),*/
      radius: 65,
    ),
  );

  Widget buildUserBio(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: const Text('2'),
    );
  }

  Widget buildYesNo(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
      child: const Text('3'),
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