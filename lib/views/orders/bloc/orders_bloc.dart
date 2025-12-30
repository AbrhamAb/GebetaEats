import 'package:flutter_bloc/flutter_bloc.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(const OrdersState()) {
    on<OrdersStarted>(_onStarted);
  }

  void _onStarted(OrdersStarted event, Emitter<OrdersState> emit) {
    // In a real app, load orders from repository
    emit(state.copyWith(status: OrdersStatus.success, orders: []));
  }
}
