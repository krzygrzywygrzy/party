import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/core/failure.dart';
import 'package:party/models/message.dart';
import 'package:party/services/chat_service.dart';

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
  late ChatService _chatService;
  final _messageController = TextEditingController();

  @override
  void initState() {
    _chat =
        FirebaseFirestore.instance.collection("events/${widget._chatId}/chat");
    _chatService = ChatService(widget._chatId);
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future sendMessage(Message message) async {
    var res = await _chatService.sendMessage(message);
    res.fold((l) {
      String message = "";
      if (l is FirestoreFailure) {
        message = l.message ?? "";
      } else if (l is UnknownFailure) {
        message = "Unknown error occurred";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }, (r) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder(
              stream: _chat.snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                Widget layout = Container();
                if (snapshot.hasError) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Could not load messages!")));
                }
                if (snapshot.hasData) {
                  //TODO:
                  print(snapshot.data.toString());
                }
                return layout;
              },
            ),
            Material(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: "type sth...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: GestureDetector(
                        child: const Icon(
                          Icons.send,
                          color: Colors.amber,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return Container();
  }
}
