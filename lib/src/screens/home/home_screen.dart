import 'package:flutter/material.dart';
import '../../widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // simple local categories for now
  final List<Map<String, String>> categories = [
    {'name': 'Ethiopian', 'image': 'https://i.imgur.com/8UfI2aJ.png'},
    {'name': 'Burgers', 'image': 'https://i.imgur.com/EfJ7o2f.png'},
    {'name': 'Pizza', 'image': 'https://i.imgur.com/YpCzWkB.png'},
    {'name': 'Drinks', 'image': 'https://i.imgur.com/GiFRZHV.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GebetaEats'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  final c = categories[index];
                  return CategoryCard(
                    name: c['name']!,
                    imageUrl: c['image']!,
                    onTap: () {
                      // placeholder tap — we'll implement navigation later
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tapped ${c['name']}')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
