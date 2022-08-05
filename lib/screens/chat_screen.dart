import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
              "chats/ESW4Hpp5tGKGXrcd1qRN/messages",
            )
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          return streamSnapshot.connectionState == ConnectionState.waiting
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: streamSnapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(streamSnapshot.data?.docs[index]['text']),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection(
            "chats/ESW4Hpp5tGKGXrcd1qRN/messages",
          )
              .add(
            {
              'text': 'A new text!!!',
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
