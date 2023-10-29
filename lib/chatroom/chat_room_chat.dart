import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_basic_chat_bubble/flutter_basic_chat_bubble.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/utils/firebase.dart';
import 'package:social_media_app/widgets/indicators.dart';

class ChatroomChat extends StatefulWidget {
  final room_name;
  const ChatroomChat({super.key, required this.room_name});

  @override
  State<ChatroomChat> createState() => _ChatroomChatState();
}

class _ChatroomChatState extends State<ChatroomChat> {
  TextEditingController _textEditingController = TextEditingController();
  var _userid;
  UserModel? user;
  Future<dynamic> userdetails() async {
    _userid = firebaseAuth.currentUser!.uid;
    var snapshot = await usersRef.doc(_userid).get();
    user = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return user;
  }

  CollectionReference _colref =
      FirebaseFirestore.instance.collection('chatrooms');
  Future<DocumentSnapshot> getData() async {
    userdetails();
    final Query_data = await _colref
        .doc(widget.room_name
            .toString()
            .trim()
            .replaceAll(' ', '')
            .toLowerCase())
        .get();
    return Query_data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.room_name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StreamBuilder<Object>(
              stream: _colref.snapshots(),
              builder: (context, snapshot) {
                return FutureBuilder<DocumentSnapshot>(
                  future: getData(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return circularProgress(context);
                    } else {
                      List reversed =
                          snapshot.data!.get('data').reversed.toList();

                      return Expanded(
                        child: ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: reversed.length,
                          itemBuilder: (context, index) {
                            if (reversed[index]['uid'] == _userid) {
                              return BasicChatBubble(
                                isMe: true,
                                message: BasicChatMessage(
                                  messageText: reversed[index]['message'],
                                  peerUserName: reversed[index]['name'],
                                  // timeStamp: reversed[index]s.toString(),
                                ),
                              );
                              // return BubbleSpecialOne(
                              //   text: reversed[jindex]['message'],
                              //   tail: true,
                              //   color: Theme.of(context).colorScheme.primary,
                              //   textStyle: TextStyle(color: Colors.white),
                              //   isSender: true,
                              // );
                            } else if (reversed[index]['uid'] != _userid) {
                              return BasicChatBubble(
                                backgroundColor:
                                    const Color.fromARGB(255, 247, 247, 247),
                                textColor: Colors.black,
                                isMe: false,
                                message: BasicChatMessage(
                                    messageText: reversed[index]['message'],
                                    peerUserName: reversed[index]['name']),
                              );
                            }
                          },
                        ),
                      );
                    }
                  },
                );
              }),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _textEditingController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                      onTap: () async {
                        await _colref
                            .doc(widget.room_name
                                .toString()
                                .trim()
                                .replaceAll(' ', '')
                                .toLowerCase())
                            .update({
                          'data': FieldValue.arrayUnion([
                            {
                              'name': user!.username.toString(),
                              'uid': _userid,
                              'time': Timestamp.now(),
                              'message': _textEditingController.text.toString()
                            }
                          ])
                        });
                        _textEditingController.clear();
                      },
                      child: Icon(Icons.send)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          )
        ],
      ),
    );
  }
}
