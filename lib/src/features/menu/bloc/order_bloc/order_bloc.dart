import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:siberian_coffee/src/features/menu/data/order_repository.dart';
import 'package:siberian_coffee/src/features/menu/models/product.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;
  OrderBloc({
    required OrderRepository orderRepository
  }) : _orderRepository = orderRepository, super(OrderEmptyState()) {
    on<OrderAddProductEvent>(_addProduct);
    on<OrderRemoveProductEvent>(_removeProduct);
    on<OrderClearEvent>(_clearOrder);
    on<OrderSendOrderEvent>(_sendOrder);
  }

  _addProduct(OrderAddProductEvent event, Emitter emit) {
    double amountOrder = 0;
    List<Product> orderList = [];
    if (state is OrderActiveState) {
      amountOrder = (state as OrderActiveState).amountOrder;
      orderList = (state as OrderActiveState).orderList;
    }
    if (orderList.where((product) => product == event.product).length < 10) {
      orderList.add(event.product);
    }
    emit(
      OrderActiveState(
          orderList: orderList,
          amountOrder: amountOrder + event.product.productCost),
    );
  }

  _removeProduct(OrderRemoveProductEvent event, Emitter emit) {
    if (state is OrderActiveState) {
      double amountOrder = (state as OrderActiveState).amountOrder;
      List<Product> orderList = (state as OrderActiveState).orderList;
      int lastEventProductIndex = -1;
      for (int i = 0; i < orderList.length; i++) {
        if (orderList[i] == event.product) {
          lastEventProductIndex = i;
        }
      }
      lastEventProductIndex != -1
          ? orderList.removeAt(lastEventProductIndex)
          : null;
      orderList.isNotEmpty
          ? emit(
              OrderActiveState(
                  orderList: orderList,
                  amountOrder: amountOrder - event.product.productCost),
            )
          : emit(OrderEmptyState());
    }
  }

  _clearOrder(OrderClearEvent event, Emitter<OrderState> emit) {
    emit(OrderEmptyState());
  }

  _sendOrder(OrderSendOrderEvent event, Emitter<OrderState> emit) async {
    if (state is OrderActiveState) {
      OrderActiveState activeState = state as OrderActiveState;
      Map<String, int> orderPositions = {};
      for (Product product in activeState.orderList) {
        if (orderPositions.containsKey(product.productId)) {
          orderPositions[product.productId] =
              orderPositions[product.productId]! + 1;
        } else {
          orderPositions[product.productId] = 1;
        }
      }
      bool sendingSuccess = await _orderRepository.sendOrder(orderPositions);
      sendingSuccess
          ? emit(OrderSendSuccessState())
          : emit(OrderSendErrorState());
    }
  }
}
