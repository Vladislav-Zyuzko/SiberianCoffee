import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/address/address_dto.dart';

abstract interface class IScPreferenciesApi {
  String? loadFcmToken();
  AddressDto? loadUserCoffeeShopAddress();
  Future<void> saveFcmToken({required String fcmToken});
  Future<void> saveUserCoffeeShopAddress({required AddressDto addressDto});
}

class ScSharedPreferencesApi implements IScPreferenciesApi {
  ScSharedPreferencesApi._() {
    _initPrefs();
  }

  static final ScSharedPreferencesApi _instance = ScSharedPreferencesApi._();

  factory ScSharedPreferencesApi() {
    return _instance;
  }

  late SharedPreferences _prefs;

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  String? loadFcmToken() {
    return _prefs.getString('fcmToken');
  }

  @override
  AddressDto? loadUserCoffeeShopAddress() {
    String? userCoffeeShopAddress = _prefs.getString('userCoffeeShopAddress');
    if (userCoffeeShopAddress != null) {
      return AddressDto.fromJson(json.decode(userCoffeeShopAddress));
    }
    return null;
  }

  @override
  Future<void> saveFcmToken({required String fcmToken}) async {
    await _prefs.setString('fcmToken', fcmToken);
  }

  @override
  Future<void> saveUserCoffeeShopAddress({required AddressDto addressDto}) async {
    await _prefs.setString(
      'userCoffeeShopAddress', 
      json.encode(addressDto.toJson()),
    );
  }
}
