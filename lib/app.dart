import 'package:flutter/material.dart';

import 'app_state.dart';
import 'models/mock_data.dart';
import 'theme.dart';
import 'views/splash/splash_screen.dart';
import 'views/onboarding/onboarding_screen.dart';
import 'views/auth/login_screen.dart';
import 'views/home/home_screen.dart';
import 'views/home/category_list_screen.dart';
import 'views/home/category_restaurants_screen.dart';
import 'views/home/category_dishes_screen.dart';
import 'views/restaurant/restaurant_detail_screen.dart';
import 'views/cart/cart_screen.dart';
import 'models/restaurant_model.dart';

class GebetaEatsApp extends StatefulWidget {
  const GebetaEatsApp({super.key});

  @override
  State<GebetaEatsApp> createState() => _GebetaEatsAppState();
}

class _GebetaEatsAppState extends State<GebetaEatsApp> {
  final AppState _state = AppState();

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/category':
        final label = settings.arguments is String ? settings.arguments as String : '';
        if (label == 'Fast Food') {
          return MaterialPageRoute(builder: (_) => CategoryListScreen(categoryLabel: label));
        }
        // For other main categories, show restaurants filtered by that category.
        return MaterialPageRoute(builder: (_) => CategoryRestaurantsScreen(categoryLabel: label));
      case '/category/restaurants':
        final label = settings.arguments is String ? settings.arguments as String : '';
        return MaterialPageRoute(builder: (_) => CategoryRestaurantsScreen(categoryLabel: label));
      case '/category/dishes':
        final label2 = settings.arguments is String ? settings.arguments as String : '';
        return MaterialPageRoute(builder: (_) => CategoryDishesScreen(categoryLabel: label2));
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/restaurant':
        // If a RestaurantData instance was passed in, use it.
        // Otherwise default to the first restaurant from sample data when available.
        RestaurantData? restaurant;
        if (settings.arguments is RestaurantData) {
          restaurant = settings.arguments as RestaurantData;
        } else if (restaurants.isNotEmpty) {
          restaurant = restaurants.first;
        }

        if (restaurant == null) {
          return MaterialPageRoute(builder: (_) => const SplashScreen());
        }

        return MaterialPageRoute(
          builder: (_) => RestaurantDetailScreen(restaurant: restaurant!),
        );
      case '/cart':
        return MaterialPageRoute(builder: (_) => const CartScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Provide AppState using the canonical `AppStateScope` from `app_state.dart`.
    return AppStateScope(
      notifier: _state,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GebetaEats',
        theme: buildTheme(),
        onGenerateRoute: _onGenerateRoute,
        initialRoute: '/',
      ),
    );
  }
}
// `AppStateScope` from `lib/app_state.dart` is used instead of a custom provider.
