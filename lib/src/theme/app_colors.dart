import 'package:flutter/material.dart';

sealed class AppColors {
  static const primaryWhite = Colors.white;
  static const dimWhite = Color(0xFFF7FAF8);
  static const primaryBlue = Color(0xFF85C3DE);
  static const darkBlue = Color(0xFF034569);
  static const dimBlack = Color(0x55000000);
  static const primaryBlack = Colors.black;

  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}
