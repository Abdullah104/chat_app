import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/message.dart';
import 'message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Message>>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('creation_time', descending: true)
          .withConverter<Message>(
            fromFirestore: (document, _) => Message.fromJson(document.data()!),
            toFirestore: (message, _) => message.toJson(),
          )
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final documents = snapshot.data!.docs;

          return ListView.builder(
            reverse: true,
            itemCount: documents.length,
            itemBuilder: (_, index) => MessageBubble(
              message: documents[index].data(),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
