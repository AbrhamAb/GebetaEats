import 'package:flutter/material.dart';
import 'dart:async';
import '../../theme.dart';
import '../../services/supabase_client.dart';

class OrderItem {
  OrderItem({
    required this.title,
    required this.date,
    required this.amount,
    required this.image,
  });

  final String title;
  final String date;
  final double amount;
  final String image;
}

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  Timer? _timer;
  bool _isLoading = true;
  final List<OrderItem> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();

    // Periodically rebuild every 10 seconds to update order status dynamically
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchOrders() async {
    _isLoading = true;
    setState(() {});

    try {
      final data = await SupabaseService.getOrders();

      final List<OrderItem> fetchedOrders = data.map((o) {
        return OrderItem(
          title: "GebetaEats Order",
          date: o['created_at'] ?? '',
          amount: (o['total'] ?? 0).toDouble(),
          image: "", // optional: add restaurant image if available
        );
      }).toList();

      _orders
        ..clear()
        ..addAll(fetchedOrders);
    } catch (e) {
      print("Error fetching orders in OrdersTab: $e");
    }

    _isLoading = false;
    setState(() {});
  }

  /// Returns status text based on how long ago the order was created
  String _statusText(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final diff = DateTime.now().difference(date).inSeconds;

      if (diff < 60) return "Pending";
      if (diff < 180) return "Preparing";
      if (diff < 300) return "On the way";
      return "Delivered";
    } catch (_) {
      return "Unknown";
    }
  }

  /// Returns a human-readable "time ago" string
  String _timeAgo(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final diff = DateTime.now().difference(date);

      if (diff.inSeconds < 60) return "${diff.inSeconds}s ago";
      if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
      if (diff.inHours < 24) return "${diff.inHours}h ago";
      return "${diff.inDays}d ago";
    } catch (_) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Orders",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _orders.isEmpty
                    ? Center(
                        child: Text(
                          "No orders yet",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: _orders.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final order = _orders[index];
                          final status = _statusText(order.date);
                          final timeAgo = _timeAgo(order.date);

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/order-detail',
                                arguments: order,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.text,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Text(
                                        "Order #${index + 1}",
                                        style: const TextStyle(
                                          color: AppColors.muted,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        timeAgo,
                                        style: const TextStyle(
                                          color: AppColors.muted,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Text(
                                        "\$${order.amount.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        status,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
