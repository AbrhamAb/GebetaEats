import 'package:equatable/equatable.dart';
import 'package:gebeta_eats/models/cart_item_model.dart';

class CartState extends Equatable {
  final Map<String, CartItem> items;
  final double total;

  const CartState({
    required this.items,
    required this.total,
  });

  factory CartState.initial() {
    return const CartState(
      items: {},
      total: 0.0,
    );
  }

  CartState copyWith({
    Map<String, CartItem>? items,
    double? total,
  }) {
    return CartState(
      items: items ?? this.items,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [items, total];
}
extension CartStateX on CartState {
  double get subtotal =>
      items.values.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  double get deliveryFee => 5.0; // or any logic for delivery fee

  double get total => subtotal + deliveryFee;
}
