import 'package:flutter/material.dart';
import '../../theme.dart';

class EtaCard extends StatelessWidget {
  const EtaCard({
    super.key,
    required this.title,
    required this.eta,
    this.subtitle,
  });

  final String title;
  final String eta;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Text(
              subtitle!,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ],
      ),
    );
  }
}
