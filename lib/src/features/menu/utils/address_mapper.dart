import 'package:siberian_coffee/src/features/menu/models/address.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/address/address_dto.dart';

extension AddressMapper on AddressDto {
  Address toModel() {
    return Address(
      address: address,
      lat: lat,
      lng: lng,
    );
  }
}
