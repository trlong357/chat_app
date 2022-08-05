import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: Text('abc'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection(
                "chats/ESW4Hpp5tGKGXrcd1qRN/messages",
              )
              .snapshots()
              .listen((event) {
            event.docs.forEach((element) {
              print(element['text']);
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
