import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/providers/add_event_provider.dart';
import 'package:party/widgets/input/elevated_card.dart';

class DateAndTime extends ConsumerWidget {
  const DateAndTime({Key? key}) : super(key: key);

  void pickEventDate(WidgetRef ref, BuildContext context) async {
    var newDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light().copyWith(
            primary: Colors.grey,
          )),
          child: child ?? Container(),
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (newDate != null) {
      ref.read(addEventProvider.notifier).setStartDate(newDate);
    }
  }

  void pickEventTime(WidgetRef ref, BuildContext context) async {
    var newTime = await showTimePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light().copyWith(
            primary: Colors.grey,
          )),
          child: child ?? Container(),
        );
      },
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null) {
      ref.read(addEventProvider.notifier).setStartTime(newTime);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(addEventProvider).event;
    return Row(
      children: [
        Expanded(
          child: ElevatedCard(
            height: 80.0,
            onClick: () => pickEventDate(ref, context),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.date_range,
                      size: 24.0,
                    ),
                    Text(
                      "${event.startDate.day}.${event.startDate.month}.${event.startDate.year}",
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
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
            onClick: () => pickEventTime(ref, context),
            height: 80.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.timer,
                    size: 24.0,
                  ),
                  Text(
                    "${event.startTime.hour}:${event.startTime.minute}",
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
