import 'package:flutter/material.dart';
import '../../widgets/category_card.dart';
import '../../widgets/featured_restaurant_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Search bar
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Later: navigate to SearchScreen
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(
                          'Search food or restaurants',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Location
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Deliver to',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'New York',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories Section
            const Text(
              'Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 100, // card height
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryCard(icon: Icons.fastfood, label: 'Burgers'),
                  CategoryCard(icon: Icons.local_pizza, label: 'Pizza'),
                  CategoryCard(icon: Icons.coffee, label: 'Coffee'),
                  CategoryCard(
                    icon: Icons.ramen_dining,
                    label: 'Traditional Food',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const SizedBox(height: 24),
            const Text(
              'Featured Restaurants',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  FeaturedRestaurantCard(
                    imageUrl:
                        'https://images.unsplash.com/photo-1555992336-03a23c4c15b6',
                    name: 'Burger King',
                    rating: 4.5,
                    deliveryTime: '25-30 mins',
                    priceRange: '\$',
                  ),
                  FeaturedRestaurantCard(
                    imageUrl:
                        'https://images.unsplash.com/photo-1600891964599-f61ba0e24092',
                    name: 'Pizza Palace',
                    rating: 4.2,
                    deliveryTime: '20-25 mins',
                    priceRange: '\$\$',
                  ),
                  FeaturedRestaurantCard(
                    imageUrl:
                        'https://images.unsplash.com/photo-1617196033552-2303a30b0f5f',
                    name: 'Coffee Corner',
                    rating: 4.8,
                    deliveryTime: '15-20 mins',
                    priceRange: '\$',
                  ),
                ],
              ),
            ),

            Text(
              'All Restaurants',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
