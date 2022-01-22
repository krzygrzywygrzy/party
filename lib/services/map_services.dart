import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:party/core/failure.dart';

class MapService {
  static final _places = GoogleMapsPlaces(apiKey: dotenv.env['MAPS_API_KEY']);

  static Future<Either<Failure, List<PlacesSearchResult>>> findAddress(
      String phrase) async {
    try {
      var res = await _places.searchByText(phrase);
      return Right(res.results);
    } catch (e) {
      return Left(MapFailure());
    }
  }

  static Future<void> openGoogleMaps() async {
    throw UnimplementedError();
  }
}
