import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.hint,
    this.obscure,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hint;
  final bool? obscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure ?? false,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hint,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 3,
          ),
        ),
      ),
    );
  }
}
