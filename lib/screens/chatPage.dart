import 'package:flutter/material.dart';
import '../models/chatUsersModel.dart';
import '../widgets/conversationList.dart';
import '../main.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  Future<List> getMessages() async {
    List<ChatUsers> friends = [];
    List usersFriendsId = await db.getConnections(localUserId);
    for (var friend in usersFriendsId) {
      try {
        var tempFriend = await db.getUsers(friend['userid2']);
        var tempMessage = await db.getMostRecentMessage(
            localUserId, friend['userid2']);
        friends.add(ChatUsers(
            userId: tempFriend[0]['userid'],
            name: tempFriend[0]['fname'] + " " + tempFriend[0]['lname'],
            messageText: tempMessage?['text'] ?? "Start a conversation!",
            imageURL: "https://randomuser.me/api/portraits/men/5.jpg",
            lastTime: tempMessage?['time_sent'] ?? DateTime.now()));
      } catch (e) {
        print("Chat Page getMessages(): " + e.toString());
      }
    }

    friends.sort((a, b) => a.lastTime.compareTo(b.lastTime));
    return friends;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMessages(),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text("Conversations", style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(Icons.search, color: Colors.grey
                              .shade600,
                            size: 20,),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: EdgeInsets.all(8),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade100
                              )
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 16),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ConversationList(
                          name: snapshot.data![index].name,
                          messageText: snapshot.data![index].messageText,
                          imageUrl: snapshot.data![index].imageURL,
                          time: DateFormat('MMMd').format(snapshot.data![index]
                              .lastTime),
                          friendUserId: snapshot.data![index].userId,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        }
    );
  }
}
