abstract class Failure {}

class UnknownFailure implements Failure {}

class SignInFailure implements Failure {
  SignInFailure(this.message);
  final String? message;
}

class SignUpFailure implements Failure {
  SignUpFailure(this.message);
  final String? message;
}
