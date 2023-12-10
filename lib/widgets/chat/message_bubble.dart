import 'package:chat_app/models/message.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  late final isMessageFromCurrentUser =
      message.userId == auth.FirebaseAuth.instance.currentUser!.uid;

  MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Align(
          alignment: isMessageFromCurrentUser
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            margin: const EdgeInsets.symmetric(vertical: 16
            , horizontal: 16),
            decoration: BoxDecoration(
              color: isMessageFromCurrentUser
                  ? Colors.grey.shade300
                  : theme.colorScheme.secondary,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: !isMessageFromCurrentUser
                    ? const Radius.circular(0)
                    : const Radius.circular(16),
                bottomRight: isMessageFromCurrentUser
                    ? const Radius.circular(0)
                    : const Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: isMessageFromCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  message.username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMessageFromCurrentUser
                        ? Colors.black
                        : theme.textTheme.headline1!.color,
                  ),
                ),
                Text(
                  message.text,
                  textAlign: isMessageFromCurrentUser
                      ? TextAlign.end
                      : TextAlign.start,
                  style: TextStyle(
                    color: isMessageFromCurrentUser
                        ? Colors.black
                        : theme.textTheme.headline1!.color,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: isMessageFromCurrentUser ? null : 130,
          right: isMessageFromCurrentUser ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(message.userImageUrl),
          ),
        ),
      ],
    );
  }
}
