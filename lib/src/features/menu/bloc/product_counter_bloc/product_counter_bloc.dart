import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_counter_event.dart';
part 'product_counter_state.dart';

class ProductCounterBloc
    extends Bloc<ProductCounterEvent, ProductCounterState> {
  ProductCounterBloc() : super(ProductCounterState()) {
    on<ProductCounterActivateEvent>(_onActivate);
    on<ProductCounterIncEvent>(_onIncrement);
    on<ProductCounterDecEvent>(_onDecrement);
  }

  void _onActivate(
      ProductCounterActivateEvent event, Emitter<ProductCounterState> emit) {
    emit(ProductCounterState(countProducts: 1, counterIsActive: true));
  }

  void _onIncrement(
      ProductCounterIncEvent event, Emitter<ProductCounterState> emit) {
    state.countProducts != 10
        ? emit(state.copyWith(
            countProducts: state.countProducts + 1))
        : null;
  }

  void _onDecrement(
      ProductCounterDecEvent event, Emitter<ProductCounterState> emit) {
    state.countProducts != 1
        ? emit(state.copyWith(countProducts: state.countProducts - 1))
        : emit(ProductCounterState());
  }
}
