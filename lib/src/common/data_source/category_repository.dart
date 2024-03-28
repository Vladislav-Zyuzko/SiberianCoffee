import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:siberian_coffee/src/common/interfaces/i_category_repository.dart';
import 'package:siberian_coffee/src/common/network/api_client.dart';
import 'package:siberian_coffee/src/common/network/exceptions/persistance_exception.dart';
import 'package:siberian_coffee/src/features/menu/models/category.dart';

class CategoryRepository implements ICategoryRepository {
  final ApiClient _apiClient;

  CategoryRepository() : _apiClient = ApiClient();

  @override
  Future<List<Category>> loadCategories() async {
    try {
      final Response response = await _apiClient.getCategories(0, 25);
      List<dynamic> categoriesData =
          json.decode(json.encode(response.data))['data'];
      List<Category> categories = <Category>[];
      for (var categoryMap in categoriesData) {
        categories.add(Category.fromJson(categoryMap));
      }
      return categories;
    } catch (e) {
      throw PersistanceException("There is problem in loading categories: $e");
    }
  }
}
