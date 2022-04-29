import 'package:flutter/material.dart';

import 'navBar.dart';

class ExplorePage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        SafeArea (
          child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  "Explore",
                  style: TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
          Container(
            constraints: BoxConstraints.expand(
              height: 400,
            ),
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
            //decoration: BoxDecoration(color: Colors.grey),
            child: Image.asset("lib/images/ian-dooley-d1UPkiFd04A-unsplash.jpg"
                , fit: BoxFit.cover)

            ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Text("Brad"),
          )
          ]
          ),
          /*Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 18),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  "Explore",
                  style: TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),


        )*/

      );

  }
}