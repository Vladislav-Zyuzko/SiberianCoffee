part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

class OrderEmptyState extends OrderState {}

class OrderActiveState extends OrderState {
  final double amountOrder;
  final List<Product> orderList;

  OrderActiveState({required this.orderList, required this.amountOrder});
}

class OrderSendSuccessState extends OrderState {}
class OrderSendErrorState extends OrderState {}
