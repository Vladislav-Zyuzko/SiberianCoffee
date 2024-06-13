import 'package:siberian_coffee/src/features/menu/data/data_sources/addresses_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/savable/savable_addresses_data_source.dart';
import 'package:siberian_coffee/src/features/menu/models/address.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/address/address_dto.dart';
import 'package:siberian_coffee/src/features/menu/utils/address_mapper.dart';

abstract interface class IAddressRepository {
  Future<List<Address>> loadAddresses();
}

class AddressRepository implements IAddressRepository {
  final IAddressesDataSource _networkAddressesDataSource;
  final ISavableAddressesDataSource _dbAddressesDataSource;

  const AddressRepository({
    required IAddressesDataSource networkAddressesDataSource,
    required ISavableAddressesDataSource dbAddressesDataSource,
  })  : _networkAddressesDataSource = networkAddressesDataSource,
        _dbAddressesDataSource = dbAddressesDataSource;

  @override
  Future<List<Address>> loadAddresses() async {
    var dtos = <AddressDto>[];
    try {
      dtos = await _networkAddressesDataSource.loadAddresses();
      _dbAddressesDataSource.saveAddresses(addresses: dtos);
    } catch (e) {
      dtos = await _dbAddressesDataSource.loadAddresses();
    }
    return dtos.map((e) => e.toModel()).toList();
  }
}
