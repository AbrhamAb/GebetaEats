import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../models/order_status.dart';
import '../../theme.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    if (appState.orders.isEmpty) {
      return const Center(
        child: Text(
          'No orders yet',
          style: TextStyle(color: AppColors.muted),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: appState.orders.length,
      itemBuilder: (context, index) {
        final order = appState.orders[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 6),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.restaurant.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: _progress(order.status),
                color: AppColors.primary,
                backgroundColor: AppColors.border,
              ),
              const SizedBox(height: 8),
              Text(
                order.status.label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double _progress(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 0.0;
      case OrderStatus.placed:
        return 0.33;
      case OrderStatus.completed:
        return 1.0;
      case OrderStatus.cancelled:
        return 0.0;
    }
  }
}
