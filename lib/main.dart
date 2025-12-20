import 'package:flutter/material.dart';
// import 'src/screens/home/home_screen.dart';
import 'src/screens/splash/splash_screen.dart';

void main() {
  runApp(const GebetaEatsApp());
}

class GebetaEatsApp extends StatelessWidget {
  const GebetaEatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GebetaEats',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}
