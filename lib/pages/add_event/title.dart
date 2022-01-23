import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/providers/add_event_provider.dart';
import 'package:party/widgets/input/custom_text_field.dart';

class Title extends ConsumerStatefulWidget {
  const Title({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TitleState();
}

class _TitleState extends ConsumerState<Title> {
  final _titleController = TextEditingController();

  @override
  void initState() {
    _titleController.text = ref.read(addEventProvider).event.title;
    _titleController.addListener(() {
      ref.read(addEventProvider.notifier).setTitle(_titleController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: _titleController,
      hint: "title...",
    );
  }
}
