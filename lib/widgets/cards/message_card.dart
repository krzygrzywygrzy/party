import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:flutter/material.dart";
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
    return Container();
  }
}
