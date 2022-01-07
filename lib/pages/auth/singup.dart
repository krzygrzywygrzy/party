import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/core/failure.dart';
import 'package:party/pages/home/home.dart';
import 'package:party/services/auth_service.dart';
import 'package:party/widgets/input/button.dart';
import 'package:party/widgets/input/custom_text_field.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({
    Key? key,
  }) : super(key: key);

  static const String path = "/signup";

  @override
  ConsumerState createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  String? message;
  Future<void> performSignUp() async {
    setState(() {
      _loading = true;
    });

    var res = await AuthService.signUp(
      _emailController.text,
      _passwordController.text,
    );

    res.fold((l) {
      if (l is SignUpFailure) {
        setState(() {
          message = l.message;
        });
      } else {
        setState(() {
          message = "Unknown error occurred";
        });
      }
    },
        (r) => Navigator.of(context).pushNamedAndRemoveUntil(
            Home.path, (Route<dynamic> route) => false));

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text(
                    "Sign Up to Party",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              CustomTextField(
                controller: _emailController,
                hint: "email...",
              ),
              CustomTextField(
                controller: _passwordController,
                hint: "password...",
                obscure: true,
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button(
                    label: _loading ? "Loading..." : "Sign up",
                    onClick: performSignUp,
                  )
                ],
              ),
              Text(message ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
