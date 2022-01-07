import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  Future<void> performSignUp() async {}

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
                children: const [Button(label: "Sign up")],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
