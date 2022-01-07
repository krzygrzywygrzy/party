import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:party/core/failure.dart';

class AuthService {
  static Future<Either<Failure, UserCredential>> signIn(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Left(SignInFailure("The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        return Left(
            SignInFailure("The account already exists for that email."));
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  static Future<Either<Failure, UserCredential>> signUp(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return Right(userCredential);
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(SignUpFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        return Left(SignUpFailure('Wrong password provided for that user.'));
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
