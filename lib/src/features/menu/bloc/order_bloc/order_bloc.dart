import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:siberian_coffee/src/features/menu/models/product.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderEmptyState()) {
    on<OrderAddProductEvent>(_addProduct);
    on<OrderRemoveProductEvent>(_removeProduct);
  }

  _addProduct(OrderAddProductEvent event, Emitter emit) {
    double amountOrder = 0;
    if (state is OrderActiveState) {
      amountOrder = (state as OrderActiveState).amountOrder;
    }
    emit(
      OrderActiveState(
          orderList: [], amountOrder: amountOrder + event.product.productCost),
    );
  }

  _removeProduct(OrderRemoveProductEvent event, Emitter emit) {
    double amountOrder = 0;
    if (state is OrderActiveState) {
      amountOrder = (state as OrderActiveState).amountOrder;
      emit(
        OrderActiveState(
            orderList: [],
            amountOrder: amountOrder - event.product.productCost),
      );
    }
  }
}
