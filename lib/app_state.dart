import 'package:flutter/material.dart';

import 'models/mock_data.dart';

class CartEntry {
  CartEntry({required this.dish, this.quantity = 1});

  final Dish dish;
  int quantity;

  double get total => dish.price * quantity;
}

class AppState extends ChangeNotifier {
  final Map<String, CartEntry> _items = <String, CartEntry>{};

  Map<String, CartEntry> get items =>
      Map<String, CartEntry>.unmodifiable(_items);

  void addDish(Dish dish) {
    final entry = _items[dish.id];
    if (entry != null) {
      entry.quantity += 1;
    } else {
      _items[dish.id] = CartEntry(dish: dish, quantity: 1);
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

  double get subtotal =>
      _items.values.fold(0, (sum, entry) => sum + entry.total);

  double get deliveryFee => items.isEmpty ? 0 : 3.50;

  double get total => subtotal + deliveryFee;

  int get totalItems =>
      _items.values.fold(0, (sum, entry) => sum + entry.quantity);
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
