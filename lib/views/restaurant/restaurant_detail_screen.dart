import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../models/mock_data.dart';
import '../../theme.dart';
import 'restaurant_header.dart';
import 'restaurant_menu_list.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({super.key, required this.restaurant});

  final RestaurantData restaurant;

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final menu =
        restaurantMenus[widget.restaurant.id] ??
        (restaurantMenus.isNotEmpty ? restaurantMenus.values.first : <Dish>[]);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name), // Improvement
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          RestaurantHeader(restaurant: widget.restaurant),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.muted,
              indicator: BoxDecoration(
                color: AppColors.primary.withAlpha(40),
                borderRadius: BorderRadius.circular(12),
              ),
              labelPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              tabs: const <Widget>[
                Tab(text: 'Menu'),
                Tab(text: 'Info'),
                Tab(text: 'Reviews'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  RestaurantMenuList(menu: menu),
                  const Center(
                    child: Text(
                      'Restaurant info coming soon',
                      style: TextStyle(color: AppColors.muted),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Reviews coming soon',
                      style: TextStyle(color: AppColors.muted),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: appState.totalItems > 0
          ? SizedBox(
              height: 80,
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${appState.totalItems} Items',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '\$${appState.total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/cart'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(130, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text('View Cart'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
