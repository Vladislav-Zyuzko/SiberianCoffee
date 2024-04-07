part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class OrderAddProductEvent extends OrderEvent {
  final Product product;

  OrderAddProductEvent({required this.product});
}

class OrderRemoveProductEvent extends OrderEvent {
  final Product product;

  OrderRemoveProductEvent({required this.product});
}
