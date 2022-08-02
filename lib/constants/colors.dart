import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  static const textInputColor = const Color(0xFF3f3f3f);
  static const textColor = const Color(0xFF3f3f3f);

  static const Map<int, Color> purple = const <int, Color>{
    50: const Color(0xFFFCF2E7),
    100: const Color(0xFF4B0F7E),
    200: const Color(0xFFF3C89C),
    300: const Color(0xFFEEB274),
    400: const Color(0xFFEAA256),
    500: const Color(0xFF4B0F7E),
    600: const Color(0xFFE38932),
    700: const Color(0xFFDF7E2B),
    800: const Color(0xFFDB7424),
    900: const Color(0xFFD56217)
  };

  static const Map<int, Color> white = {
    50: const Color(0xFFFCF2E7),
    100: const Color(0xFFFCF2E7),
    200: const Color(0xFFFCF2E7),
    300: const Color(0xFFFCF2E7),
    400: const Color(0xFFFCF2E7),
    500: const Color(0xFFFCF2E7),
    600: const Color(0xFFFCF2E7),
    700: const Color(0xFFFCF2E7),
    800: const Color(0xFFFCF2E7),
    900: const Color(0xFFFCF2E7),
  };

  static const Map<int, Color> orange = const <int, Color>{
    50: const Color(0xFFFCF2E7),
    100: const Color(0xFFF8DEC3),
    200: const Color(0xFFF3C89C),
    300: const Color(0xFFEEB274),
    400: const Color(0xFFEAA256),
    500: const Color(0xFFE69138),
    600: const Color(0xFFE38932),
    700: const Color(0xFFDF7E2B),
    800: const Color(0xFFDB7424),
    900: const Color(0xFFFF0000)
  };
}
