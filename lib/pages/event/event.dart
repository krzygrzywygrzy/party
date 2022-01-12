import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/models/event.dart';

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
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      body: Column(
        children: [
          Hero(
            tag: "event_" + widget._event.title,
            child: Material(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              elevation: 2,
              child: SizedBox(
                height: width,
                width: width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    "https://www.travelin.pl/galeria/sydney-opera-house.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
