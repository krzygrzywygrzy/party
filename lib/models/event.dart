class Event {
  Event({
    required this.title,
    required this.invitationNeeded,
    this.description,
  });

  final String title;
  bool invitationNeeded;
  final String? description;

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json["title"],
      invitationNeeded: json["invitationNeeded"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "invitationNeeded": invitationNeeded,
      "description": description,
    };
  }
}
