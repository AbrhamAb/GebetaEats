import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../app_state.dart';
import 'total_row.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          TotalRow(label: 'Subtotal', value: appState.subtotal),
          const SizedBox(height: 8),
          TotalRow(label: 'Delivery Fee', value: appState.deliveryFee),
          const Divider(height: 24, thickness: 1),
          TotalRow(
            label: 'Grand Total',
            value: appState.total,
            isBold: true,
            valueColor: AppColors.primary,
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Icon(Icons.local_shipping_outlined, color: AppColors.primary),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Pay on Delivery available for this order.',
                  style: TextStyle(color: AppColors.muted),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
