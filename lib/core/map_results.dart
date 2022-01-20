import 'package:google_maps_webservice/places.dart';

abstract class MapResult {}

class MapResultFailure implements MapResult {}

class MapResultSuccess implements MapResult {
  MapResultSuccess({
    required this.places,
  });
  List<PlacesSearchResult> places;
}

class MapResultLoading implements MapResult {}
