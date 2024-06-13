import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/category/category_dto.dart';

abstract interface class ICategoriesDataSource {
  Future<List<CategoryDto>> loadCategories();
}

class NetworkCategoriesDataSource implements ICategoriesDataSource {
  final Dio _dio;

  const NetworkCategoriesDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<CategoryDto>> loadCategories() async {
    Response response = await _dio.get(
      "/products/categories",
    );
    List<CategoryDto> dtos = (
      json.decode(json.encode(response.data))['data'] as List<dynamic>).map(
        (json) => CategoryDto.fromJson(json),
      ).toList();
    return dtos;
  }
}
