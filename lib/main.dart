import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/pages/account/account.dart';
import 'package:party/pages/add_event/add_event.dart';
import 'package:party/pages/auth/signin.dart';
import 'package:party/pages/auth/singup.dart';
import 'package:party/pages/home/home.dart';
import 'package:party/pages/map/map.dart';
import 'package:party/pages/welcome/welcome.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

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
      builder: (context, child) {
        return ScrollConfiguration(
            behavior: MyBehavior(), child: child ?? Container());
      },
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
        MapPage.path: (context) => const MapPage(),
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
