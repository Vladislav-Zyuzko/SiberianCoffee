import 'package:flutter/material.dart';

sealed class AppColors {
  static const primaryWhite = Colors.white;
  static const dimWhite = Color(0xFFF7FAF8);
  static const primaryPlatinum = Color(0xFFE5E4E2);
  static const lightGreyD9 = Color(0xFFD9D9D9);
  static const lightGreyE5 = Color(0xFFE5E5E5);
  static const priamaryGrey = Colors.grey;
  static const darkGrey = Color.fromARGB(255, 203, 198, 198);
  static const primaryBlue = Color(0xFF85C3DE);
  static const middleBlue = Color(0xFF034569);
  static const darkBlue = Color.fromRGBO(0, 28, 56, 0.16);
  static const dimDarkBlue = Color.fromRGBO(0, 28, 56, 0.08);
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
