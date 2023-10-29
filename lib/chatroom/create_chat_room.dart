import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CreateChatRoom extends StatefulWidget {
  const CreateChatRoom({super.key});

  @override
  State<CreateChatRoom> createState() => _CreateChatRoomState();
}

class _CreateChatRoomState extends State<CreateChatRoom> {
  final _mkchatroom = FirebaseFirestore.instance.collection('chatrooms');
  final textController = TextEditingController();
  final uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Chat Room'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Enter Room Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                await _mkchatroom
                    .doc(textController.text
                        .toString()
                        .toLowerCase()
                        .trim()
                        .replaceAll(' ', ''))
                    .set({
                  'name': textController.text.toString(),
                });
                await _mkchatroom
                    .doc(textController.text
                        .toString()
                        .toLowerCase()
                        .trim()
                        .replaceAll(' ', ''))
                    .update({
                  'data':FieldValue.arrayUnion([]),
                });
                Navigator.pop(context);
              },
              child: Container(
                height: 45.0,
                width: 130.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Color(0xff597FDB),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    'Create Room',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
