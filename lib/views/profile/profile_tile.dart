import 'package:flutter/material.dart';
import '../../theme.dart';
import 'profile_item.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.item});

  final ProfileItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(item.icon, color: item.color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.label,
                style: TextStyle(
                  fontWeight: item.label == 'Logout'
                      ? FontWeight.w700
                      : FontWeight.w800,
                  color: item.label == 'Logout' ? Colors.red : AppColors.text,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}
