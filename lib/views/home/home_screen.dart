import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebeta_eats/theme.dart';
import 'package:gebeta_eats/views/cart/bloc/cart_bloc.dart';
import 'package:gebeta_eats/views/cart/bloc/cart_state.dart';
import 'package:gebeta_eats/views/home/bloc/home_bloc.dart';
import 'package:gebeta_eats/views/home/bloc/home_event.dart';
import 'package:gebeta_eats/views/home/bloc/home_state.dart';
import 'package:gebeta_eats/views/home/home_tab.dart';
import 'package:gebeta_eats/views/home/placeholder_tab.dart';
import 'package:gebeta_eats/views/profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: state.tabIndex,
              children: [
                HomeTab(
                  onSelectRestaurant: (restaurant) {
                    Navigator.of(context).pushNamed(
                      '/restaurant',
                      arguments: restaurant,
                    );
                  },
                ),
                const PlaceholderTab(title: 'Orders'),
                const PlaceholderTab(title: 'Favorites'),
                const ProfileScreen(),
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
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
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
          floatingActionButton: BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              if (cartState.items.isEmpty) return const SizedBox.shrink();
              return FloatingActionButton.extended(
                onPressed: () => Navigator.of(context).pushNamed('/cart'),
                backgroundColor: AppColors.primary,
                icon: const Icon(Icons.shopping_cart_outlined),
                label: Text('${cartState.items.length}'),
              );
            },
          ),
        );
      },
    );
  }
}
