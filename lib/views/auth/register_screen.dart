import 'package:flutter/material.dart';
import '../../services/supabase_client.dart';
import '../../theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              const Icon(
                Icons.change_history_outlined,
                size: 64,
                color: Color(0xFFB1B6BC),
              ),
              const SizedBox(height: 24),
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign up to start ordering your favorite food.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: AppColors.muted,
                  ),
                  hintText: 'Full Name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: AppColors.muted,
                  ),
                  hintText: 'Email address',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline, color: AppColors.muted),
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 22),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _register,
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Sign Up'),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: AppColors.muted),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = "Please fill all fields.";
        _loading = false;
      });
      return;
    }

    try {
      final user = await SupabaseService.signUp(
        email: email,
        password: password,
        name: name,
      );

      if (user == null) {
        setState(() {
          _errorMessage =
              "Registration failed. Make sure your password has at least 6 characters, email is valid, and not already registered.";
          _loading = false;
        });
        return;
      }

      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } on AuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        _errorMessage =
            "Unexpected error. Make sure your password has at least 6 characters and email is valid.";
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
