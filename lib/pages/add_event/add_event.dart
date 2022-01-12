import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/core/failure.dart';
import 'package:party/models/event.dart';
import 'package:party/pages/account/account.dart';
import 'package:party/services/event_service.dart';
import 'package:party/widgets/input/button.dart';
import 'package:party/widgets/input/custom_text_field.dart';
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

  bool _loading = false;
  String? message;
  Future<void> addEvent() async {
    setState(() {
      _loading = true;
    });

    FirebaseAuth.instance.currentUser!.uid;

    var res = await EventService.addEvent(Event(
      title: _titleController.text,
      invitationNeeded: _invitationNeeded,
      description: _descriptionController.text,
      organizerUID: FirebaseAuth.instance.currentUser!.uid,
    ));

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
    }, (r) {
      //TODO: go to event page or sth
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 32.0,
            ),
            child: Stack(
              children: [
                Column(
                  children: [
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
                    )
                  ],
                ),
                Positioned(
                  bottom: 0,
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
