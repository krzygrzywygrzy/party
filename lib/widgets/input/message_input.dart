import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({
    Key? key,
    required TextEditingController messageController,
    void Function()? onClick,
  })  : _messageController = messageController,
        _onClick = onClick,
        super(key: key);

  final TextEditingController _messageController;
  final void Function()? _onClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
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
                  cursorColor: Colors.amber,
                  decoration: const InputDecoration(
                    hintText: "type sth...",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: GestureDetector(
                  onTap: _onClick,
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
    );
  }
}
