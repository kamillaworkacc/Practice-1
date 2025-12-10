import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'auth_event.dart';
import 'auth_state.dart';
import '../services/preferences_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({firebase_auth.FirebaseAuth? firebaseAuth})
      : super(AuthInitial()) {
    on<AuthCheckStatus>(_onAuthCheckStatus);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  Future<void> _onAuthCheckStatus(
    AuthCheckStatus event,
    Emitter<AuthState> emit,
  ) async {
    final isLoggedIn = await PreferencesService.isLoggedIn();
    if (isLoggedIn) {
      final email = await PreferencesService.getUserEmail();
      if (email != null) {
        emit(AuthAuthenticated(email));
      } else {
        emit(AuthUnauthenticated());
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        await PreferencesService.setLoggedIn(true);
        await PreferencesService.setUserEmail(event.email);
        emit(AuthAuthenticated(event.email));
      } else {
        emit(const AuthError('Please enter email and password'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await PreferencesService.setLoggedIn(false);
    await PreferencesService.setUserEmail('');
    emit(AuthUnauthenticated());
  }
}

