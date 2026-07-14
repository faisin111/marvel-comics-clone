import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_comics/views/widgets/serach_bar_field.dart';

class ComicView extends ConsumerStatefulWidget {
  const ComicView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ComicViewState();
}

class _ComicViewState extends ConsumerState<ComicView> {
  final TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;
    double w(double w) => size.width * w;
    double h(double h) => size.width * h;
    return ListView(
      padding: EdgeInsets.all(w(0.04)),
      children: [
        SerachBarField(controller: controller),
        SizedBox(height: h(0.04)),
        // GridView.builder(
        //   physics: NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
      
        //   itemCount: 3,
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 14,
        //     mainAxisSpacing: 14,
        //     childAspectRatio: .68,
        //   ),
        //   itemBuilder: (_, index) {
        //     // final item = characters[index];

        //     return ComicView();
        //   },
        // ),
      ],
    );
  }
}