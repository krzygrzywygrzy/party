import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/core/failure.dart';
import 'package:party/models/event.dart';
import 'package:party/providers/home_provider.dart';

class HomeEvents extends ConsumerWidget {
  const HomeEvents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeData = ref.watch(homeProvider);

    if (homeData.loading) {
      return const Expanded(
        child: Center(
          child: Text("Loading..."),
        ),
      );
    } else if (homeData.failure != null) {
      String? message;

      //check why cannot do:
      //homeData.failure.message
      var failure = homeData.failure;
      if (failure is FirestoreFailure) {
        message = failure.message;
      }

      return Expanded(
        child: Center(
          child: Text(message ?? "Unknown error occurred"),
        ),
      );
    } else {
      return buildEvents(homeData.events!);
    }
  }

  Widget buildEvents(List<Event> events) {
    return Container();
  }
}
