import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_comics/core/theme/app_theme.dart';
import 'package:marvel_comics/view_models/providers/character_provider.dart';

class SerachBarField extends ConsumerWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  const SerachBarField({super.key,required this.onChanged, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    double w(double w) => size.width * w;
    double h(double h) => size.width * h;
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: AppTheme.geyColor),

        hintText: "Search characters",
        hintStyle: GoogleFonts.poppins(
          color: AppTheme.geyColor,
          fontSize: w(0.04),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 29, 29, 29),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 1, color: AppTheme.geyColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 1, color: AppTheme.geyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 2, color: AppTheme.primaryColor),
        ),
      ),
    );
  }
}
