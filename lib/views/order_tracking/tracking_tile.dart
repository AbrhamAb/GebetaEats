import 'package:flutter/material.dart';
import '../../theme.dart';
import 'tracking_step.dart';

class TrackingTile extends StatelessWidget {
  const TrackingTile({super.key, required this.step});

  final TrackingStep step;

  @override
  Widget build(BuildContext context) {
    final iconColor = step.isActive ? Colors.white : AppColors.muted;
    final bgColor = step.isActive ? AppColors.primary : const Color(0xFFF3F4F6);
    final textColor = step.isActive ? AppColors.text : AppColors.muted;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(step.icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  style: const TextStyle(color: AppColors.muted, fontSize: 13),
                ),
                if (step.timestamp != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Updated: ${step.timestamp}',
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
