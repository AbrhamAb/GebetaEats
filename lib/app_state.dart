import 'package:flutter/material.dart';
import 'models/mock_data.dart';

/// -------------------- CART --------------------
class CartEntry {
  CartEntry({required this.dish, this.quantity = 1});

  final Dish dish;
  int quantity;

  double get total => dish.price * quantity;
}

/// -------------------- ORDERS --------------------
class Order {
  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.date,
    this.status = OrderStatus.pending,
  });

  final String id; // unique order ID
  final List<CartEntry> items;
  final double total;
  final DateTime date;
  OrderStatus status;
}

enum OrderStatus { pending, preparing, onTheWay, delivered }

/// -------------------- APP STATE --------------------
class AppState extends ChangeNotifier {
  /// -------------------- CART --------------------
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

  double get deliveryFee => _items.isEmpty ? 0 : 3.50;

  double get total => subtotal + deliveryFee;

  int get totalItems =>
      _items.values.fold(0, (sum, entry) => sum + entry.quantity);

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// -------------------- FAVORITES --------------------
  final List<Dish> _favorites = [];

  List<Dish> get favorites => List.unmodifiable(_favorites);

  void addFavorite(Dish dish) {
    if (!_favorites.any((d) => d.id == dish.id)) {
      _favorites.add(dish);
      notifyListeners();
    }
  }

  void removeFavorite(Dish dish) {
    _favorites.removeWhere((d) => d.id == dish.id);
    notifyListeners();
  }

  bool isFavorite(Dish dish) {
    return _favorites.any((d) => d.id == dish.id);
  }

  void toggleFavorite(Dish dish) {
    if (isFavorite(dish)) {
      removeFavorite(dish);
    } else {
      addFavorite(dish);
    }
  }

  /// -------------------- USER --------------------
  String userName = 'Gebeta User';
  String userEmail = 'gebetauser@example.com';
  String userAvatar =
      'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=200&q=80';

  void updateUser({String? name, String? email, String? avatar}) {
    if (name != null) userName = name;
    if (email != null) userEmail = email;
    if (avatar != null) userAvatar = avatar;
    notifyListeners();
  }

  /// -------------------- ADDRESSES --------------------
  final List<String> _addresses = [
    '123 Main St, Bahir Dar',
    '45 Lake Rd, Bahir Dar',
  ];

  List<String> get addresses => List.unmodifiable(_addresses);

  void addAddress(String address) {
    _addresses.add(address);
    notifyListeners();
  }

  void removeAddress(String address) {
    _addresses.remove(address);
    notifyListeners();
  }

  void editAddress(int index, String newAddress) {
    if (index >= 0 && index < _addresses.length) {
      _addresses[index] = newAddress;
      notifyListeners();
    }
  }

  /// -------------------- ORDERS --------------------
  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  void placeOrder() {
    if (_items.isEmpty) return;

    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: _items.values.toList(),
      total: total,
      date: DateTime.now(),
    );

    _orders.add(newOrder);
    clearCart();
    notifyListeners();
  }

  void updateOrderStatus(String orderId, OrderStatus status) {
    final order = _orders.firstWhere(
      (o) => o.id == orderId,
      orElse: () => throw 'Order not found',
    );
    order.status = status;
    notifyListeners();
  }

  /// -------------------- LOGOUT --------------------
  void logout() {
    userName = '';
    userEmail = '';
    userAvatar = '';
    clearCart();
    _favorites.clear();
    _addresses.clear();
    _orders.clear();
    notifyListeners();
  }
}

/// -------------------- APP STATE SCOPE --------------------
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
