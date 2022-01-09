class Event {
  Event({
    this.id,
    required this.title,
    required this.invitationNeeded,
    this.description,
    required this.organizerUID,
  });

  final String? id;
  final String title;
  final bool invitationNeeded;
  final String? description;
  final String organizerUID;

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json["title"],
      invitationNeeded: json["invitationNeeded"],
      description: json["description"],
      organizerUID: json["organizerUID"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "invitationNeeded": invitationNeeded,
      "description": description,
      "organizerUID": organizerUID,
    };
  }
}
