import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../app_state.dart'; // make sure this imports your AppState

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    final items = <_ProfileItem>[
      _ProfileItem(
        label: 'Edit Profile',
        icon: Icons.edit,
        color: AppColors.primary,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => EditProfileScreen()),
          );
        },
      ),
      _ProfileItem(
        label: 'Saved Addresses',
        icon: Icons.location_on_outlined,
        color: AppColors.primary,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SavedAddressesScreen()),
          );
        },
      ),
      _ProfileItem(
        label: 'Change Password',
        icon: Icons.lock_outline,
        color: AppColors.primary,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ChangePasswordScreen()),
          );
        },
      ),
      _ProfileItem(
        label: 'Logout',
        icon: Icons.logout,
        color: Colors.red,
        onTap: () {
          appState.logout();
          Navigator.pushReplacementNamed(
            context,
            '/login',
          ); // mock login screen
        },
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(appState.userAvatar),
              ),
              const SizedBox(height: 12),
              Text(
                appState.userName.isNotEmpty ? appState.userName : 'Guest User',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                appState.userEmail.isNotEmpty
                    ? appState.userEmail
                    : 'guest@example.com',
                style: const TextStyle(fontSize: 14, color: AppColors.muted),
              ),
              const SizedBox(height: 20),
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
      onTap: item.onTap,
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

class _ProfileItem {
  _ProfileItem({
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
}

/// ---------------------- MOCK SCREENS ----------------------
/// Replace with real screens later when integrating Supabase

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final nameController = TextEditingController(text: appState.userName);
    final emailController = TextEditingController(text: appState.userEmail);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                appState.updateUser(
                  name: nameController.text,
                  email: emailController.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class SavedAddressesScreen extends StatelessWidget {
  const SavedAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Addresses')),
      body: ListView.builder(
        itemCount: appState.addresses.length,
        itemBuilder: (context, index) {
          final address = appState.addresses[index];
          return ListTile(
            title: Text(address),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => appState.removeAddress(address),
            ),
          );
        },
      ),
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: oldPasswordController,
              decoration: const InputDecoration(labelText: 'Old Password'),
              obscureText: true,
            ),
            TextField(
              controller: newPasswordController,
              decoration: const InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            TextField(
              controller: confirmController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (newPasswordController.text == confirmController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password changed (mock).')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords do not match.')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
