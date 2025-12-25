import 'package:flutter/material.dart';

import 'app_state.dart';
import 'models/mock_data.dart';
import 'theme.dart';
import 'views/splash/splash_screen.dart';
import 'views/onboarding/onboarding_screen.dart';
// import 'views/auth/login_screen.dart';
import 'views/home/home_screen.dart';
import 'views/restaurant/restaurant_detail_screen.dart';
import 'views/cart/cart_screen.dart';

class GebetaeatsApp extends StatefulWidget {
  const GebetaeatsApp({super.key});

  @override
  State<GebetaeatsApp> createState() => _GebetaeatsAppState();
}

class _GebetaeatsAppState extends State<GebetaeatsApp> {
  final AppState _state = AppState();

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      // case '/login':
      // return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/restaurant':
        final restaurant = settings.arguments is RestaurantData
            ? settings.arguments as RestaurantData
            : restaurants.first;
        return MaterialPageRoute(
          builder: (_) => RestaurantDetailScreen(restaurant: restaurant),
        );
      case '/cart':
        return MaterialPageRoute(builder: (_) => const CartScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
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
