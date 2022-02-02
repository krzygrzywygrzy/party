import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/core/failure.dart';
import 'package:party/models/message.dart';
import 'package:party/providers/user_provider.dart';
import 'package:party/services/chat_service.dart';
import 'package:party/widgets/cards/message_card.dart';
import 'package:party/widgets/input/message_input.dart';

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
    }, (r) => _messageController.clear());
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
            Flexible(
              child: StreamBuilder(
                stream: _chat.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  Widget layout = Container();
                  if (snapshot.hasError) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Could not load messages!")));
                  }
                  if (snapshot.hasData) {
                    var docs = snapshot.data?.docs;
                    if (docs == null || docs.isEmpty) {
                      layout = const Center(
                        child: Text("There are no messages sent yet!"),
                      );
                    } else {
                      List<Message> messages = [];
                      for (var doc in docs) {
                        messages.add(Message.fromJson(
                            doc.data() as Map<String, dynamic>));
                      }

                      layout = Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            bool isYours = messages[index].userId ==
                                FirebaseAuth.instance.currentUser?.uid;
                            return Padding(
                              padding: index == 0
                                  ? const EdgeInsets.only(bottom: 8.0, top: 8.0)
                                  : const EdgeInsets.only(bottom: 8.0),
                              child: MessageCard(message: messages[index]),
                            );
                          },
                        ),
                      );
                    }
                  }
                  return layout;
                },
              ),
            ),
            MessageInput(
              messageController: _messageController,
              onClick: () {
                final user = ref.read(userProvider);
                sendMessage(
                  Message(
                    content: _messageController.text,
                    displayName: "${user.user!.name} ${user.user!.surname}",
                    userId: FirebaseAuth.instance.currentUser!.uid,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
