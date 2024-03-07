import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/theme/app_fonts.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.dimWhite,
  textTheme: const TextTheme(
    titleLarge: AppFonts.titleLarge,
    titleMedium: AppFonts.titleMedium,
    bodySmall: AppFonts.bodySmall,
  ),
);
