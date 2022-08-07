import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'message_bubble.dart';

class Messages extends StatelessWidget {
  Messages({Key? key}) : super(key: key);
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = chatSnapshot.data!.docs;
          return user != null
              ? ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (context, index) => MessageBubble(
                    chatDocs[index]['text'],
                    chatDocs[index]['username'],
                    chatDocs[index]['userId'] == user!.uid,
                    key: ValueKey(chatDocs[index].id),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
