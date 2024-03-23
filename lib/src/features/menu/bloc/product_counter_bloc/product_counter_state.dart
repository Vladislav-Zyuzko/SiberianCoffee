part of 'product_counter_bloc.dart';

class ProductCounterState {
  bool counterIsActive;
  int countProducts;

  ProductCounterState({this.countProducts = 0, this.counterIsActive = false});

  ProductCounterState copyWith({bool? counterIsActive, int? countProducts}) {
    return ProductCounterState(
        countProducts: countProducts ?? this.countProducts,
        counterIsActive: counterIsActive ?? this.counterIsActive);
  }
}
