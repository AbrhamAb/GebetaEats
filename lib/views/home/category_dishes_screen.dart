import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../models/mock_data.dart';
import '../../models/dish.dart';
import '../../theme.dart';

class CategoryDishesScreen extends StatefulWidget {
  const CategoryDishesScreen({super.key, required this.categoryLabel});

  final String categoryLabel;

  @override
  State<CategoryDishesScreen> createState() => _CategoryDishesScreenState();
}

class _CategoryDishesScreenState extends State<CategoryDishesScreen> {
  final Set<String> _favorites = <String>{};

  List<Dish> _collectDishesForCategory(String label) {
    final lower = label.toLowerCase();
    final includeRestaurants = restaurants.where((r) {
      final cats = r.categories.map((c) => c.toLowerCase()).toList();
      if (lower == 'fast food') {
        return cats.any((c) => fastFoodSubcategories.map((s) => s.label.toLowerCase()).contains(c));
      }
      // If the label is a known fast-food subcategory, match restaurants that list it
      if (fastFoodSubcategories.map((s) => s.label.toLowerCase()).contains(lower)) {
        return cats.any((c) => c.toLowerCase() == lower);
      }
      return cats.contains(lower);
    }).toList();

    final List<Dish> dishes = [];
    for (final r in includeRestaurants) {
      final menu = restaurantMenus[r.id] ?? <Dish>[];
      dishes.addAll(menu);
    }

    // If no dishes found for a fast-food subcategory, generate placeholder dishes using the category image
    if (dishes.isEmpty && fastFoodSubcategories.map((s) => s.label.toLowerCase()).contains(lower)) {
      final cat = fastFoodSubcategories.firstWhere((s) => s.label.toLowerCase() == lower);
      final placeholderImage = cat.imageUrl ?? 'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=900&q=80';
      final base = cat.label;
      for (var i = 1; i <= 4; i++) {
        dishes.add(Dish(
          id: 'placeholder_${lower}_$i',
          name: '$base ${i == 1 ? 'Classic' : i == 2 ? 'Special' : i == 3 ? 'Combo' : 'Deluxe'}',
          description: 'Delicious $base with fresh ingredients and signature sauce.',
          price: 6.99 + i.toDouble(),
          imageUrl: placeholderImage,
        ));
      }
    }

    return dishes;
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final dishes = _collectDishesForCategory(widget.categoryLabel);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryLabel),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: dishes.isEmpty
          ? Center(
              child: Text(
                'No dishes found for "${widget.categoryLabel}"',
                style: const TextStyle(color: AppColors.muted),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: dishes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final dish = dishes[index];
                final isFav = _favorites.contains(dish.id);
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                dish.imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(color: Colors.grey.shade300),
                              ),
                            ),
                            Positioned(
                              right: 2,
                              top: 2,
                              child: Material(
                                color: Colors.black26,
                                shape: const CircleBorder(),
                                child: IconButton(
                                  icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.redAccent : Colors.white, size: 18),
                                  onPressed: () {
                                    setState(() {
                                      if (isFav) {
                                        _favorites.remove(dish.id);
                                      } else {
                                        _favorites.add(dish.id);
                                      }
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isFav ? 'Removed from favorites' : 'Added to favorites')));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(dish.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                              const SizedBox(height: 6),
                              Text(dish.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.muted)),
                              const SizedBox(height: 8),
                              Text('\$${dish.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                appState.addDish(dish);
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart')));
                              },
                              style: ElevatedButton.styleFrom(minimumSize: const Size(80, 44)),
                              child: const Text('+ Add'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
