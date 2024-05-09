import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';
import 'package:siberian_coffee/src/theme/icons_source.dart';

class CoffeeShopAddressPanel extends StatelessWidget {
  final String coffeeShopAddress;

  const CoffeeShopAddressPanel({super.key, required this.coffeeShopAddress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Material(
        child: InkWell(
          onTap: (() => {}),
          splashColor: AppColors.darkBlue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Image.asset(
                  IconsSource.iconLocationPin,
                  width: 24,
                  height: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  coffeeShopAddress, 
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
