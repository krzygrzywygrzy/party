import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Button(
                    label: "Add",
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
