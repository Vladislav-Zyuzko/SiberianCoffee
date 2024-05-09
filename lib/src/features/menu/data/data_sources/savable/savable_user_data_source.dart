import 'dart:convert';

import 'package:siberian_coffee/src/features/menu/models/dto/address/address_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ISavableUserDataSource {
  AddressDto? loadUserCoffeeShopAddress();
  Future<void> saveUserCoffeeShopAddress({required AddressDto addressDto});
}

class PreferencesUserDataSource implements ISavableUserDataSource {
  final SharedPreferences _prefs;

  const PreferencesUserDataSource({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  @override
  AddressDto? loadUserCoffeeShopAddress() {
    String? userCoffeeShopAddress = _prefs.getString('userCoffeeShopAddress');
    if (userCoffeeShopAddress != null) {
      return AddressDto.fromJson(json.decode(userCoffeeShopAddress));
    }
    return null;
  }

  @override
  Future<void> saveUserCoffeeShopAddress({required AddressDto addressDto}) async {
    await _prefs.setString(
      'userCoffeeShopAddress', 
      json.encode(addressDto.toJson()),
    );
  }
}
