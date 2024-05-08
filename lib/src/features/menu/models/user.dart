import 'package:siberian_coffee/src/features/menu/models/address.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/user/user_dto.dart';

class User {
  final Address userCoffeeShopAddress;

  const User({required this.userCoffeeShopAddress});

  UserDto toDto() {
    return UserDto(
      userCoffeeShopAddress: userCoffeeShopAddress.toDto(),
    );
  }
}
