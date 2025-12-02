import 'package:flutter/material.dart';

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
      // home: const HomeScreen(),
      home: Scaffold(
        appBar: AppBar(title: const Text('GebetaEats')),
        body: const Center(child: Text('Hello, GebetaEats!')),
      ),
    );
  }
}
