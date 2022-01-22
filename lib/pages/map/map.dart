import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:party/core/map_results.dart';
import 'package:party/services/map_services.dart';
import 'package:party/widgets/cards/place_card.dart';
import 'package:party/widgets/input/button.dart';
import 'package:party/widgets/input/elevated_card.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({
    Key? key,
    void Function(PlacesSearchResult place)? setPlace,
    PlacesSearchResult? initialPlace,
  })  : _setPlace = setPlace,
        _initialPlace = initialPlace,
        super(key: key);

  static const String path = "/map";
  final void Function(PlacesSearchResult place)? _setPlace;
  final PlacesSearchResult? _initialPlace;

  @override
  ConsumerState createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  final _phraseController = TextEditingController();
  PlacesSearchResult? _selectedPlace;

  late GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  final LatLng _startPosition = const LatLng(50.0614, 19.9383);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // if (widget._initialPlace != null) {
    //   setMarker(widget._initialPlace!);
    // }
    super.initState();
  }

  @override
  void dispose() {
    _phraseController.dispose();
    super.dispose();
  }

  void setMarker(PlacesSearchResult place) {
    var location = place.geometry!.location;
    LatLng latLng = LatLng(location.lat, location.lng);

    //set marker
    setState(() {
      _markers.clear();

      Marker marker = Marker(
        position: latLng,
        markerId: MarkerId(place.name),
        infoWindow: InfoWindow(
          title: place.name,
          snippet: place.formattedAddress ?? "",
        ),
      );

      _markers[place.name] = marker;
    });

    //animate to position
    var newPosition = CameraPosition(
      target: LatLng(location.lat, location.lng),
      zoom: 15.0,
    );

    CameraUpdate update = CameraUpdate.newCameraPosition(newPosition);

    mapController.animateCamera(update);
  }

  MapResult? _result;
  Future<void> handleSearch(String phrase) async {
    setState(() {
      _result = MapResultLoading();
    });

    var res = await MapService.findAddress(phrase);
    res.fold((l) {
      setState(() {
        _result = MapResultFailure();
      });
    }, (r) {
      setState(() {
        _result = MapResultSuccess(places: r);
      });
    });
  }

  Widget showResults() {
    Widget layout = Container();

    if (_result is MapResultFailure) {
      layout = const Expanded(
        child: ElevatedCard(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Error occurred...",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else if (_result is MapResultLoading) {
      layout = const Expanded(
        child: ElevatedCard(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Loading...",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else if (_result is MapResultSuccess) {
      //results operations
      var places = (_result as MapResultSuccess).places;
      if (places.length > 4) {
        places.removeRange(4, places.length);
      }

      //layout operations
      if (places.isNotEmpty) {
        List<Widget> children = [];
        for (var place in places) {
          children.add(
            GestureDetector(
              onTap: () {
                if (place.geometry != null) {
                  setMarker(place);
                }
                setState(() {
                  _selectedPlace = place;
                  _result = null;
                  _phraseController.text =
                      "${place.name}${place.formattedAddress != null ? "," : ""} ${place.formattedAddress ?? ""}";
                });
              },
              child: PlaceCard(
                name: place.name,
                address: place.formattedAddress,
              ),
            ),
          );
        }
        layout = Expanded(
          child: ElevatedCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        );
      } else {
        layout = const Expanded(
          child: ElevatedCard(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Nothing was found...",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }
    }

    return Row(
      children: [
        layout,
      ],
    );
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
              target: widget._initialPlace == null
                  ? _startPosition
                  : LatLng(widget._initialPlace!.geometry!.location.lat,
                      widget._initialPlace!.geometry!.location.lng),
              zoom: widget._initialPlace == null ? 11.0 : 15.0,
            ),
            markers: _markers.values.toSet(),
          ),
          _selectedPlace != null
              ? Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Button(
                        label: "Select",
                        onClick: () {
                          if (widget._setPlace != null &&
                              _selectedPlace != null) {
                            widget._setPlace!(_selectedPlace!);
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                )
              : Container(),
          Positioned(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedCard(
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
                                hintText: "search...",
                                hintStyle: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: GestureDetector(
                          onTap: () => handleSearch(_phraseController.text),
                          child: const SizedBox(
                            child: ElevatedCard(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  showResults(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
