import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/models/event.dart';
import 'package:party/pages/account/account.dart';
import 'package:party/widgets/input/button.dart';

class EventPage extends ConsumerStatefulWidget {
  const EventPage({
    Key? key,
    required Event event,
  })  : _event = event,
        super(key: key);

  final Event _event;

  @override
  ConsumerState createState() => _EventPageState();
}

class _EventPageState extends ConsumerState<EventPage> {
  bool _loggedIn = false;

  @override
  void initState() {
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
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: "event_" + widget._event.title,
                child: Material(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  elevation: 2,
                  child: SizedBox(
                    height: width,
                    width: width,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            "https://cms.finnair.com/resource/blob/512102/9c27b858c9241ccc69ab7a418eb92d65/new-york-shopping-data.jpg?impolicy=crop&width=1697&height=955&x=0&y=88&imwidth=768",
                            fit: BoxFit.cover,
                            height: width,
                          ),
                        ),
                        Positioned(
                          bottom: 16.0,
                          left: 16.0,
                          child: Text(
                            widget._event.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget._event.description ?? "",
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _loggedIn
                  ? Button(
                      label: "Join event",
                      onClick: () {},
                    )
                  : Button(
                      label: "To join event, sign up!",
                      onClick: () => Navigator.pushNamed(context, Account.path),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
