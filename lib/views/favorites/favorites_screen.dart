import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../models/dish_model.dart';
import '../../models/restaurant_model.dart';
import '../restaurant/food_details_screen.dart';
import '../restaurant/restaurant_detail_screen.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    final dishFavorites = appState.favorites;
    final restaurantFavorites = appState.favoriteRestaurants;

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Column(
          children: [
            const TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.red,
              tabs: [
                Tab(text: "Foods"),
                Tab(text: "Restaurants"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  /// ---------- FOODS TAB ----------
                  dishFavorites.isEmpty
                      ? const _FavoritesEmptyState(
                          message: "No Favorite Foods Yet",
                          sub: "Foods you like will appear here ❤️",
                        )
                      : _FavoriteFoodList(favorites: dishFavorites),

                  /// ---------- RESTAURANTS TAB ----------
                  restaurantFavorites.isEmpty
                      ? const _FavoritesEmptyState(
                          message: "No Favorite Restaurants Yet",
                          sub: "Restaurants you like will appear here 🏪",
                        )
                      : _FavoriteRestaurantList(favorites: restaurantFavorites),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =================================================
/// SHARED EMPTY STATE
/// =================================================
class _FavoritesEmptyState extends StatelessWidget {
  final String message;
  final String sub;

  const _FavoritesEmptyState({
    super.key,
    required this.message,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 14),
            Text(
              message,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              sub,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

/// =================================================
/// FOOD FAVORITES LIST
/// =================================================
class _FavoriteFoodList extends StatelessWidget {
  final List<Dish> favorites;

  const _FavoriteFoodList({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final item = favorites[index];

        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FoodDetailsScreen(dish: item),
                ),
              );
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text("ETB ${item.price.toStringAsFixed(2)}"),
            trailing: IconButton(
              onPressed: () => appState.toggleFavorite(item),
              icon: const Icon(Icons.favorite, color: Colors.red),
            ),
          ),
        );
      },
    );
  }
}

/// =================================================
/// RESTAURANT FAVORITES LIST
/// =================================================
class _FavoriteRestaurantList extends StatelessWidget {
  final List<Restaurant> favorites;

  const _FavoriteRestaurantList({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final r = favorites[index];

        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RestaurantDetailScreen(restaurant: r),
                ),
              );
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                r.heroImage,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              r.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              r.categories.join(", "),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () => appState.toggleFavoriteRestaurant(r),
              icon: const Icon(Icons.favorite, color: Colors.red),
            ),
          ),
        );
      },
    );
  }
}
