import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siberian_coffee/src/features/map/view/map_screen.dart';
import 'package:siberian_coffee/src/features/menu/bloc/user_bloc/user_bloc.dart';
import 'package:siberian_coffee/src/features/menu/models/address.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';
import 'package:siberian_coffee/src/theme/icons_source.dart';

class CoffeeShopAddressPanel extends StatelessWidget {
  final Address userCoffeeShopAddress;
  final List<Address> coffeeShopsAddresses;

  const CoffeeShopAddressPanel({
    super.key,
    required this.userCoffeeShopAddress,
    required this.coffeeShopsAddresses,
  });

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = context.watch<UserBloc>();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Material(
        child: InkWell(
          onTap: (() async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen(
                  coffeeShopAddresses: coffeeShopsAddresses,
                  userCoffeeShopAddress: userCoffeeShopAddress,
                ),
              ),
            );
            if (result is Address) {
              print("***************************************************************");
              userBloc.add(UserSaveAddressEvent(
                  userCoffeeShopAddress: result,
              ));
            }
          }),
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
                  userCoffeeShopAddress.address,
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
