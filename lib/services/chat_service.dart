import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:party/core/failure.dart';
import 'package:party/models/message.dart';

class ChatService {
  ChatService(String chatId) {
    chat = FirebaseFirestore.instance.collection("events/$chatId/chat");
  }
  late CollectionReference chat;

  Future<Either<Failure, Message>> sendMessage(Message message) async {
    try {
      chat.add(message.toJson());
      return Right(message);
    } on FirebaseException {
      return Left(FirestoreFailure("Could not send message!!!"));
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
