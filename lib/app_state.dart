import 'package:flutter/material.dart';
import 'models/cart_entry.dart';
import 'models/dish.dart';
import 'models/order_data.dart';


class AppState extends ChangeNotifier {
  final Map<String, CartEntry> _items = {};

  Map<String, CartEntry> get items => Map.unmodifiable(_items);

  void addDish(Dish dish) {
    if (_items.containsKey(dish.id)) {
      _items[dish.id]!.quantity += 1;
    } else {
      _items[dish.id] = CartEntry(dish: dish);
    }
    notifyListeners();
  }

  void decrementDish(Dish dish) {
    final entry = _items[dish.id];
    if (entry == null) return;
    if (entry.quantity > 1) {
      entry.quantity -= 1;
    } else {
      _items.remove(dish.id);
    }
    notifyListeners();
  }

  void removeDish(Dish dish) {
    _items.remove(dish.id);
    notifyListeners();
  }

  double get subtotal => _items.values.fold(0, (sum, e) => sum + e.total);
  double get deliveryFee => items.isEmpty ? 0 : 3.50;
  double get total => subtotal + deliveryFee;
  int get totalItems => _items.values.fold(0, (sum, e) => sum + e.quantity);

  // Orders stored in the app state (empty by default).
  final List<OrderData> _orders = [];

  List<OrderData> get orders => List.unmodifiable(_orders);

  void addOrder(OrderData order) {
    _orders.add(order);
    notifyListeners();
  }
}

class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({
    super.key,
    required super.notifier,
    required super.child,
  });

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope not found in context');
    return scope!.notifier!;
  }
}
