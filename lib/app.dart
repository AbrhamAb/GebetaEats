import 'package:flutter/material.dart';

import 'app_state.dart';
import 'models/mock_data.dart';
import 'theme.dart';
import 'views/splash/splash_screen.dart';
import 'views/onboarding/onboarding_screen.dart';
import 'views/home/home_screen.dart';
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
    // Minimal replacement for AppStateScope
    return _AppStateProvider(
      state: _state,
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

// Minimal state provider
class _AppStateProvider extends InheritedWidget {
  final AppState state;

  const _AppStateProvider({
    required this.state,
    required super.child,
  });

  static AppState of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<_AppStateProvider>();
    assert(provider != null, 'No AppState found in context');
    return provider!.state;
  }

  @override
  bool updateShouldNotify(covariant _AppStateProvider oldWidget) =>
      oldWidget.state != state;
}
