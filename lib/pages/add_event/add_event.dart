import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/widgets/input/custom_text_field.dart';
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
  bool _invitationNeeded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                    caption: "Private",
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
                    caption: "Public",
                    selected: _invitationNeeded == false,
                    onTap: () {
                      setState(() {
                        _invitationNeeded = false;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
