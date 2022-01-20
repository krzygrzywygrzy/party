import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:party/widgets/input/button.dart';
import 'package:party/widgets/input/elevated_card.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({
    Key? key,
  }) : super(key: key);

  static const String path = "/map";

  @override
  ConsumerState createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  final _phraseController = TextEditingController();

  late GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    _phraseController.addListener(() {
      handleSearch(_phraseController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _phraseController.dispose();
    super.dispose();
  }

  Future<void> handleSearch(String phrase) async {
    print(phrase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    ElevatedCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: _phraseController,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "address...",
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Button(
                  label: "Select",
                  onClick: () {
                    //TODO: select place
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
