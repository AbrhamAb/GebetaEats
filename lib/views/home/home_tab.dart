import 'package:flutter/material.dart';
import '../../models/mock_data.dart';
import '../../theme.dart';
import 'featured_card.dart';
import 'restaurant_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key, required this.onSelectRestaurant});

  final void Function(RestaurantData restaurant) onSelectRestaurant;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for restaurants',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.muted,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.location_pin, color: AppColors.primary),
                label: const Text(
                  'New York, USA',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final label = categories[index % categories.length];
                return Column(
                  children: <Widget>[
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.fastfood,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemCount: categories.length,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Featured Restaurants',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 210,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index % restaurants.length];
                return GestureDetector(
                  onTap: () => onSelectRestaurant(restaurant),
                  child: FeaturedCard(restaurant: restaurant),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemCount: restaurants.length,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'All Restaurants',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: restaurants
                .map(
                  (restaurant) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: GestureDetector(
                      onTap: () => onSelectRestaurant(restaurant),
                      child: RestaurantCard(restaurant: restaurant),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
