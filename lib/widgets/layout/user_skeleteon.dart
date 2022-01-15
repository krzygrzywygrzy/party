import 'package:flutter/material.dart';

class UserSkeleton extends StatelessWidget {
  const UserSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          backgroundColor: Colors.black12,
          radius: 16.0,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: 20.0,
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ],
    );
  }
}
