import 'package:flutter/material.dart';
import '../../theme.dart';
import 'eta_card.dart';
import 'tracking_tile.dart';
import 'tracking_step.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = <TrackingStep>[
      TrackingStep(
        title: 'Order Received',
        subtitle: 'Your order has been placed successfully.',
        icon: Icons.restaurant,
        isActive: true,
      ),
      TrackingStep(
        title: 'Food Being Prepared',
        subtitle: 'The restaurant is now preparing your delicious meal.',
        icon: Icons.dinner_dining,
        isActive: true,
      ),
      TrackingStep(
        title: 'Out for Delivery',
        subtitle: 'Your food is on its way with our driver.',
        icon: Icons.pedal_bike,
        isActive: true,
      ),
      TrackingStep(
        title: 'Delivered',
        subtitle: 'Enjoy your GebetaEats meal!',
        icon: Icons.check_circle_outline,
        isActive: false,
      ),
    ];

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
              const EtaCard(title: 'Estimated Delivery Time', eta: '15-20 min'),
              const SizedBox(height: 18),
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
                      final isDone =
                          steps[index ~/ 2].isActive &&
                          steps[(index ~/ 2) + 1].isActive;
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
