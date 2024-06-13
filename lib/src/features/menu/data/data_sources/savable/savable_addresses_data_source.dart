import 'package:siberian_coffee/src/database/api/sc_database_api.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/addresses_data_source.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/address/address_dto.dart';

abstract interface class ISavableAddressesDataSource
    implements IAddressesDataSource {
  Future<void> saveAddresses({required List<AddressDto> addresses});
}

class DbAddressesDataSource implements ISavableAddressesDataSource {
  final IScDatabaseApi _scDatabaseApi;

  const DbAddressesDataSource({required IScDatabaseApi scDatabaseApi})
      : _scDatabaseApi = scDatabaseApi;

  @override
  Future<List<AddressDto>> loadAddresses() {
    return _scDatabaseApi.loadAddresses();
  }

  @override
  Future<void> saveAddresses({required List<AddressDto> addresses}) async {
    _scDatabaseApi.saveAddresses(addresses: addresses);
  }
}
