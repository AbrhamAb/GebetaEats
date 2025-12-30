import 'package:equatable/equatable.dart';
import '../../../models/mock_data.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

/// Event to add a dish to the cart
class AddDish extends CartEvent {
  final Dish dish;

  const AddDish(this.dish);

  @override
  List<Object?> get props => [dish];
}

/// Event to remove a dish from the cart
class RemoveDish extends CartEvent {
  final Dish dish;

  const RemoveDish(this.dish);

  @override
  List<Object?> get props => [dish];
}
