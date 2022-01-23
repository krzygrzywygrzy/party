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
  Widget displayPhotos() {
    final imageService = ref.watch(addEventProvider.notifier).imageService;
    if (imageService.files.isEmpty) {
      return Container();
    } else {
      List<Widget> children = [];
      for (var image in imageService.files) {
        children.add(Padding(
          padding: const EdgeInsets.only(
            right: 16.0,
          ),
          child: Material(
            elevation: 4,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.file(image),
            ),
          ),
        ));
      }

      return SizedBox(
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: children,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final event = ref.read(addEventProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Button(
              label: "Select photo 💾",
              onClick: () async {
                await event.imageService.getImageFromGallery();
                setState(() {});
              },
            ),
            const SizedBox(
              width: 8.0,
            ),
            Button(
              label: "Take photo 📸",
              onClick: () async {
                await event.imageService.getImageFromCamera();
                setState(() {});
              },
            ),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        displayPhotos(),
      ],
    );
  }
}
