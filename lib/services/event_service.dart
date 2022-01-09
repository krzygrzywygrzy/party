import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:party/core/failure.dart';
import 'package:party/models/event.dart';

class EventService {
  static Future<Either<Failure, Event>> addEvent(Event event) async {
    try {
      var json = event.toJson();

      CollectionReference events =
          FirebaseFirestore.instance.collection("events");

      var res = await events.add(json);

      return Right(
        Event.fromJson({
          ...json,
          "id": res.id,
        }),
      );
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
