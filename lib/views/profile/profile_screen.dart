import 'package:flutter/material.dart';
import '../../theme.dart';
import 'profile_tile.dart';
import 'profile_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <ProfileItem>[
      ProfileItem(
        label: 'Edit Profile',
        icon: Icons.edit,
        color: AppColors.primary,
      ),
      ProfileItem(
        label: 'Saved Addresses',
        icon: Icons.location_on_outlined,
        color: AppColors.primary,
      ),
      ProfileItem(
        label: 'Change Password',
        icon: Icons.lock_outline,
        color: AppColors.primary,
      ),
      ProfileItem(label: 'Logout', icon: Icons.logout, color: Colors.red),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.text,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.edit_outlined, color: AppColors.text),
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 38,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=200&q=80',
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Gebeta User',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return ProfileTile(item: items[index]);
                  },
                ),
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
