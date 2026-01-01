import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../theme.dart';
import '../../models/dish_model.dart';
import '../../services/supabase_client.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  bool _isLoading = true;
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final appState = AppStateScope.of(context);

    try {
      // Fetch orders from Supabase
      final fetchedOrders = await SupabaseService.getOrders();

      // Map Supabase rows to Order objects
      final List<Order> ordersList = fetchedOrders.map((o) {
        final items = <CartEntry>[];

        // Map order_items → CartEntry
        if (o['order_items'] != null) {
          for (var item in o['order_items']) {
            final food = item['food'];
            items.add(
              CartEntry(
                dish: Dish.fromSupabase(food),
                quantity: item['quantity'] ?? 1,
              ),
            );
          }
        }

        return Order(
          id: o['id'].toString(),
          items: items,
          total: (o['total'] ?? 0).toDouble(),
          date: DateTime.parse(
            o['created_at'] ?? DateTime.now().toIso8601String(),
          ),
        );
      }).toList();

      // Only keep delivered orders
      _orders = ordersList
          .where((o) => o.status == OrderStatus.delivered)
          .toList();
    } catch (e) {
      print('Error fetching orders from Supabase: $e');
      _orders = [];
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.text,
        title: const Text(
          'Order History',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: _orders.isEmpty
                  ? const Center(
                      child: Text(
                        "No past orders",
                        style: TextStyle(
                          color: AppColors.muted,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: _orders.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final order = _orders[index];
                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(color: AppColors.border),
                          ),
                          title: Text(
                            "Order #${order.id}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: AppColors.text,
                            ),
                          ),
                          subtitle: const Text(
                            "Delivered",
                            style: TextStyle(color: AppColors.muted),
                          ),
                          trailing: Text(
                            "\$${order.total.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/order-detail',
                              arguments: order,
                            );
                          },
                        );
                      },
                    ),
            ),
    );
  }
}
