import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/core/failure.dart';
import 'package:party/models/event.dart';
import 'package:party/models/user.dart' as model;
import 'package:party/pages/account/account.dart';
import 'package:party/pages/chat/chat.dart';
import 'package:party/providers/user_provider.dart' as provider;
import 'package:party/services/auth_service.dart';
import 'package:party/services/event_service.dart';
import 'package:party/services/image_service.dart';
import 'package:party/widgets/input/button.dart';
import 'package:party/widgets/input/elevated_card.dart';
import 'package:party/widgets/layout/user_card.dart';
import 'package:party/widgets/layout/user_skeleteon.dart';

class EventPage extends ConsumerStatefulWidget {
  EventPage({
    Key? key,
    required Event event,
  })  : _event = event,
        super(key: key);

  Event _event;

  @override
  ConsumerState createState() => _EventPageState();
}

class _EventPageState extends ConsumerState<EventPage> {
  bool _loggedIn = false;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          _loggedIn = false;
        });
      } else {
        setState(() {
          _loggedIn = true;
        });
      }
    });
    super.initState();
  }

  Widget buildBottomButton() {
    if (!_loggedIn) {
      return Positioned(
        bottom: 16,
        left: 16,
        right: 16,
        child: Button(
          label: "To join event, sign up!",
          onClick: () => Navigator.pushNamed(context, Account.path),
        ),
      );
    } else if (widget._event.members!
        .contains(FirebaseAuth.instance.currentUser!.uid)) {
      return Positioned(
        bottom: 16,
        right: 16,
        child: FloatingActionButton(
          backgroundColor: Colors.amber,
          child: const Icon(Icons.message_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Chat(
                  chatId: widget._event.id ?? "",
                  title: widget._event.title,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Positioned(
        bottom: 16,
        left: 16,
        right: 16,
        child: Button(
          label: _loading ? "Loading..." : "Join event",
          onClick: joinEvent,
        ),
      );
    }
  }

  bool _loading = false;
  Future<void> joinEvent() async {
    setState(() {
      _loading = true;
    });

    var res = await EventService.joinEvent(
      FirebaseAuth.instance.currentUser!.uid,
      widget._event.id!,
      ref.read(provider.userProvider).user?.joinedEvents ?? [],
      widget._event.members ?? [],
    );

    res.fold((l) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Could not join event. Try again later")));
    }, (p) {
      ref
          .read(provider.userProvider.notifier)
          .updateEventList(widget._event.id!);
      setState(() {
        widget._event.members!.add(FirebaseAuth.instance.currentUser!.uid);
      });
    });

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: "event_" + widget._event.title,
                child: Material(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  elevation: 2,
                  child: SizedBox(
                    height: width,
                    width: width,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          child: FutureBuilder(
                            future: ImageService.getImagesUrls(
                                widget._event.photoLinks ?? []),
                            builder: (context,
                                AsyncSnapshot<Either<Failure, List<String>>>
                                    snapshot) {
                              var placeholder = Image.network(
                                "https://www.skokipolska.pl/wp-content/uploads/2020/09/placeholder.png",
                                fit: BoxFit.cover,
                              );
                              if (!snapshot.hasData) {
                                return placeholder;
                              } else {
                                String? url;
                                snapshot.data!.fold((l) => url = null, (r) {
                                  r.isNotEmpty ? url = r.first : url = null;
                                });
                                return url == null
                                    ? placeholder
                                    : Image.network(
                                        '$url',
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      );
                              }
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 16.0,
                          left: 16.0,
                          child: Text(
                            widget._event.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget._event.description ?? "",
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    FutureBuilder(
                      future: AuthService.getUser(widget._event.organizerUID),
                      builder: (
                        context,
                        AsyncSnapshot<Either<Failure, model.User>> snapshot,
                      ) {
                        Widget layout = const UserSkeleton();
                        if (snapshot.hasData) {
                          snapshot.data!.fold(
                              (l) => {},
                              (r) => {
                                    layout = Column(
                                      children: [
                                        const Text(
                                          "organized by:",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        const SizedBox(
                                          height: 4.0,
                                        ),
                                        UserCard(
                                          user: r,
                                        ),
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                  });
                        }
                        return layout;
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.date_range),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Text(
                              "${widget._event.startDate.day}.${widget._event.startDate.month}.${widget._event.startDate.year} ${widget._event.startTime.hour}:${widget._event.startTime.minute}"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    widget._event.place != null
                        ? Row(
                            children: [
                              Expanded(
                                child: ElevatedCard(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.place,
                                        ),
                                        const SizedBox(
                                          width: 12.0,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${widget._event.place!.name}, ${widget._event.place!.formattedAddress ?? ""}",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
          buildBottomButton(),
        ],
      ),
    );
  }
}
