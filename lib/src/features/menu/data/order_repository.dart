import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/order_data_source.dart';
import 'package:siberian_coffee/src/features/menu/models/order.dart';
import 'package:siberian_coffee/src/features/menu/utils/order_mapper.dart';

abstract class IOrderRepository {
  Future<bool> sendOrder(Order order);
}

class OrderRepository implements IOrderRepository {
  final IOrderDataSource _networkOrderDataSource;

  const OrderRepository({
    required IOrderDataSource networkOrderDataSource,
  }) : _networkOrderDataSource = networkOrderDataSource;

  @override
  Future<bool> sendOrder(Order order) async {
    try {
      Response response =  await _networkOrderDataSource.sendOrder(order.toDto());
      Map orderData = json.decode(json.encode(response.data));
      return orderData["message"] == "success";
    } catch (e) {
      return false;
    }
  }
}
