import 'package:flutter/material.dart';

import '../../theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_ProfileItem>[
      _ProfileItem(
        label: 'Edit Profile',
        icon: Icons.edit,
        color: AppColors.primary,
      ),
      _ProfileItem(
        label: 'Saved Addresses',
        icon: Icons.location_on_outlined,
        color: AppColors.primary,
      ),
      _ProfileItem(
        label: 'Change Password',
        icon: Icons.lock_outline,
        color: AppColors.primary,
      ),
      _ProfileItem(label: 'Logout', icon: Icons.logout, color: Colors.red),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.text,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: const <Widget>[
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
            children: <Widget>[
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
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return _ProfileTile(item: item);
                  },
                ),
              ),
              const SizedBox(height: 6),
              const _VisilyStamp(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({required this.item});

  final _ProfileItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${item.label} tapped.')));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: <Widget>[
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
            const Icon(Icons.open_in_new, color: AppColors.muted),
          ],
        ),
      ),
    );
  }
}

class _ProfileItem {
  _ProfileItem({required this.label, required this.icon, required this.color});

  final String label;
  final IconData icon;
  final Color color;
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
