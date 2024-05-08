import 'package:siberian_coffee/src/features/menu/models/dto/user/user_dto.dart';
import 'package:siberian_coffee/src/features/menu/models/user.dart';
import 'package:siberian_coffee/src/features/menu/utils/address_mapper.dart';

extension UserMapper on UserDto {
  User toModel() {
    return User(
      userCoffeeShopAddress: userCoffeeShopAddress.toModel(),
    );
  }
}
