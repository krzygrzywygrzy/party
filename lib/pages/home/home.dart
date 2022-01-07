import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/pages/account/account.dart';
import 'package:party/providers/home_provider.dart';
import 'package:party/widgets/input/avatar.dart';

class Home extends ConsumerStatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  static const String path = "/home";

  @override
  ConsumerState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    //ref.read(homeProvider.notifier).load();
  }

  @override
  Widget build(BuildContext context) {
    final homeData = ref.watch(homeProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Welcome!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Avatar(
                    onClick: () {
                      Navigator.pushNamed(context, Account.path);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
