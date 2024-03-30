import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:siberian_coffee/src/common/interfaces/i_product_repository.dart';
import 'package:siberian_coffee/src/common/network/api_client.dart';
import 'package:siberian_coffee/src/common/network/exceptions/persistance_exception.dart';
import 'package:siberian_coffee/src/features/menu/models/product.dart';
import 'package:siberian_coffee/src/features/menu/models/category.dart';

class ProductRepository implements IProductRepository {
  final ApiClient _apiClient;

  ProductRepository() : _apiClient = ApiClient();

  @override
  Future<List<Product>> loadProducts(List<Category> categories) async {
    List<Product> productList = <Product>[];
    for (Category category in categories) {
      productList.addAll(await loadProductsByCategory(category.categoryId));
    }
    return productList;
  }

  Future<List<Product>> loadProductsByCategory(int idCategory) async {
    try {
      final Response response =
          await _apiClient.getProductsByCategory(0, 100, idCategory);
      List<dynamic> productsData =
          json.decode(json.encode(response.data))['data'];
      List<Product> productList = <Product>[];
      for (var productMap in productsData) {
        productList.add(Product.fromJson(productMap));
      }
      return productList;
    } catch (e) {
      throw PersistanceException("There is problem in loading products: $e");
    }
  }
}
