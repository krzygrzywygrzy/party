import 'package:flutter/material.dart';
import 'package:party/models/place.dart';

class Event {
  Event({
    this.id,
    required this.title,
    required this.invitationNeeded,
    this.description,
    required this.organizerUID,
    required this.startDate,
    required this.startTime,
    this.place,
  });

  final String? id;
  String title;
  bool invitationNeeded;
  String? description;
  String organizerUID;
  DateTime startDate;
  TimeOfDay startTime;
  Place? place;

  //TIME OF DAY WON'T BE AUTOMATICALLY CONVERTED TO JSON BY JSON_ANNOTATION
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json["title"],
      invitationNeeded: json["invitationNeeded"],
      description: json["description"],
      organizerUID: json["organizerUID"],
      id: json["id"],
      startTime: TimeOfDay(
        minute: json["minute"],
        hour: json["hour"],
      ),
      startDate: DateTime.parse(json["startDate"]),
      place: Place.fromJson(json["place"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "invitationNeeded": invitationNeeded,
      "description": description,
      "organizerUID": organizerUID,
      "startDate": startDate.toIso8601String(),
      "minute": startTime.minute,
      "hour": startTime.hour,
      "place": place != null ? place!.toJson() : null,
    };
  }
}
