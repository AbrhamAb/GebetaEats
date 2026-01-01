import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../app_state.dart';
import 'eta_card.dart';
import 'tracking_tile.dart';
import 'tracking_step.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    if (appState.orders.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Order Tracking'),
          backgroundColor: Colors.white,
          foregroundColor: AppColors.text,
        ),
        body: const Center(child: Text("No active order to track 😅")),
      );
    }

    final order = appState.orders.last;
    final status = order.status;

    // Updated step activation logic to match OrdersTab status progression
    final steps = <TrackingStep>[
      TrackingStep(
        title: 'Order Received',
        subtitle: 'Your order has been placed successfully.',
        icon: Icons.restaurant,
        isActive: true,
      ),
      TrackingStep(
        title: 'Food Being Prepared',
        subtitle: 'The restaurant is preparing your meal.',
        icon: Icons.dinner_dining,
        isActive:
            status == OrderStatus.preparing ||
            status == OrderStatus.onTheWay ||
            status == OrderStatus.delivered,
      ),
      TrackingStep(
        title: 'Out for Delivery',
        subtitle: 'Your food is on the way.',
        icon: Icons.pedal_bike,
        isActive:
            status == OrderStatus.onTheWay || status == OrderStatus.delivered,
      ),
      TrackingStep(
        title: 'Delivered',
        subtitle: 'Enjoy your GebetaEats meal!',
        icon: Icons.check_circle_outline,
        isActive: status == OrderStatus.delivered,
      ),
    ];

    final diff = DateTime.now().difference(order.date).inMinutes;
    String eta = "15–20 min";
    if (diff < 1)
      eta = "20–25 min";
    else if (diff < 3)
      eta = "15–20 min";
    else if (diff < 5)
      eta = "10–15 min";
    else
      eta = "Arriving now";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.text,
        title: const Text(
          'Order Tracking',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EtaCard(title: 'Estimated Delivery Time', eta: eta),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: List.generate(steps.length * 2 - 1, (index) {
                    if (index.isOdd) {
                      final left = steps[index ~/ 2];
                      final right = steps[(index ~/ 2) + 1];
                      final isDone = left.isActive && right.isActive;
                      return Padding(
                        padding: const EdgeInsets.only(left: 28),
                        child: Container(
                          height: 38,
                          width: 3,
                          color: isDone ? AppColors.primary : AppColors.border,
                        ),
                      );
                    }
                    return TrackingTile(step: steps[index ~/ 2]);
                  }),
                ),
              ),
              const SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil('/home', (route) => route.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3F4F6),
                    foregroundColor: AppColors.text,
                  ),
                  child: const Text(
                    'Back to Restaurants',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
