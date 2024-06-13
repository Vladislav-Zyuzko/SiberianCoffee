import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';

sealed class AppFonts {
  static const titleLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryBlack,
  );
  static const titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: AppColors.primaryBlack,
  );
  static const titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColors.primaryBlack,
  );
  static const bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.primaryWhite,
  );
  static const bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.4,
    color: AppColors.primaryBlack,
  );
  static const bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.primaryWhite,
  );
  static const labelLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25,
    color: AppColors.primaryBlack,
  );
  static const labelMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColors.primaryWhite,
  );
  static const labelSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.primaryWhite,
  );
}
