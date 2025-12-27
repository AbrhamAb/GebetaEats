import 'cart_entry.dart';
import 'restaurant_model.dart';
import 'order_status.dart';

class OrderData {
  OrderData({
    required this.id,
    required this.restaurant,
    required this.items,
    this.status = OrderStatus.pending,
    required this.total,
  });

  final String id;
  final RestaurantData restaurant;
  final List<CartEntry> items;
  OrderStatus status;
  final double total;

  int get totalItems => items.fold(0, (sum, e) => sum + e.quantity);
}
