import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:siberian_coffee/src/common/network/api_client.dart';

abstract class IOrderRepository {
  Future<bool> sendOrder(Map<String, int> order);
}

class OrderRepository implements IOrderRepository {
  final ApiClient _apiClient;

  OrderRepository() : _apiClient = ApiClient();

  @override
  Future<bool> sendOrder(Map<String, int> order) async {
    try {
      Response response =
          await _apiClient.sendOrder(order, "<FCM registration token>");
      Map orderData = json.decode(json.encode(response.data));
      return orderData["message"] == "success";
    } catch(e) {
      return false;
    }
  }
}
