import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/address/address_dto.dart';

abstract interface class IAddressesDataSource {
  Future<List<AddressDto>> loadAddresses();
}

class NetworkAddressesDataSource implements IAddressesDataSource {
  final Dio _dio;

  const NetworkAddressesDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<AddressDto>> loadAddresses() async {
    Response response = await _dio.get(
      "/locations/",
    );
    List<AddressDto> dtos = (
      json.decode(json.encode(response.data))['data'] as List<dynamic>).map(
        (json) => AddressDto.fromJson(json),
      ).toList();
    return dtos;
  }
}
