import 'package:equatable/equatable.dart';
import 'package:gebeta_eats/models/mock_data.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object?> get props => [];
}

class LoadRestaurant extends RestaurantEvent {
  final RestaurantData restaurant;

  const LoadRestaurant(this.restaurant);

  @override
  List<Object?> get props => [restaurant];
}
