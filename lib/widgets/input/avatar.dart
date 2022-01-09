import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    this.onClick,
    this.child,
  }) : super(key: key);

  final void Function()? onClick;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: CircleAvatar(
        backgroundImage: const NetworkImage(
            "https://pbs.twimg.com/profile_images/1143988936177528832/gyyq5Ub6_400x400.jpg"),
        child: child,
      ),
    );
  }
}
