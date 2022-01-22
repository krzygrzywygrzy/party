import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:party/core/failure.dart';
import 'package:party/models/event.dart';

class EventService {
  static final CollectionReference _events =
      FirebaseFirestore.instance.collection("events");

  static Future<Either<Failure, Event>> addEvent(Event event) async {
    try {
      var json = event.toJson();
      var res = await _events.add(json);

      return Right(
        Event.fromJson({
          ...json,
          "id": res.id,
        }),
      );
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message));
    } catch (e) {
      print(e);
      return Left(UnknownFailure());
    }
  }

  static Future<Either<Failure, List<Event>>> getAllEvents() async {
    try {
      List<Event> events = [];

      var querySnapshot = await _events.get();
      for (var doc in querySnapshot.docs) {
        events.add(Event.fromJson(
            {"id": doc.id, ...doc.data() as Map<String, dynamic>}));
      }

      return Right(events);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
