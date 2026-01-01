import 'package:flutter/material.dart';
import '../../services/supabase_client.dart';
import '../../theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Login to your account to enjoy delicious food delivered to your door.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
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
                  onPressed: _loading ? null : _login,
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Login'),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: AppColors.muted),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                    },
                    child: const Text(
                      'Sign Up',
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

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = "Please enter email and password.";
        _loading = false;
      });
      return;
    }

    try {
      final user = await SupabaseService.signIn(
        email: email,
        password: password,
      );

      if (user == null) {
        setState(() {
          _errorMessage = "Login failed. Check your credentials.";
          _loading = false;
        });
        return;
      }

      // Optionally fetch user profile if you want
      final profile = await SupabaseService.getCurrentUserProfile();
      print("Logged in user profile: $profile");

      // Navigate to home screen
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Unexpected error: $e";
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
