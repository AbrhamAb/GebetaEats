import 'dish.dart';

class CartEntry {
  CartEntry({required this.dish, this.quantity = 1});

  final Dish dish;
  int quantity;

  double get total => dish.price * quantity;
}
