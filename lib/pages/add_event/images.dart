import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/providers/add_event_provider.dart';
import 'package:party/widgets/input/button.dart';

class Images extends ConsumerStatefulWidget {
  const Images({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ImagesState();
}

class _ImagesState extends ConsumerState<Images> {
  @override
  Widget build(BuildContext context) {
    final event = ref.read(addEventProvider.notifier);
    return Column(
      children: [
        Row(
          children: [
            Button(
              label: "Select photo 💾",
              onClick: () => event.imageService.getImageFromGallery(),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Button(
              label: "Take photo 📸",
              onClick: () => event.imageService.getImageFromCamera(),
            ),
          ],
        )
      ],
    );
  }
}
