import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/core/error.dart';
import 'package:party/core/failure.dart';
import 'package:party/models/event.dart';
import 'package:party/models/place.dart';
import 'package:party/services/event_service.dart';
import 'package:party/services/image_service.dart';

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
              organizerUID: FirebaseAuth.instance.currentUser!.uid,
            ),
          ),
        );

  final ImageService imageService = ImageService();

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
    var newEvent = state.event;
    newEvent.invitationNeeded = inv;
    state = AddEvent(loading: false, event: newEvent);
  }

  void setStartDate(DateTime date) {
    var newEvent = state.event;
    newEvent.startDate = date;
    state = AddEvent(loading: false, event: newEvent);
  }

  void setStartTime(TimeOfDay time) {
    var newEvent = state.event;
    newEvent.startTime = time;
    state = AddEvent(loading: false, event: newEvent);
  }

  void setPlace(Place place) {
    var newEvent = state.event;
    newEvent.place = place;
    state = AddEvent(loading: false, event: newEvent);
  }

  Future<void> addEvent() async {
    state = AddEvent(
      loading: true,
      event: state.event,
    );

    try {
      var imageUpload = await imageService.uploadImages();

      imageUpload.fold(
          (_) => throw ImageUploadError(), (r) => state.event.photoLinks = r);

      var addEvent = await EventService.addEvent(state.event);
      addEvent.fold(
        (l) => state = AddEvent(
          loading: false,
          event: state.event,
          failure: l,
        ),
        (r) {
          state = AddEvent(
            loading: false,
            event: Event(
              invitationNeeded: false,
              title: "",
              startDate: DateTime.now(),
              startTime: TimeOfDay.now(),
              organizerUID: FirebaseAuth.instance.currentUser!.uid,
            ),
          );
        },
      );
    } on ImageUploadError {
      state = AddEvent(
          loading: false, event: state.event, failure: ImageUploadFailure());
    } catch (_) {
      state = AddEvent(
          loading: false, event: state.event, failure: UnknownFailure());
    }
  }
}

final addEventProvider = StateNotifierProvider<AddEventProvider, AddEvent>(
    (ref) => AddEventProvider());
