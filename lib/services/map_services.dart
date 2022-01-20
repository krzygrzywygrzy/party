import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:party/core/failure.dart';

class MapServices {
  static final _places = GoogleMapsPlaces(apiKey: dotenv.env['MAPS_API_KEY']);

  static Future<Either<Failure, dynamic>> findAddress() {
    throw UnimplementedError();
    try {} catch (e) {}
  }
}
