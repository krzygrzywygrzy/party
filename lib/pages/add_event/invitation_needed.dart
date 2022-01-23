import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/providers/add_event_provider.dart';
import 'package:party/widgets/input/selective_button.dart';

class InvitationNeeded extends ConsumerWidget {
  const InvitationNeeded({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(addEventProvider).event;
    return Row(
      children: [
        SelectiveButton(
          caption: "Private 🔒",
          selected: event.invitationNeeded == true,
          onTap: () =>
              ref.read(addEventProvider.notifier).setInvitationNeeded(true),
        ),
        const SizedBox(
          width: 8.0,
        ),
        SelectiveButton(
          caption: "Public 👓",
          selected: event.invitationNeeded == false,
          onTap: () =>
              ref.read(addEventProvider.notifier).setInvitationNeeded(false),
        ),
      ],
    );
  }
}
