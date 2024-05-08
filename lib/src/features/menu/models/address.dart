import 'package:siberian_coffee/src/features/menu/models/dto/address/address_dto.dart';

class Address {
  final String address;
  final double lat;
  final double lng;

  const Address({required this.address, required this.lat, required this.lng});

  AddressDto toDto() {
    return AddressDto(
      address: address,
      lat: lat,
      lng: lng,
    );
  }
}
