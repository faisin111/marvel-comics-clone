import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_comics/view_models/providers/favourite_provider.dart';

class FavFilter extends ConsumerStatefulWidget {
  const FavFilter({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavFilterState();
}

class _FavFilterState extends ConsumerState<FavFilter> {
  final List<String> filters = ["All", "Characters", "Comics"];

  int iindex = 0;

  @override
  Widget build(BuildContext context) {
    final ite = ref.watch(favouriteProvider);
    final List<int> length = [
      ite.all.length,
      ite.characters.length,
      ite.comics.length,
    ];
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = filters[index];
          bool se = iindex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                iindex = index;
              });
              if (index == 1) {
                ref.read(favouriteProvider.notifier).getAllCh();
              } else if (index == 2) {
                ref.read(favouriteProvider.notifier).getAllCo();
              } else {
                ref.read(favouriteProvider.notifier).getAll();
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: se ? const Color(0xffED1D24) : const Color(0xff1A1C22),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: se ? Colors.transparent : Colors.white10,
                ),
              ),
              child: Center(
                child: Text(
                  filters[index] + "(${length[index]})",
                  style: TextStyle(
                    color: se ? Colors.white : Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
