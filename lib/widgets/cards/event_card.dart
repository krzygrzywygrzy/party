import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:party/core/failure.dart';
import 'package:party/models/event.dart';
import 'package:party/pages/event/event.dart';
import 'package:party/services/image_service.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    Key? key,
    required Event event,
  })  : _event = event,
        super(key: key);

  final Event _event;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 32.0;

    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => EventPage(event: _event))),
      child: SizedBox(
        height: 150.0,
        width: width,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 0,
              child: Material(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                elevation: 2,
                child: SizedBox(
                  width: (width) * 0.8,
                  height: 140.0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                      right: 8.0,
                      left: 52.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          _event.title,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _event.description ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Material(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                elevation: 2,
                child: Hero(
                  tag: "event_" + _event.title,
                  child: SizedBox(
                    height: 140.0,
                    width: width * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: FutureBuilder(
                        future:
                            ImageService.getImagesUrls(_event.photoLinks ?? []),
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
                                : Image.network('$url', fit: BoxFit.cover);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
