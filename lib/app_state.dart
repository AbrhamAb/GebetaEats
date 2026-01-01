import 'package:flutter/material.dart';
import 'models/restaurant_model.dart';
import 'models/dish_model.dart';
import 'services/supabase_client.dart';

/// -------------------- CART --------------------
class CartEntry {
  CartEntry({required this.dish, this.quantity = 1});

  final Dish dish;
  int quantity;

  double get total => dish.price * quantity;
}

/// -------------------- ORDERS --------------------
enum OrderStatus { pending, preparing, onTheWay, delivered }

class Order {
  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.date,
  });

  final String id;
  final List<CartEntry> items;
  final double total;
  final DateTime date;

  OrderStatus get status {
    final diff = DateTime.now().difference(date).inMinutes;

    if (diff < 1) return OrderStatus.pending;
    if (diff < 3) return OrderStatus.preparing;
    if (diff < 5) return OrderStatus.onTheWay;
    return OrderStatus.delivered;
  }
}

/// -------------------- APP STATE --------------------
class AppState extends ChangeNotifier {
  /// -------------------- CART --------------------
  final Map<String, CartEntry> _items = <String, CartEntry>{};
  Map<String, CartEntry> get items => Map.unmodifiable(_items);

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

  double get deliveryFee {
    if (_items.isEmpty || _restaurants.isEmpty) return 0;
    final firstDish = _items.values.first.dish;
    final restaurant = _restaurants.firstWhere(
      (r) => r.id == firstDish.restaurantId,
      orElse: () => _restaurants.first,
    );
    return (restaurant.deliveryTime / 2).roundToDouble();
  }

  double get total => subtotal + deliveryFee;

  int get totalItems =>
      _items.values.fold(0, (sum, entry) => sum + entry.quantity);

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// -------------------- FAVORITE DISHES --------------------
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

  bool isFavorite(Dish dish) => _favorites.any((d) => d.id == dish.id);

  void toggleFavorite(Dish dish) {
    if (isFavorite(dish)) {
      removeFavorite(dish);
    } else {
      addFavorite(dish);
    }
  }

  /// -------------------- FAVORITE RESTAURANTS --------------------
  final List<Restaurant> _favoriteRestaurants = [];
  List<Restaurant> get favoriteRestaurants =>
      List.unmodifiable(_favoriteRestaurants);

  bool isFavoriteRestaurant(Restaurant restaurant) =>
      _favoriteRestaurants.any((r) => r.id == restaurant.id);

  void addFavoriteRestaurant(Restaurant restaurant) {
    if (!isFavoriteRestaurant(restaurant)) {
      _favoriteRestaurants.add(restaurant);
      notifyListeners();
    }
  }

  void removeFavoriteRestaurant(Restaurant restaurant) {
    _favoriteRestaurants.removeWhere((r) => r.id == restaurant.id);
    notifyListeners();
  }

  void toggleFavoriteRestaurant(Restaurant restaurant) {
    if (isFavoriteRestaurant(restaurant)) {
      removeFavoriteRestaurant(restaurant);
    } else {
      addFavoriteRestaurant(restaurant);
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

  /// Safely update orders list from outside (like from Supabase)
  void setOrders(List<Order> newOrders) {
    _orders
      ..clear()
      ..addAll(newOrders);
    notifyListeners();
  }

  /// -------------------- PLACE ORDER --------------------
  Future<void> placeOrderInSupabase() async {
    if (_items.isEmpty) return;

    final user = SupabaseService.client.auth.currentUser;
    if (user == null) return;

    // Prepare cart items
    final cartItems = _items.values.map((entry) {
      return {'food_id': entry.dish.id, 'quantity': entry.quantity};
    }).toList();

    final orderId = await SupabaseService.placeOrderInSupabase(
      cartItems,
      total,
    );

    if (orderId != null) {
      // Add to local orders safely
      final newOrder = Order(
        id: orderId,
        items: _items.values.toList(),
        total: total,
        date: DateTime.now(),
      );

      setOrders([..._orders, newOrder]);
      clearCart();
    }
  }

  /// -------------------- RESTAURANTS --------------------
  final List<Restaurant> _restaurants = [];
  bool _isLoadingRestaurants = false;
  List<Restaurant> get restaurants => List.unmodifiable(_restaurants);
  bool get isLoadingRestaurants => _isLoadingRestaurants;

  Future<void> fetchRestaurants() async {
    if (_isLoadingRestaurants) return;
    _isLoadingRestaurants = true;
    notifyListeners();

    try {
      final data = await SupabaseService.getRestaurants();
      _restaurants.clear();
      for (var r in data) {
        _restaurants.add(Restaurant.fromSupabase(r));
      }
    } catch (e) {
      print('Error fetching restaurants: $e');
    }

    _isLoadingRestaurants = false;
    notifyListeners();
  }

  /// -------------------- DISHES --------------------
  final List<Dish> _dishes = [];
  bool _isLoadingDishes = false;
  List<Dish> get dishes => List.unmodifiable(_dishes);

  Future<void> fetchDishesForRestaurant(String restaurantId) async {
    if (_isLoadingDishes) return;
    _isLoadingDishes = true;
    notifyListeners();

    try {
      final data = await SupabaseService.getFoodByRestaurant(restaurantId);
      final fetchedDishes = data.map((d) => Dish.fromSupabase(d)).toList();
      _dishes.removeWhere((d) => d.restaurantId == restaurantId);
      _dishes.addAll(fetchedDishes);
    } catch (e) {
      print('Error fetching dishes: $e');
    }

    _isLoadingDishes = false;
    notifyListeners();
  }

  List<Dish> dishesForRestaurant(String restaurantId) =>
      _dishes.where((d) => d.restaurantId == restaurantId).toList();

  bool get isLoadingDishes => _isLoadingDishes;

  /// -------------------- LOGOUT --------------------
  void logout() {
    userName = '';
    userEmail = '';
    userAvatar = '';
    clearCart();
    _favorites.clear();
    _favoriteRestaurants.clear();
    _addresses.clear();
    _orders.clear();
    _restaurants.clear();
    _dishes.clear();
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
