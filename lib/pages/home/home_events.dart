import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party/providers/home_provider.dart';

class HomeEvents extends ConsumerWidget {
  const HomeEvents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeData = ref.watch(homeProvider);

    if (homeData.loading) {
      return const Expanded(
        child: Center(
          child: Text("Loading..."),
        ),
      );
    } else {
      return Placeholder();
    }
  }
}
