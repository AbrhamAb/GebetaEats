import 'package:flutter/material.dart';
import '../../theme.dart';
import 'order_card.dart';
import 'order_item_model.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = <OrderItem>[
      OrderItem(
        title: 'The Spicy Spoon',
        date: 'October 18, 2023',
        amount: 25.50,
        image:
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=300&q=80',
      ),
      OrderItem(
        title: 'Gebeta Cafe & Bakery',
        date: 'October 15, 2023',
        amount: 12.00,
        image:
            'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=300&q=80',
      ),
      OrderItem(
        title: 'Pizza Paradise',
        date: 'October 10, 2023',
        amount: 35.75,
        image:
            'https://images.unsplash.com/photo-1548366086-7e45b3f6b90c?auto=format&fit=crop&w=300&q=80',
      ),
      OrderItem(
        title: 'Sushi Delights',
        date: 'October 05, 2023',
        amount: 48.00,
        image:
            'https://images.unsplash.com/photo-1546069901-eacef0df6022?auto=format&fit=crop&w=300&q=80',
      ),
      OrderItem(
        title: 'Vegan Green',
        date: 'September 28, 2023',
        amount: 20.00,
        image:
            'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=300&q=80',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.text,
        title: const Text(
          'Order History',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.filter_alt_outlined, color: AppColors.text),
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ListView.separated(
            itemCount: orders.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) => OrderCard(order: orders[index]),
          ),
        ),
      ),
    );
  }
}
