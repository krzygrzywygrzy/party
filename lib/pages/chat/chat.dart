import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/models/message.dart';

class Chat extends ConsumerStatefulWidget {
  const Chat({
    Key? key,
    required String chatId,
    required String title,
  })  : _chatId = chatId,
        _title = title,
        super(key: key);

  static const String path = "/chat";
  final String _chatId;
  final String _title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatState();
}

class _ChatState extends ConsumerState<Chat> {
  late CollectionReference _chat;

  _ChatState() {
    FirebaseFirestore.instance.collection("chats/${widget._chatId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: _chat.snapshots() as Stream<List<Message>?>,
          builder: (context, AsyncSnapshot<List<Message>?> snapshot) {
            Widget layout = Container();
            if (snapshot.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Could not load messages!")));
            }
            if (snapshot.hasData) {
              //TODO:
            }
            return layout;
          },
        ),
      ),
    );
  }
}
