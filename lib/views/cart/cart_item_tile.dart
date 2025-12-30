import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_state.dart';
import '../../models/cart_entry.dart';
import '../../theme.dart';
import '../cart/bloc/cart_bloc.dart';
import '../cart/bloc/cart_event.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({super.key, required this.entry});

  final CartEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.network(
              entry.dish.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 100,
                height: 100,
                color: Colors.grey.shade300,
                child: const Icon(Icons.image_not_supported_outlined, color: AppColors.muted),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.dish.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${entry.dish.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Decrement button
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          context.read<CartBloc>().add(RemoveDish(entry.dish));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '${entry.quantity}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      // Increment button
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          context.read<CartBloc>().add(AddDish(entry.dish));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
