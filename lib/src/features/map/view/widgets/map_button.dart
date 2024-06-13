import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';

class MapButton extends StatelessWidget {
  final String iconUrl;
  final void Function() onTap;
  const MapButton({
    super.key,
    required this.iconUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            offset: Offset(0, 4),
            color: AppColors.dimBlack25,
          )
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          splashColor: AppColors.darkBlue,
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: Image.asset(
              iconUrl,
              width: 20,
              height: 20,
            ),
          ),
        ),
      ),
    );
  }
}
