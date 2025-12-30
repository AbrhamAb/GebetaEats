import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebeta_eats/views/auth/bloc/auth_event.dart';
import 'package:gebeta_eats/views/auth/bloc/auth_state.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthStarted>(_onStarted);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onStarted(
    AuthStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // TODO: Replace with real auth check (Firebase / API)
      final bool isLoggedIn = false;

      if (isLoggedIn) {
        emit(
          const AuthAuthenticated(
            userId: '123',
            email: 'user@email.com',
          ),
        );
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // TODO: Replace with real login logic
      await Future.delayed(const Duration(seconds: 1));

      emit(
        AuthAuthenticated(
          userId: '123',
          email: event.email,
        ),
      );
    } catch (e) {
      emit(AuthFailure('Login failed'));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // TODO: Logout logic
      await Future.delayed(const Duration(milliseconds: 500));

      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure('Logout failed'));
    }
  }
}
