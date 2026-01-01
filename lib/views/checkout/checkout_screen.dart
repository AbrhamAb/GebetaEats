import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../theme.dart';
import '../order_tracking/order_tracking_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final entries = appState.items.values.toList();
    final address = appState.addresses.isNotEmpty
        ? appState.addresses.first
        : 'No address set';

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
              : SingleChildScrollView(
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

                      /// ADDRESS
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
                          children: <Widget>[
                            const Icon(
                              Icons.location_pin,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                address,
                                style: const TextStyle(
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

                      /// ORDER SUMMARY
                      const Text(
                        'Order Summary',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                ),
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
                                        e.dish.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '\$${e.total.toStringAsFixed(2)}',
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

                      /// PRICE BOX
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: [
                            _priceRow('Subtotal', appState.subtotal),
                            const SizedBox(height: 6),
                            _priceRow('Delivery Fee', appState.deliveryFee),
                            const Divider(height: 20),
                            _priceRow('Total', appState.total, isBold: true),
                          ],
                        ),
                      ),

                      const SizedBox(height: 22),

                      /// CONFIRM BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (entries.isEmpty) return;

                            await appState.placeOrderInSupabase();

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const OrderTrackingScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Confirm Order  (\$${appState.total.toStringAsFixed(2)})',
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
        ),
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
