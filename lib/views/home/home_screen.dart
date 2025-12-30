import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_state.dart';
import '../../theme.dart';

import '../home/home_tab.dart';
import '../home/placeholder_tab.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Note: We access AppStateScope for cart total, but use HomeBloc for tab selection.
    final appState = AppStateScope.of(context);
    
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: state.tabIndex,
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
            currentIndex: state.tabIndex,
            onTap: (index) {
              context.read<HomeBloc>().add(HomeTabChanged(index));
            },
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
      },
    );
  }
}
