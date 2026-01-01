import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../app_state.dart'; // for Order type
import 'package:intl/intl.dart'; // for date formatting

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.order});

  final Order order;

  String _statusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return "Pending";
      case OrderStatus.preparing:
        return "Preparing";
      case OrderStatus.onTheWay:
        return "On the way";
      case OrderStatus.delivered:
        return "Delivered";
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM yyyy, HH:mm').format(order.date);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.text,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order #${order.id}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              "Status: ${_statusText(order.status)}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Order Date: $formattedDate",
              style: const TextStyle(color: AppColors.muted),
            ),
            const SizedBox(height: 16),
            const Text(
              "Items:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: order.items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = order.items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${item.quantity}x ${item.dish.name}"),
                        Text("\$${item.total.toStringAsFixed(2)}"),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            const Divider(thickness: 1),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                ),
                Text(
                  "\$${order.total.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
