import 'package:flutter/material.dart';

import '../database/database.dart';
import '../models/chatMessageModel.dart';


class ChatDetailPage extends StatefulWidget{
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  String localUserId = 'testing sender';
  String friendUserId = 'testing receiver';
  var db = MongoDatabase();
  final textController = TextEditingController();

   Future<List> getMessages() async {
    List<ChatMessage> messages = [];
    db.connect();
    List fromUser = await db.getMessages(localUserId, friendUserId);
    List toUser = await db.getMessages(friendUserId, localUserId);
    fromUser.forEach((message) => messages.add(ChatMessage(messageContent: message.text, messageType: 'sender', timeSent: message.time_sent)));
    toUser.forEach((message) => messages.add(ChatMessage(messageContent: message.text, messageType: 'receiver', timeSent: message.time_sent)));
    messages.sort((a, b) => a.timeSent.compareTo(b.timeSent));
    print(messages);
    return messages;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMessages(),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              flexibleSpace: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.black,),
                      ),
                      SizedBox(width: 2,),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://randomuser.me/api/portraits/men/5.jpg"),
                        maxRadius: 20,
                      ),
                      SizedBox(width: 12,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Kriss Benwat", style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                      const Icon(Icons.settings, color: Colors.black54,),
                    ],
                  ),
                ),
              ),
            ),
            body: Stack(
              children: <Widget>[
                ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (snapshot.data![index].messageType ==
                            "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (snapshot.data![index].messageType ==
                                "receiver"
                                ? Colors.grey.shade200
                                : Colors.blue[200]),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(snapshot.data![index].messageContent,
                            style: const TextStyle(fontSize: 15),),
                        ),
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.add, color: Colors.white, size: 20,),
                          ),
                        ),
                        const SizedBox(width: 15,),
                        Expanded(
                          child: TextField(
                            controller: textController,
                            decoration: const InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none
                            ),
                          ),
                        ),
                        const SizedBox(width: 15,),
                        FloatingActionButton(
                          onPressed: () {
                            db.insertMessage(
                                textController.text, localUserId,
                                friendUserId,
                                DateTime.now());
                          },
                          child: const Icon(Icons.send, color: Colors.white,
                            size: 18,),
                          backgroundColor: Colors.blue,
                          elevation: 0,
                        ),
                      ],

                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      }
    );
  }
}
