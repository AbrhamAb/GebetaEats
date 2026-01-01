import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../theme.dart';
import '/models/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final isFav = appState.isFavoriteRestaurant(restaurant);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    restaurant.heroImage,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: Colors.grey[200]),
                  ),
                ),
              ),

              /// ❤️ Favorite Button
              Positioned(
                right: 12,
                top: 12,
                child: GestureDetector(
                  onTap: () => appState.toggleFavoriteRestaurant(restaurant),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        restaurant.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    const Icon(Icons.star, size: 18, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '${restaurant.rating}',
                      style: const TextStyle(
                        color: AppColors.text,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: AppColors.muted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${restaurant.deliveryTime} min',
                      style: const TextStyle(color: AppColors.muted),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.directions_bike,
                      size: 16,
                      color: AppColors.muted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '\$${restaurant.deliveryFee}',
                      style: const TextStyle(color: AppColors.muted),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: restaurant.isOpen
                        ? const Color(0xFFEFF7EF)
                        : const Color(0xFFF3F4F6),
                  ),
                  child: Text(
                    restaurant.isOpen ? 'Open now' : 'Closed',
                    style: TextStyle(
                      color: restaurant.isOpen
                          ? AppColors.primary
                          : AppColors.muted,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
