import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../models/dish_model.dart';
import '../../theme.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({super.key, required this.dish});

  final Dish dish;

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int quantity = 1;

  void _increment() {
    setState(() {
      quantity += 1;
    });
  }

  void _decrement() {
    if (quantity > 1) {
      setState(() {
        quantity -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final dish = widget.dish;
    final isFav = appState.isFavorite(dish);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.text,
        title: Text(
          dish.name,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        elevation: 0,

        /// ❤️ HEART IN APPBAR
        actions: [
          IconButton(
            onPressed: () {
              appState.toggleFavorite(dish);
              setState(() {}); // update UI immediately
            },
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : AppColors.muted,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Dish Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                dish.imageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : Container(color: Colors.grey.shade200, height: 220),
                errorBuilder: (_, __, ___) => Container(
                  width: double.infinity,
                  height: 220,
                  color: Colors.grey.shade300,
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    color: AppColors.muted,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Dish Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dish.description,
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Price + Quantity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${(dish.price * quantity).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      // Quantity Selector
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: _decrement,
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              '$quantity',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              onPressed: _increment,
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Add to Cart Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    for (int i = 0; i < quantity; i++) {
                      appState.addDish(dish);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Add $quantity to Cart (\$${(dish.price * quantity).toStringAsFixed(2)})',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
