import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/core/failure.dart';
import 'package:party/models/event.dart';
import 'package:party/providers/home_provider.dart';
import 'package:party/widgets/cards/event_card.dart';

class HomeEvents extends ConsumerWidget {
  const HomeEvents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeData = ref.watch(homeProvider);

    if (homeData.loading) {
      return const Center(
        child: Text("Loading..."),
      );
    } else if (homeData.failure != null) {
      String? message;

      //check why cannot do:
      //homeData.failure.message
      var failure = homeData.failure;
      if (failure is FirestoreFailure) {
        message = failure.message;
      }

      return Center(
        child: Text(message ?? "Unknown error occurred"),
      );
    } else {
      return buildEvents(homeData.events!);
    }
  }

  Widget buildEvents(List<Event> events) {
    if (events.isEmpty) {
      return const Center(
        child: Text("There are no events in your near area!"),
      );
    }
    List<Widget> children = [];
    for (Event event in events) {
      children.add(EventCard(event: event));
      children.add(const SizedBox(
        height: 16.0,
      ));
    }

    return Column(
      children: children,
    );
  }
}
