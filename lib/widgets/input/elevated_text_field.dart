import 'package:flutter/material.dart';

class ElevatedTextField extends StatelessWidget {
  const ElevatedTextField({
    Key? key,
    required TextEditingController controller,
    String? hint,
  })  : _controller = controller,
        _hint = hint,
        super(key: key);

  final TextEditingController _controller;
  final String? _hint;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextField(
          style: const TextStyle(
            fontSize: 14.0,
          ),
          maxLines: 6,
          cursorColor: Colors.black,
          controller: _controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: _hint,
            hintStyle: const TextStyle(fontSize: 14.0),
          ),
        ),
      ),
    );
  }
}
