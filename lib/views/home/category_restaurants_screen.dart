import 'package:flutter/material.dart';

import '../../models/mock_data.dart';
import '../../models/restaurant_model.dart';
import '../../theme.dart';
import 'restaurant_card.dart';

class CategoryRestaurantsScreen extends StatelessWidget {
  const CategoryRestaurantsScreen({super.key, required this.categoryLabel});

  final String categoryLabel;

  @override
  Widget build(BuildContext context) {
    // Filter restaurants that list the categoryLabel in their categories.
    final List<RestaurantData> matches = restaurants
        .where((r) => r.categories.any((c) => c.toLowerCase() == categoryLabel.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryLabel),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: matches.isEmpty
          ? Center(
              child: Text(
                'No restaurants found for "$categoryLabel"',
                style: const TextStyle(color: AppColors.muted),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: matches.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final r = matches[index];
                return GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('/restaurant', arguments: r),
                  child: RestaurantCard(restaurant: r),
                );
              },
            ),
    );
  }
}
