import 'package:flutter/material.dart';

import 'models/restaurant_model.dart';
import 'theme.dart';
import 'views/splash/splash_screen.dart';
import 'views/onboarding/onboarding_screen.dart';
import 'views/auth/login_screen.dart';
import 'views/auth/register_screen.dart';
import 'views/home/home_screen.dart';
import 'views/restaurant/restaurant_detail_screen.dart';
import 'views/cart/cart_screen.dart';
import 'views/checkout/checkout_screen.dart';
import 'views/order_tracking/order_tracking_screen.dart';
import 'views/orders/order_history_screen.dart';
import 'views/orders/order_detail_screen.dart';

import 'app_state.dart'; // to access AppState, Restaurant, Order

class GebetaeatsApp extends StatelessWidget {
  const GebetaeatsApp({super.key});

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case '/restaurant':
        return MaterialPageRoute(
          builder: (context) {
            final appState = AppStateScope.of(context);
            Restaurant restaurant;

            if (settings.arguments != null &&
                settings.arguments is Restaurant) {
              restaurant = settings.arguments as Restaurant;
            } else if (appState.restaurants.isNotEmpty) {
              restaurant = appState.restaurants.first;
            } else {
              // fallback dummy restaurant if nothing is loaded
              restaurant = Restaurant(
                id: '0',
                name: 'Unknown Restaurant',
                heroImage: '',
                rating: 0.0,
                eta: '0 min',
                deliveryFee: '0',
                deliveryTime: 0,
                categories: [],
                isOpen: false, // added required parameter
              );
            }

            return RestaurantDetailScreen(restaurant: restaurant);
          },
        );

      case '/cart':
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case '/checkout':
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case '/order-tracking':
        return MaterialPageRoute(builder: (_) => const OrderTrackingScreen());
      case '/order-history':
        return MaterialPageRoute(builder: (_) => const OrderHistoryScreen());
      case '/order-detail':
        final order = settings.arguments as Order;
        return MaterialPageRoute(
          builder: (_) => OrderDetailScreen(order: order),
        );

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GebetaEats',
      theme: buildTheme(),
      onGenerateRoute: _onGenerateRoute,
      initialRoute: '/',
    );
  }
}
