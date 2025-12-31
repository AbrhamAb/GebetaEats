import 'package:flutter/foundation.dart';
import '../models/mock_data.dart';

class FavoritesProvider extends ChangeNotifier {
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
}
