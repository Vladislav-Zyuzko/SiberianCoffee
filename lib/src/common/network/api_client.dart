import 'package:dio/dio.dart';
import 'package:siberian_coffee/src/common/network/rest_client.dart';

class ApiClient {
  static ApiClient? _instance;
  static late final Dio dio;

  ApiClient._();

  factory ApiClient() => _instance!;

  static Future<void> initialize() async {
    _instance = ApiClient._();
    final restClient = RestClient();
    await restClient.init();
    dio = restClient.dio;
  }

  Future<Response> getCategories() async {
    Response response = await dio.get("/products/categories");
    return response;
  }

  Future<Response> getProductsByCategory(int limit, int idCategory) async {
    Response response = await dio.get(
      "/products/",
      queryParameters: {'category': idCategory, 'limit': limit},
    );
    return response;
  }
}
