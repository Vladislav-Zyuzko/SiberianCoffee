part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

class OrderEmptyState extends OrderState {}

class OrderAcitveState extends OrderState {
  final double amountOrder;
  final List<Product> orderList;

  OrderAcitveState({required this.orderList, required this.amountOrder});
}
