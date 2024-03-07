import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';

class CategoryButton extends StatelessWidget {
  final Function() onTap;
  final String categoryName;
  final bool active;

  const CategoryButton(
      {super.key,
      required this.onTap,
      required this.categoryName,
      required this.active});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active ? AppColors.primaryBlue : AppColors.primaryWhite,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        highlightColor: AppColors.darkBlue,
        child: FittedBox(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 36,
            alignment: Alignment.center,
            child: Text(
              categoryName,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: active
                        ? AppColors.primaryWhite
                        : AppColors.primaryBlack,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
