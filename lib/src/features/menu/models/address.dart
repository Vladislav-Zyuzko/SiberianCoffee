import 'package:siberian_coffee/src/features/menu/models/dto/address/address_dto.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class Address {
  final String address;
  final double lat;
  final double lng;

  const Address({
    required this.address,
    required this.lat,
    required this.lng,
  });

  Point toPoint() {
    return Point(
      latitude: lat,
      longitude: lng,
    );
  }

  AddressDto toDto() {
    return AddressDto(
      address: address,
      lat: lat,
      lng: lng,
    );
  }
}
