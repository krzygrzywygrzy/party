import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.label,
    this.onClick,
  }) : super(key: key);

  final String label;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: onClick,
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
