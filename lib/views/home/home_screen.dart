import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../theme.dart';

import '../home/home_tab.dart';
import '../home/placeholder_tab.dart';

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
            HomeTab(
              onSelectRestaurant: (restaurant) {
                Navigator.of(
                  context,
                ).pushNamed('/restaurant', arguments: restaurant);
              },
            ),
            const PlaceholderTab(title: 'Orders'),
            const PlaceholderTab(title: 'Favorites'),
            const PlaceholderTab(title: 'Profile'),
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
