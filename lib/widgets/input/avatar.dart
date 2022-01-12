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
        backgroundImage: const NetworkImage(
            "https://pbs.twimg.com/profile_images/1143988936177528832/gyyq5Ub6_400x400.jpg"),
        child: _child,
      ),
    );
  }
}
