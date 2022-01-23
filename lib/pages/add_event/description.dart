import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:flutter/material.dart";
import 'package:party/providers/add_event_provider.dart';
import 'package:party/widgets/input/elevated_text_field.dart';

class Description extends ConsumerStatefulWidget {
  const Description({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DescriptionState();
}

class _DescriptionState extends ConsumerState<Description> {
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _descriptionController.text =
        ref.read(addEventProvider).event.description ?? "";
    _descriptionController.addListener(() {
      ref
          .read(addEventProvider.notifier)
          .setDescription(_descriptionController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedTextField(
      controller: _descriptionController,
      hint: "description...",
    );
  }
}
