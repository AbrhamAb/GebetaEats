import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebeta_eats/views/cart/bloc/cart_state.dart';
import 'package:gebeta_eats/views/checkout/bloc/checkout_bloc.dart';
import 'package:gebeta_eats/views/checkout/bloc/checkout_event.dart';
import 'package:gebeta_eats/views/checkout/bloc/checkout_state.dart';

import '../../theme.dart';
import '../../views/cart/bloc/cart_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.read<CartBloc>();

    return BlocProvider(
      create: (_) => CheckoutBloc(cartBloc: cartBloc),
      child: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state.status == CheckoutStatus.success) {
            Navigator.of(context).pushNamed('/order-tracking');
            context.read<CheckoutBloc>().add(ConfirmOrder()); // reset if needed
          } else if (state.status == CheckoutStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Order failed')),
            );
          }
        },
        builder: (context, state) {
          final cartState = cartBloc.state;
          final entries = cartState.items.values.toList();

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
                child: entries.isEmpty
                    ? const Center(
                        child: Text(
                          'Your cart is empty',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),
                      )
                    : Column(
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
                                    '123 Main Street, Apt 4B, Bahir Dar, Ethiopia',
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

                          const SizedBox(height: 24),
                          const Text(
                            'Order Summary',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.text,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // ---- Cart Items Preview ----
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Column(
                              children: List.generate(
                                entries.length > 3 ? 3 : entries.length,
                                (index) {
                                  final e = entries[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${e.quantity}x',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            e.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '\$${e.quantity.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          if (entries.length > 3)
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text(
                                '+ more items...',
                                style: TextStyle(color: AppColors.muted),
                              ),
                            ),

                          const SizedBox(height: 22),

                          // ---- Price Breakdown ----
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Column(
                              children: [
                                _priceRow('Subtotal', cartState.subtotal),
                                const SizedBox(height: 6),
                                _priceRow('Delivery Fee', cartState.deliveryFee),
                                const Divider(height: 20),
                                _priceRow('Total', cartState.total, isBold: true),
                              ],
                            ),
                          ),

                          const Spacer(),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state.status == CheckoutStatus.loading
                                  ? null
                                  : () {
                                      context
                                          .read<CheckoutBloc>()
                                          .add(ConfirmOrder());
                                    },
                              child: state.status == CheckoutStatus.loading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Confirm Order (\$${cartState.total.toStringAsFixed(2)})',
                                    ),
                            ),
                          ),

                          const SizedBox(height: 10),
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _priceRow(String label, double value, {bool isBold = false}) {
  return Row(
    children: [
      Text(
        label,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
          fontSize: isBold ? 16 : 14,
        ),
      ),
      const Spacer(),
      Text(
        '\$${value.toStringAsFixed(2)}',
        style: TextStyle(
          fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
          fontSize: isBold ? 17 : 15,
        ),
      ),
    ],
  );
}
