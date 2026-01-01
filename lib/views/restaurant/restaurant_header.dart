import 'package:flutter/material.dart';
import '../../models/restaurant_model.dart';
import '../../theme.dart';

class RestaurantHeader extends StatelessWidget {
  const RestaurantHeader({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              restaurant.heroImage,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) => progress == null
                  ? child
                  : Container(color: Colors.grey.shade200),
              errorBuilder: (_, __, ___) =>
                  Container(color: Colors.grey.shade300),
            ),
          ),

          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black54],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Info Overlay
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand / Verification (optional)
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.check, color: AppColors.primaryDark),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'GebetaEats',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Restaurant Name
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),

                // Rating / ETA / Delivery Fee
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      restaurant.rating.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${restaurant.deliveryTime} min',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.directions_bike,
                      size: 16,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '\$${restaurant.deliveryFee}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
