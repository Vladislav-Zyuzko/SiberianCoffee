import 'package:siberian_coffee/src/features/menu/models/dto/address/address_dto.dart';
import 'package:siberian_coffee/src/store/api/sc_preferencies_api.dart';

abstract interface class ISavableUserDataSource {
  AddressDto? loadUserCoffeeShopAddress();
  Future<void> saveUserCoffeeShopAddress({required AddressDto addressDto});
}

class PreferencesUserDataSource implements ISavableUserDataSource {
  final IScPreferenciesApi _scSharedPreferenciesApi;

  const PreferencesUserDataSource({
    required IScPreferenciesApi scSharedPreferenciesApi,
  }) : _scSharedPreferenciesApi = scSharedPreferenciesApi;

  @override
  AddressDto? loadUserCoffeeShopAddress() {
    return _scSharedPreferenciesApi.loadUserCoffeeShopAddress();
  }

  @override
  Future<void> saveUserCoffeeShopAddress({required AddressDto addressDto}) async {
    return _scSharedPreferenciesApi.saveUserCoffeeShopAddress(addressDto: addressDto);
  }
}
