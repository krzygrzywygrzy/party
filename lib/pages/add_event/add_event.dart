import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:party/core/failure.dart';
import 'package:party/models/event.dart';
import 'package:party/pages/account/account.dart';
import 'package:party/pages/home/home.dart';
import 'package:party/pages/map/map.dart';
import 'package:party/services/event_service.dart';
import 'package:party/widgets/input/button.dart';
import 'package:party/widgets/input/custom_text_field.dart';
import 'package:party/widgets/input/elevated_card.dart';
import 'package:party/widgets/input/elevated_text_field.dart';
import 'package:party/widgets/input/selective_button.dart';

class AddEvent extends ConsumerStatefulWidget {
  const AddEvent({
    Key? key,
  }) : super(key: key);

  static const String path = "/add_event";

  @override
  ConsumerState createState() => _AddEventState();
}

class _AddEventState extends ConsumerState<AddEvent> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _invitationNeeded = false;
  DateTime _startDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  PlacesSearchResult? _place;

  @override
  void initState() {
    //if user is not logged in redirect to account page
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Account.path, (Route<dynamic> route) => false);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _loading = false;
  String? message;
  Future<void> addEvent() async {
    setState(() {
      _loading = true;
    });

    FirebaseAuth.instance.currentUser!.uid;

    var res = await EventService.addEvent(
      Event(
        title: _titleController.text,
        invitationNeeded: _invitationNeeded,
        description: _descriptionController.text,
        organizerUID: FirebaseAuth.instance.currentUser!.uid,
        startDate: _startDate,
        startTime: _startTime,
        place: _place,
      ),
    );

    setState(() {
      _loading = false;
    });

    res.fold((l) {
      if (l is FirestoreFailure) {
        setState(() {
          message = l.message;
        });
      } else {
        setState(() {
          message = "Unknown error occurred";
        });
      }
    },
        (r) => Navigator.of(context).pushNamedAndRemoveUntil(
            Home.path, (Route<dynamic> route) => false));
  }

  void pickEventDate() async {
    var newDate = await showDatePicker(
        context: context,
        initialDate: _startDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (newDate != null) {
      setState(() {
        _startDate = newDate;
      });
    }
  }

  void pickEventTime() async {
    var newTime =
        await showTimePicker(context: context, initialTime: _startTime);

    if (newTime != null) {
      setState(() {
        _startTime = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Stack(
              children: [
                ListView(
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "New event",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CustomTextField(
                      controller: _titleController,
                      hint: "title...",
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        SelectiveButton(
                          caption: "Private 🔒",
                          selected: _invitationNeeded == true,
                          onTap: () {
                            setState(() {
                              _invitationNeeded = true;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        SelectiveButton(
                          caption: "Public 👓",
                          selected: _invitationNeeded == false,
                          onTap: () {
                            setState(() {
                              _invitationNeeded = false;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    ElevatedTextField(
                      controller: _descriptionController,
                      hint: "description...",
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedCard(
                            height: 80.0,
                            onClick: pickEventDate,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${_startDate.day}.${_startDate.month}",
                                      style: const TextStyle(
                                        fontSize: 26.0,
                                      ),
                                    ),
                                    Text("${_startDate.year}"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: ElevatedCard(
                            onClick: pickEventTime,
                            height: 80.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "${_startTime.hour}:${_startTime.minute}",
                                  style: const TextStyle(
                                    fontSize: 30.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedCard(
                            onClick: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapPage(
                                  initialPlace: _place,
                                  setPlace: (place) {
                                    setState(() {
                                      _place = place;
                                    });
                                  },
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.place_sharp),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  Expanded(
                                    child: Text(
                                      _place == null
                                          ? "Select address"
                                          : "${_place!.name}, ${_place!.formattedAddress ?? ""}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 72.0,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 16.0,
                  left: 0,
                  right: 0,
                  child: Button(
                    onClick: addEvent,
                    label: _loading ? "Loading..." : "Add",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
