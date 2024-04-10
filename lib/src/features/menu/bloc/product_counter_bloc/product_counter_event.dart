part of 'product_counter_bloc.dart';

@immutable
sealed class ProductCounterEvent {}

class ProductCounterActivateEvent extends ProductCounterEvent {}

class ProductCounterIncEvent extends ProductCounterEvent {
  final OrderBloc orderBloc;
  final Product product;

  ProductCounterIncEvent({required this.orderBloc, required this.product});
}

class ProductCounterDecEvent extends ProductCounterEvent {}
