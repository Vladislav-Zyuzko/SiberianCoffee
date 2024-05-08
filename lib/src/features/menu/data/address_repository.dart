import 'package:siberian_coffee/src/features/menu/data/data_sources/addresses_data_source.dart';
import 'package:siberian_coffee/src/features/menu/models/address.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/address/address_dto.dart';
import 'package:siberian_coffee/src/features/menu/utils/address_mapper.dart';

abstract interface class IAddressRepository {
  Future<List<Address>> loadAddresses();
}

class AddressRepository implements IAddressRepository {
  final IAddressesDataSource _networkAddressesDataSource;

  const AddressRepository({
    required IAddressesDataSource networkAddressesDataSource,
  }) : _networkAddressesDataSource = networkAddressesDataSource;

  @override
  Future<List<Address>> loadAddresses() async {
    var dtos = <AddressDto>[];
    try {
      dtos = await _networkAddressesDataSource.loadAddresses();
    } catch (e) {
      rethrow;
    }
    return dtos.map((e) => e.toModel()).toList();
  }
}
