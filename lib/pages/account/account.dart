import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/pages/auth/signin.dart';
import 'package:party/pages/auth/singup.dart';
import 'package:party/widgets/input/button.dart';

class Account extends ConsumerStatefulWidget {
  const Account({
    Key? key,
  }) : super(key: key);

  static const String path = "/account";

  @override
  ConsumerState createState() => _AccountState();
}

class _AccountState extends ConsumerState<Account> {
  bool _loggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          _loggedIn = false;
        });
      } else {
        setState(() {
          _loggedIn = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _loggedIn
            ? Column()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "You are not currently signed up!",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        label: "Sign up",
                        onClick: () =>
                            Navigator.pushNamed(context, SignUp.path),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Button(
                        label: "Sign in",
                        onClick: () =>
                            Navigator.pushNamed(context, SignIn.path),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
