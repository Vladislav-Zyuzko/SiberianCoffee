import 'package:json_annotation/json_annotation.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/address/address_dto.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final AddressDto userCoffeeShopAddress;

  const UserDto({required this.userCoffeeShopAddress});

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

}
