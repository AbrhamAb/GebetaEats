import 'package:equatable/equatable.dart';
import 'package:gebeta_eats/models/mock_data.dart';

class RestaurantState extends Equatable {
  final RestaurantData restaurant;
  final List<Dish> menu;

  const RestaurantState({
    required this.restaurant,
    required this.menu,
  });

  /// Copy helper
  RestaurantState copyWith({
    RestaurantData? restaurant,
    List<Dish>? menu,
  }) {
    return RestaurantState(
      restaurant: restaurant ?? this.restaurant,
      menu: menu ?? this.menu,
    );
  }

  @override
  List<Object?> get props => [restaurant, menu];
}
