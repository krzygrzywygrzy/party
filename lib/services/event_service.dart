import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:party/core/failure.dart';
import 'package:party/models/event.dart';

class EventService {
  static Future<Either<Failure, Event>> addEvent(Event event) async {
    try {} on FirebaseException catch (e) {
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
