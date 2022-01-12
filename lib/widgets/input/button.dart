import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required String label,
    void Function()? onClick,
  })  : _label = label,
        _onClick = onClick,
        super(key: key);

  final String _label;
  final void Function()? _onClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: _onClick,
          child: Text(
            _label,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
