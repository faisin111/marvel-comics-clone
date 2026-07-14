import 'package:flutter/material.dart';

class ComicFilter extends StatelessWidget {
  final List<dynamic> filters;
  final Function(int index) onTap;

  const ComicFilter({
    super.key,
    required this.filters,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = filters[index];

          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: item.isSelected
                    ? const Color(0xffED1D24)
                    : const Color(0xff1A1C22),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: item.isSelected
                      ? Colors.transparent
                      : Colors.white10,
                ),
              ),
              child: Center(
                child: Text(
                  item.title,
                  style: TextStyle(
                    color: item.isSelected
                        ? Colors.white
                        : Colors.grey.shade400,
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