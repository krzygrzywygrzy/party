import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/core/failure.dart';
import 'package:party/models/event.dart';
import 'package:party/models/place.dart';

class AddEvent {
  AddEvent({
    required this.loading,
    this.failure,
    required this.event,
  });
  final bool loading;
  final Failure? failure;
  final Event event;
}

class AddEventProvider extends StateNotifier<AddEvent> {
  AddEventProvider()
      : super(
          AddEvent(
            loading: false,
            event: Event(
              invitationNeeded: false,
              title: "",
              startDate: DateTime.now(),
              startTime: TimeOfDay.now(),
              organizerUID: "",
            ),
          ),
        );

  void setTitle(String title) {
    var newState = state;
    newState.event.title = title;
    state = newState;
  }

  void setDescription(String description) {
    var newState = state;
    newState.event.description = description;
    state = newState;
  }

  void setInvitationNeeded(bool inv) {
    var newState = state;
    newState.event.invitationNeeded = inv;
    state = newState;
  }

  void setStartDate(DateTime date) {
    var newState = state;
    newState.event.startDate = date;
    state = newState;
  }

  void setStartTime(TimeOfDay time) {
    var newState = state;
    newState.event.startTime = time;
    state = newState;
  }

  void setPlace(Place place) {
    var newState = state;
    newState.event.place = place;
    state = newState;
  }

  Future<void> addEvent() async {
    print(state.event.toJson());
  }
}

final addEventProvider = StateNotifierProvider<AddEventProvider, AddEvent>(
    (ref) => AddEventProvider());
