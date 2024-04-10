import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';

class OrderDivider extends StatelessWidget {
  const OrderDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 9),
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppColors.lightGreyD9,
      ),
    );
  }
}
