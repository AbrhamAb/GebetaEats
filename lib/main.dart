import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gebeta_eats/views/cart/bloc/cart_bloc.dart';
import 'package:gebeta_eats/views/checkout/bloc/checkout_bloc.dart';
import 'package:gebeta_eats/views/home/bloc/home_bloc.dart';
import 'package:gebeta_eats/views/onboarding/bloc/onboarding_bloc.dart';
import 'package:gebeta_eats/views/orders/bloc/orders_bloc.dart';
import 'package:gebeta_eats/views/orders/bloc/orders_event.dart';
import 'app.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (_) => CartBloc(),
        ),
        BlocProvider<CheckoutBloc>(
          create: (context) => CheckoutBloc(
            cartBloc: context.read<CartBloc>(),
          ),
        ),
        BlocProvider<OrdersBloc>(
          create: (_) => OrdersBloc()..add(OrdersStarted()),
        ),
        BlocProvider<OnboardingBloc>(
          create: (_) => OnboardingBloc(),
        ),
        // add more blocs here later
      ],
      child: const GebetaEatsApp(),
    ),
  );
}
