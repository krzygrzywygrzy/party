import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

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
  final String title;
  final bool invitationNeeded;
  final String? description;
  final String organizerUID;
  final DateTime startDate;
  final TimeOfDay startTime;
  final PlacesSearchResult? place;

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
      place: json["place"],
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
      "place": place?.toJson(),
    };
  }
}
