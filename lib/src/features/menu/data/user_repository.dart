import 'package:siberian_coffee/src/features/menu/data/data_sources/savable/savable_user_data_source.dart';
import 'package:siberian_coffee/src/features/menu/models/address.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/address/address_dto.dart';
import 'package:siberian_coffee/src/features/menu/models/user.dart';
import 'package:siberian_coffee/src/features/menu/utils/address_mapper.dart';

abstract interface class IUserRepository {
  User loadUser();
  Address? loadUserCoffeeShopAddress();
  Future<void> saveUser({required User user});
  Future<void> saveUserCoffeeShopAddress({required Address address});
}

class UserRepository implements IUserRepository {
  final ISavableUserDataSource _preferencesUserDataSource;

  const UserRepository({
    required ISavableUserDataSource preferencesUserDataSource,
  }) : _preferencesUserDataSource = preferencesUserDataSource;

  @override
  User loadUser() {
    AddressDto? userCoffeeShopAddress =
        _preferencesUserDataSource.loadUserCoffeeShopAddress();
    return User(userCoffeeShopAddress: userCoffeeShopAddress?.toModel());
  }

  @override
  Address? loadUserCoffeeShopAddress() {
    return _preferencesUserDataSource.loadUserCoffeeShopAddress()?.toModel();
  }

  @override
  Future<void> saveUser({required User user}) async {
    if (user.userCoffeeShopAddress != null) {
      await _preferencesUserDataSource.saveUserCoffeeShopAddress(
        addressDto: user.userCoffeeShopAddress!.toDto(),
      );
    }
  }

  @override
  Future<void> saveUserCoffeeShopAddress({required Address address}) async {
    await _preferencesUserDataSource.saveUserCoffeeShopAddress(
      addressDto: address.toDto(),
    );
  }
}
