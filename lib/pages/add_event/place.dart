import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/pages/map/map.dart';
import 'package:party/providers/add_event_provider.dart';
import 'package:party/widgets/input/elevated_card.dart';

class PlaceSelect extends ConsumerWidget {
  const PlaceSelect({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(addEventProvider).event;
    return Row(
      children: [
        Expanded(
          child: ElevatedCard(
            onClick: () => Navigator.pushNamed(
              context,
              MapPage.path,
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
                      event.place == null
                          ? "Select place"
                          : "${event.place!.name}, ${event.place!.formattedAddress ?? ""}",
                      overflow: TextOverflow.ellipsis,
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
