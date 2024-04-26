import 'package:siberian_coffee/src/features/menu/models/dto/order/order_dto.dart';
import 'package:siberian_coffee/src/features/menu/models/order.dart';

extension OrderMapper on Order {
  OrderDto toDto() {
    return OrderDto(
      positions: order,
      token: "<FCM registration token>",
    );
  }
}
