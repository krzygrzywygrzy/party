import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    void Function()? onClick,
    Widget? child,
  })  : _onClick = onClick,
        _child = child,
        super(key: key);

  final void Function()? _onClick;
  final Widget? _child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onClick,
      child: CircleAvatar(
        backgroundColor: Colors.black12,
        child: _child,
      ),
    );
  }
}
