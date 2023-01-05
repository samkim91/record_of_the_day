import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_to_fit/src/core/config/logger.dart';

import '../../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthState()) {
    on<EmailChanged>(_emailChanged);
    on<SendSignInEmail>(_sendSignInEmail);
    on<ClickGoogleSignIn>(_clickGoogleSignIn);
  }

  void _emailChanged(EmailChanged event, Emitter<AuthState> emit) {
    final email = event.email;
    logger.d('_emailChanged: $email');

    emit(state.copyWith(email: email));
  }

  void _sendSignInEmail(SendSignInEmail event, Emitter<AuthState> emit) async {
    logger.d('_sendSignInEmail: ${state.email}');

    emit(state.copyWith(status: AuthStatus.processing));

    try {
      await _authRepository.sendSignInEmail(state.email);
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failed, error: e.toString()));
    }
  }

  void _clickGoogleSignIn(ClickGoogleSignIn event,
      Emitter<AuthState> emit) async {
    logger.d('_clickGoogleSignIn: ');

    emit(state.copyWith(status: AuthStatus.processing));

    try {
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failed, error: e.toString()));
    }
  }
}
