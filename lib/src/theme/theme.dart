import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/theme/app_fonts.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.dimWhite,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryBlue,
    primary: AppColors.primaryBlue,
  ),
  textTheme: const TextTheme(
    titleLarge: AppFonts.titleLarge,
    titleMedium: AppFonts.titleMedium,
    titleSmall: AppFonts.titleSmall,
    bodyLarge: AppFonts.bodyLarge,
    bodyMedium: AppFonts.bodyMedium,
    bodySmall: AppFonts.bodySmall,
    labelLarge: AppFonts.labelLarge,
    labelMedium: AppFonts.labelMedium,
  ),
);
