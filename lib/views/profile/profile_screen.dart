import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../services/supabase_client.dart';
import 'profile_item.dart';
import 'profile_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';
  String userEmail = '';
  String userAddress = '';

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
    final items = <ProfileItem>[
      ProfileItem(
        label: 'Edit Profile',
        icon: Icons.edit,
        color: AppColors.primary,
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditProfileScreen(
                name: userName,
                email: userEmail,
                address: userAddress,
              ),
            ),
          );
          _loadUserProfile(); // refresh after edit
        },
      ),
      ProfileItem(
        label: 'Change Password',
        icon: Icons.lock_outline,
        color: AppColors.primary,
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
          );
          if (result != null && result is String) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(result)));
          }
        },
      ),
      ProfileItem(
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.text,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        elevation: 0,
      ),
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
              const SizedBox(height: 4),
              if (userAddress.isNotEmpty)
                Text(
                  userAddress,
                  style: const TextStyle(fontSize: 14, color: AppColors.muted),
                ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return ProfileTile(item: items[index]);
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

/// -------------------- EDIT PROFILE SCREEN --------------------
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.address,
  });

  final String name;
  final String email;
  final String address;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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

  Future<void> _saveProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      await SupabaseService.updateUserProfile(
        name: nameController.text,
        email: emailController.text,
        address: addressController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error updating profile: $e')));
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _saveProfile,
              child: _loading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    )
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

/// -------------------- CHANGE PASSWORD SCREEN --------------------
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmController = TextEditingController();
  bool _loading = false;

  Future<void> _updatePassword() async {
    if (newPasswordController.text != confirmController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match.')));
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      await SupabaseService.updateUserPassword(newPasswordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully')),
      );
      Navigator.pop(context, 'Password updated');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error updating password: $e')));
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: _loading ? null : _updatePassword,
              child: _loading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    )
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
