import 'package:flutter/material.dart';

import '../../theme.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.text,
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 12),
              const Text(
                'Confirm Your Order',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Delivery Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.location_pin, color: AppColors.primary),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '123 Main Street, Apt 4B, Anytown, US.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/order-tracking'),
                  child: const Text('Confirm Order'),
                ),
              ),
              const SizedBox(height: 10),
              const _VisilyStamp(),
            ],
          ),
        ),
      ),
    );
  }
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
