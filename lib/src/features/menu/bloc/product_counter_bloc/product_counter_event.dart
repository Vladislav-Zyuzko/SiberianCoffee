part of 'product_counter_bloc.dart';

@immutable
sealed class ProductCounterEvent {}

class ProductCounterActivateEvent extends ProductCounterEvent {}
class ProductCounterIncEvent extends ProductCounterEvent {}
class ProductCounterDecEvent extends ProductCounterEvent {}
