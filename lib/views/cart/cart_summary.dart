import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme.dart';
import 'total_row.dart';
import '../cart/bloc/cart_bloc.dart';
import '../cart/bloc/cart_state.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        // Compute subtotal from CartState
        final subtotal = state.items.values.fold<double>(
          0,
          (sum, item) => sum + (item.price * item.quantity),
        );

        const deliveryFee = 5.0; // Or calculate dynamically
        final total = subtotal + deliveryFee;

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
              TotalRow(label: 'Subtotal', value: subtotal),
              const SizedBox(height: 8),
              TotalRow(label: 'Delivery Fee', value: deliveryFee),
              const Divider(height: 24, thickness: 1),
              TotalRow(
                label: 'Grand Total',
                value: total,
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
      },
    );
  }
}
