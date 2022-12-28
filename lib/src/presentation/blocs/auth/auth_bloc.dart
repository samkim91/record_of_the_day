import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:way_to_fit/src/core/config/logger.dart';

import '../../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(AuthEvent event, Emitter<AuthState> emit) async {
    if (event is SendSignInEmail) await _sendSignInEmail(event.email);
  }

  Future<void> _sendSignInEmail(String email) async {
    logger.d('_sendSignInEmail: ');
    _authRepository.sendSignInEmail(email);
    
  }
}
