import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/mock_data.dart';
import '../../../models/dish.dart';
import 'restaurant_event.dart';
import 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc({required RestaurantData restaurant}) 
      : super(RestaurantState(restaurant: restaurant, menu: const [])) {
    on<LoadRestaurant>(_onLoadRestaurant);
    
    // Trigger load immediately or wait for event
    add(LoadRestaurant(restaurant));
  }

  void _onLoadRestaurant(LoadRestaurant event, Emitter<RestaurantState> emit) {
    // In a real app, we would fetch the menu for this restaurant here.
    // For now, we use mock data based on the restaurant ID.
    final menu = restaurantMenus[event.restaurant.id] ?? [];
    emit(state.copyWith(
      restaurant: event.restaurant,
      menu: menu,
    ));
  }
}
