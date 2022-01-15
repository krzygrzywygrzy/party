import 'package:flutter/material.dart';
import 'package:party/models/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required User user,
  })  : _user = user,
        super(key: key);

  final User _user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.black12,
          radius: 16.0,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text("${_user.name} ${_user.surname}"),
      ],
    );
  }
}
