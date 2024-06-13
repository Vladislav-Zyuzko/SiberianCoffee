import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/product/product_dto.dart';

abstract interface class IProductDataSource {
  Future<List<ProductDto>> loadProducts({required int categoryId, page = 0, limit = 25});
}

class NetworkProductDataSource implements IProductDataSource {
  final Dio _dio;

  const NetworkProductDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<ProductDto>> loadProducts({required int categoryId, page = 0, limit = 25}) async {
    Response response = await _dio.get(
      "/products/",
      queryParameters: {'category': categoryId, 'page': page, 'limit': limit},
    );
    List<ProductDto> dtos = (
      json.decode(json.encode(response.data))['data'] as List<dynamic>).map(
        (json) => ProductDto.fromJson(json),
      ).toList();
    return dtos;
  }
}
