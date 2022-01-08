import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/pages/account/account.dart';
import 'package:party/pages/add_event/add_event.dart';
import 'package:party/pages/auth/signin.dart';
import 'package:party/pages/auth/singup.dart';
import 'package:party/pages/home/home.dart';
import 'package:party/pages/welcome/welcome.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Party',
      theme: ThemeData(
        fontFamily: "Nunito",
      ),
      initialRoute: Home.path,
      routes: {
        Welcome.path: (context) => const Welcome(),
        Home.path: (context) => const Home(),
        Account.path: (context) => const Account(),
        SignUp.path: (context) => const SignUp(),
        SignIn.path: (context) => const SignIn(),
        AddEvent.path: (context) => const AddEvent(),
      },
    );
  }
}
