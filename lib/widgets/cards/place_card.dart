import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    Key? key,
    required String name,
    String? address,
  })  : _name = name,
        _address = address,
        super(key: key);

  final String _name;
  final String? _address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _name,
              style: const TextStyle(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            _address != null
                ? Text(
                    _address!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
