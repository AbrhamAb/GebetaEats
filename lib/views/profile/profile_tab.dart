import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../app_state.dart';
import '../../services/supabase_client.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String userName = '';
  String userEmail = '';
  String userAddress = '';
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final profile = await SupabaseService.getCurrentUserProfile();
    if (profile != null) {
      setState(() {
        userName = profile['name'] ?? '';
        userEmail = profile['email'] ?? '';
        userAddress = profile['address'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = <_ProfileItem>[
      _ProfileItem(
        label: 'Edit Profile',
        icon: Icons.edit,
        color: AppColors.primary,
        onTap: () async {
          await showDialog(
            context: context,
            builder: (_) => _EditProfileDialog(
              name: userName,
              email: userEmail,
              address: userAddress,
            ),
          );
          _loadUserProfile();
        },
      ),
      _ProfileItem(
        label: 'Change Password',
        icon: Icons.lock_outline,
        color: AppColors.primary,
        onTap: () async {
          await showDialog(
            context: context,
            builder: (_) => const _ChangePasswordDialog(),
          );
        },
      ),
      _ProfileItem(
        label: 'Logout',
        icon: Icons.logout,
        color: Colors.red,
        onTap: () async {
          await SupabaseService.signOut();
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                userName.isNotEmpty ? userName : 'Gebeta User',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                userEmail.isNotEmpty ? userEmail : 'user@example.com',
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

/// ---------------- DIALOGS FOR EDIT & PASSWORD ----------------

class _EditProfileDialog extends StatefulWidget {
  const _EditProfileDialog({
    required this.name,
    required this.email,
    required this.address,
  });

  final String name;
  final String email;
  final String address;

  @override
  State<_EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<_EditProfileDialog> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    addressController = TextEditingController(text: widget.address);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _loading = true);
    try {
      await SupabaseService.updateUserProfile(
        name: nameController.text,
        email: emailController.text,
        address: addressController.text,
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Profile'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: addressController,
            decoration: const InputDecoration(labelText: 'Address'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _loading ? null : _save,
          child: _loading
              ? const CircularProgressIndicator()
              : const Text('Save'),
        ),
      ],
    );
  }
}

class _ChangePasswordDialog extends StatefulWidget {
  const _ChangePasswordDialog();

  @override
  State<_ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<_ChangePasswordDialog> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (newPasswordController.text != confirmController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }
    setState(() => _loading = true);
    try {
      await SupabaseService.updateUserPassword(newPasswordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
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
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _loading ? null : _changePassword,
          child: _loading
              ? const CircularProgressIndicator()
              : const Text('Save'),
        ),
      ],
    );
  }
}
