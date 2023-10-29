import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/chatroom/chat_room_chat.dart';
import 'package:social_media_app/chatroom/create_chat_room.dart';
import 'package:social_media_app/widgets/indicators.dart';

class ChatromScreen extends StatefulWidget {
  const ChatromScreen({super.key});

  @override
  State<ChatromScreen> createState() => _ChatromScreenState();
}

class _ChatromScreenState extends State<ChatromScreen> {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('chatrooms');

  Future<List> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatrooms'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateChatRoom(),
                  ));
            },
            icon: Icon(Icons.add),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<Object>(
            stream: _collectionRef.snapshots(),
            builder: (context, snapshot) {
              return FutureBuilder(
                future: getData(),
                builder: (context, AsyncSnapshot<List> snapshot) {
                  if (!snapshot.hasData) {
                    print(snapshot);
                    return circularProgress(context);
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ChatroomChat(
                                            room_name: snapshot.data![index]['name']
                                                .toString());
                                      },
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        snapshot.data![index]['name'].toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    child: Icon(Icons.people),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              );
            }
          )
        ],
      ),
    );
  }
}
