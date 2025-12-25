import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../models/mock_data.dart';
import '../../theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _tabIndex,
          children: <Widget>[
            _HomeTab(
              onSelectRestaurant: (restaurant) {
                Navigator.of(
                  context,
                ).pushNamed('/restaurant', arguments: restaurant);
              },
            ),
            const _PlaceholderTab(title: 'Orders'),
            const _PlaceholderTab(title: 'Favorites'),
            const _PlaceholderTab(title: 'Profile'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (index) => setState(() => _tabIndex = index),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.muted,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: appState.totalItems > 0
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.of(context).pushNamed('/cart'),
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.shopping_cart_outlined),
              label: Text('${appState.totalItems}'),
            )
          : null,
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab({required this.onSelectRestaurant});

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
                  child: _FeaturedCard(restaurant: restaurant),
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
                      child: _RestaurantCard(restaurant: restaurant),
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

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.restaurant});

  final RestaurantData restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.network(restaurant.heroImage, fit: BoxFit.cover),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Colors.transparent, Colors.black54],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        '${restaurant.rating}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        restaurant.eta,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.directions_bike,
                        size: 16,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        restaurant.deliveryFee,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  const _RestaurantCard({required this.restaurant});

  final RestaurantData restaurant;

  @override
  Widget build(BuildContext context) {
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
                  child: Image.network(restaurant.heroImage, fit: BoxFit.cover),
                ),
              ),
              if (restaurant.isFreeDelivery)
                Positioned(
                  left: 12,
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Free Delivery',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              Positioned(
                right: 12,
                top: 12,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.star_border, color: Colors.amber),
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
                      restaurant.eta,
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
                      restaurant.deliveryFee,
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

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.muted,
        ),
      ),
    );
  }
}
