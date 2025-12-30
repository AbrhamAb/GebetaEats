import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Initial / loading state
class AuthInitial extends AuthState {}

// Checking auth status
class AuthLoading extends AuthState {}

// User is NOT authenticated
class AuthUnauthenticated extends AuthState {}

// User IS authenticated
class AuthAuthenticated extends AuthState {
  final String userId;
  final String email;

  const AuthAuthenticated({
    required this.userId,
    required this.email,
  });

  @override
  List<Object?> get props => [userId, email];
}

// Error state
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
