import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';
import 'package:siberian_coffee/src/theme/image_sources.dart';

class OrderDetailsButton extends StatelessWidget {
  final double orderAmount;
  final void Function() onPressed;

  const OrderDetailsButton(
      {super.key, required this.onPressed, required this.orderAmount});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.dimDarkBlue,
            offset: Offset(0, 8),
            blurRadius: 12,
            spreadRadius: 6,
          ),
          BoxShadow(
            color: AppColors.darkBlue,
            offset: Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: FittedBox(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.primaryBlue),
            overlayColor: MaterialStateProperty.all<Color>(AppColors.darkBlue),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              const Size(99, 45),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                ImageSources.iconOrder,
                width: 18,
                height: 21,
              ),
              const Padding(padding: EdgeInsets.only(right: 12),),
              Text(
                "${orderAmount.toInt()}₽",
                style: Theme.of(context).textTheme.labelSmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
