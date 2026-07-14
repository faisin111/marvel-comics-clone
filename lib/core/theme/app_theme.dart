import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color.fromARGB(255, 244, 16, 0);
  static const Color bgColor = Color.fromARGB(255, 0, 0, 0);
  static const Color blackColor = Color.fromARGB(255, 0, 0, 0);
  static const Color whiteColor = Color.fromARGB(255, 255, 255, 255);
  static const Color geyColor = Color.fromARGB(255, 102, 102, 102);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ),
  );
}
