import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../theme.dart';

import '../home/home_tab.dart';
import '../orders/orders_tab.dart';
import '../favorites/favorites_screen.dart';
import '../profile/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;
  bool _hasFetched = false; // Ensure fetchRestaurants is called only once

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appState = AppStateScope.of(context);

    if (!_hasFetched) {
      _hasFetched = true;
      appState.fetchRestaurants(); // Fetch restaurants from Supabase
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _tabIndex,
          children: <Widget>[
            HomeTab(
              onSelectRestaurant: (restaurant) {
                Navigator.of(
                  context,
                ).pushNamed('/restaurant', arguments: restaurant);
              },
            ),
            const OrdersTab(),
            const FavoritesTab(),
            const ProfileTab(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (index) => setState(() => _tabIndex = index),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.muted,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
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
