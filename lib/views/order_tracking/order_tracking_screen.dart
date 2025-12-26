import 'package:flutter/material.dart';

import '../../theme.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = <_TrackingStep>[
      _TrackingStep(
        title: 'Order Received',
        subtitle: 'Your order has been placed successfully.',
        icon: Icons.restaurant,
        isActive: true,
      ),
      _TrackingStep(
        title: 'Food Being Prepared',
        subtitle: 'The restaurant is now preparing your delicious meal.',
        icon: Icons.dinner_dining,
        isActive: true,
      ),
      _TrackingStep(
        title: 'Out for Delivery',
        subtitle: 'Your food is on its way with our driver.',
        icon: Icons.pedal_bike,
        isActive: true,
      ),
      _TrackingStep(
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
            children: <Widget>[
              _EtaCard(title: 'Estimated Delivery Time', eta: '15-20 min'),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: _TrackingTimeline(steps: steps),
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
              const _VisilyStamp(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EtaCard extends StatelessWidget {
  const _EtaCard({required this.title, required this.eta});

  final String title;
  final String eta;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            eta,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackingTimeline extends StatelessWidget {
  const _TrackingTimeline({required this.steps});

  final List<_TrackingStep> steps;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isOdd) {
          final isDone =
              steps[index ~/ 2].isActive && steps[(index ~/ 2) + 1].isActive;
          return Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Container(
              height: 38,
              width: 3,
              color: isDone ? AppColors.primary : AppColors.border,
            ),
          );
        }
        final step = steps[index ~/ 2];
        return _TrackingTile(step: step);
      }),
    );
  }
}

class _TrackingTile extends StatelessWidget {
  const _TrackingTile({required this.step});

  final _TrackingStep step;

  @override
  Widget build(BuildContext context) {
    final Color iconColor = step.isActive ? Colors.white : AppColors.muted;
    final Color bgColor = step.isActive
        ? AppColors.primary
        : const Color(0xFFF3F4F6);
    final Color textColor = step.isActive ? AppColors.text : AppColors.muted;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(step.icon, color: iconColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                step.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                step.subtitle,
                style: TextStyle(color: AppColors.muted, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrackingStep {
  _TrackingStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isActive,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isActive;
}

class _VisilyStamp extends StatelessWidget {
  const _VisilyStamp();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Text(
          'Made with ',
          style: TextStyle(color: AppColors.muted, fontSize: 11),
        ),
        Icon(Icons.bolt, size: 16, color: AppColors.primaryDark),
        SizedBox(width: 4),
        Text('Visily', style: TextStyle(color: AppColors.muted, fontSize: 11)),
      ],
    );
  }
}
