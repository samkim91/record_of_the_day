import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:way_to_fit/src/core/config/logger.dart';

import '../../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthState()) {
    on<EmailChanged>(_emailChanged);
    on<SendSignInEmail>(_sendSignInEmail);

  }

  void _emailChanged(EmailChanged event, Emitter<AuthState> emit) {
    final email = event.email;
    logger.d('_emailChanged: $email');

    emit(state.copyWith(email: email));

    state;
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
}
