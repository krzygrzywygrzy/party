import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home {
  Home({
    required this.loading,
  });

  final bool loading;
}

class HomeProvider extends StateNotifier<Home> {
  HomeProvider() : super(Home(loading: false));

  load() {
    state = Home(loading: true);
  }
}

final homeProvider =
    StateNotifierProvider<HomeProvider, Home>((ref) => HomeProvider());
