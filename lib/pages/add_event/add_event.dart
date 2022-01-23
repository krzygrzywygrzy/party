import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/pages/account/account.dart';
import 'package:party/pages/add_event/date_and_time.dart';
import 'package:party/pages/add_event/description.dart';
import 'package:party/pages/add_event/images.dart';
import 'package:party/pages/add_event/invitation_needed.dart';
import 'package:party/pages/add_event/place.dart';
import 'package:party/pages/add_event/title.dart' as party;
import 'package:party/providers/add_event_provider.dart';
import 'package:party/widgets/input/button.dart';

class AddEvent extends ConsumerStatefulWidget {
  const AddEvent({
    Key? key,
  }) : super(key: key);

  static const String path = "/add_event";

  @override
  ConsumerState createState() => _AddEventState();
}

class _AddEventState extends ConsumerState<AddEvent> {
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
  Widget build(BuildContext context) {
    final event = ref.watch(addEventProvider);
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
                    const party.Title(),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const InvitationNeeded(),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Description(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const DateAndTime(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const PlaceSelect(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Images(),
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
                    onClick: () {
                      ref.read(addEventProvider.notifier).addEvent();
                    },
                    label: event.loading ? "Loading..." : "Add",
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
