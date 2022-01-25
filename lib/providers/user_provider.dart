import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/core/failure.dart';
import 'package:party/services/auth_service.dart';
import '../models/user.dart' as model;

class User {
  User({
    required this.loading,
    this.user,
    this.failure,
  });

  final bool loading;
  final model.User? user;
  final Failure? failure;
}

class UserProvider extends StateNotifier<User> {
  UserProvider()
      : super(User(
          loading: false,
        ));

  load() async {
    var currentUser = FirebaseAuth.instance.currentUser;

    if (state.user == null && currentUser != null) {
      state = User(loading: true);

      var res = await AuthService.getUser(currentUser.uid);

      res.fold(
          (l) => state = User(
                loading: false,
                failure: l,
              ),
          (r) => state = User(
                loading: false,
                user: r,
              ));
    }
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, User>((ref) => UserProvider());
