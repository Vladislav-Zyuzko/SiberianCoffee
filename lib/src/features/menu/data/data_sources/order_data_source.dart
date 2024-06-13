import 'package:dio/dio.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/order/order_dto.dart';

abstract interface class IOrderDataSource {
  Future<Response> sendOrder(OrderDto order);
}

class NetworkOrderDataSource implements IOrderDataSource {
  final Dio _dio;

  const NetworkOrderDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<Response> sendOrder(OrderDto order) async {
    Response response = await _dio.post("/orders", data: order.toJson());
    return response;
  }
}
