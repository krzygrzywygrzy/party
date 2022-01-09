import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/core/failure.dart';
import 'package:party/models/event.dart';
import 'package:party/services/event_service.dart';

class Home {
  Home({
    required this.loading,
    this.failure,
    this.events,
  });

  final bool loading;
  final Failure? failure;
  final List<Event>? events;
}

class HomeProvider extends StateNotifier<Home> {
  HomeProvider() : super(Home(loading: false));

  load() async {
    state = Home(loading: true);

    var res = await EventService.getAllEvents();

    res.fold(
      (l) => state = Home(loading: false, failure: l),
      (r) => state = Home(loading: false, events: r),
    );
  }
}

final homeProvider =
    StateNotifierProvider<HomeProvider, Home>((ref) => HomeProvider());
