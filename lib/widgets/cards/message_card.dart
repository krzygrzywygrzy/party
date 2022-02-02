import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/models/message.dart';

class MessageCard extends ConsumerWidget {
  const MessageCard({
    Key? key,
    required Message message,
  })  : _message = message,
        super(key: key);

  final Message _message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isYours = _message.userId == FirebaseAuth.instance.currentUser?.uid;
    return Column(
      crossAxisAlignment:
          isYours ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Material(
          elevation: 2.0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          color: isYours ? Colors.amber : Colors.black12,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _message.content,
              style: TextStyle(
                color: isYours ? Colors.white : Colors.black12,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
