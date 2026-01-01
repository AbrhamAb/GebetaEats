import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../models/dish_model.dart';
import '../../theme.dart';

import 'food_details_screen.dart';

class RestaurantMenuList extends StatelessWidget {
  const RestaurantMenuList({super.key, required this.menu});

  final List<Dish> menu;

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    if (menu.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.restaurant_menu, size: 40, color: AppColors.muted),
            SizedBox(height: 8),
            Text('Menu coming soon', style: TextStyle(color: AppColors.muted)),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: menu.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final dish = menu[index];
        return _MenuItemTile(dish: dish, appState: appState);
      },
    );
  }
}

class _MenuItemTile extends StatelessWidget {
  const _MenuItemTile({required this.dish, required this.appState});

  final Dish dish;
  final AppState appState;

  @override
  Widget build(BuildContext context) {
    final isFav = appState.isFavorite(dish);

    return InkWell(
      onTap: () => Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => FoodDetailsScreen(dish: dish))),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              child: Image.network(
                dish.imageUrl,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : Container(
                        width: 110,
                        height: 110,
                        color: Colors.grey.shade200,
                      ),
                errorBuilder: (_, __, ___) => Container(
                  width: 110,
                  height: 110,
                  color: Colors.grey.shade300,
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    color: AppColors.muted,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            dish.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.text,
                            ),
                          ),
                        ),

                        /// ❤️ SMALL HEART BUTTON
                        GestureDetector(
                          onTap: () {
                            appState.toggleFavorite(dish);
                          },
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : AppColors.muted,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      dish.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.muted),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '\$${dish.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () => appState.addDish(dish),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(80, 42),
                          ),
                          child: const Text('+   Add'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
