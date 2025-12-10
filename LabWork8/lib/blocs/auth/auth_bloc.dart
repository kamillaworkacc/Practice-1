import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labwork8/blocs/auth/auth_event.dart';
import 'package:labwork8/blocs/auth/auth_state.dart';
import 'package:labwork8/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
  }

  Future<void> _onRegister(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final success = await authRepository.register(
        email: event.email,
        password: event.password,
      );
      if (success) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure("Registration failed"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}

