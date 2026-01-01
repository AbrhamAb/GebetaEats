import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../theme.dart';
import 'featured_card.dart';
import 'restaurant_card.dart';
import '/models/restaurant_model.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key, required this.onSelectRestaurant});

  final void Function(Restaurant restaurant) onSelectRestaurant;

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Restaurant> filteredRestaurants(AppState appState) {
    return appState.restaurants.where((r) {
      final matchesSearch = r.name.toLowerCase().contains(_searchQuery);
      final matchesCategory =
          _selectedCategory == null ||
          r.categories
              .map((c) => c.toLowerCase())
              .contains(_selectedCategory!.toLowerCase());
      return matchesSearch && matchesCategory;
    }).toList();
  }

  /// ✅ Convert to a normal method
  List<String> allCategories(AppState appState) {
    final categories = <String>{};
    for (var r in appState.restaurants) {
      categories.addAll(r.categories);
    }
    return categories.toList();
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    return appState.isLoadingRestaurants
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// -------------------- SEARCH BAR --------------------
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _searchController,
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
                      icon: const Icon(
                        Icons.location_pin,
                        color: AppColors.primary,
                      ),
                      label: const Text(
                        'Bahir Dar, ETH',
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

                // ------------------ CATEGORIES + ALL ------------------
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: allCategories(appState).length + 1,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final categories = allCategories(appState);

                      // ALL CATEGORY
                      if (index == 0) {
                        final bool isSelected = _selectedCategory == null;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = null;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.white,
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
                                child: Icon(
                                  Icons.list,
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "All",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.text,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      // NORMAL CATEGORY
                      final label = categories[index - 1];
                      final isSelected = _selectedCategory == label;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = isSelected
                                ? null
                                : label; // toggle
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.white,
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
                              child: Icon(
                                Icons.fastfood,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              label,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.text,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
                    itemCount: filteredRestaurants(appState).length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final restaurant = filteredRestaurants(appState)[index];
                      return GestureDetector(
                        onTap: () => widget.onSelectRestaurant(restaurant),
                        child: FeaturedCard(restaurant: restaurant),
                      );
                    },
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

                filteredRestaurants(appState).isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text(
                            'No restaurants match your search 😅',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.muted,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredRestaurants(appState).length,
                        itemBuilder: (context, index) {
                          final restaurant = filteredRestaurants(
                            appState,
                          )[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: GestureDetector(
                              onTap: () =>
                                  widget.onSelectRestaurant(restaurant),
                              child: RestaurantCard(restaurant: restaurant),
                            ),
                          );
                        },
                      ),

                const SizedBox(height: 24),
              ],
            ),
          );
  }
}
