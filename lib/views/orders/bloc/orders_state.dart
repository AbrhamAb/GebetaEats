import 'package:equatable/equatable.dart';
import '../../../models/order_data.dart';

enum OrdersStatus { initial, loading, success, failure }

class OrdersState extends Equatable {
  const OrdersState({
    this.status = OrdersStatus.initial,
    this.orders = const <OrderData>[],
  });

  final OrdersStatus status;
  final List<OrderData> orders;

  OrdersState copyWith({
    OrdersStatus? status,
    List<OrderData>? orders,
  }) {
    return OrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
    );
  }

  @override
  List<Object> get props => [status, orders];
}
