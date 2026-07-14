import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouriteView extends ConsumerWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
        final size = MediaQuery.of(context).size;
    double w(double w) => size.width * w;
    double h(double h) => size.width * h;
    return Container();
  }
}