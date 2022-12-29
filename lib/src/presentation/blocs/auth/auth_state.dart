part of 'auth_bloc.dart';

enum AuthStatus { initial, processing, success, failed }

class AuthState extends Equatable {
  final String email;
  final AuthStatus status;
  final String error;

  const AuthState({this.email = '', this.status = AuthStatus.initial, this.error = ''});

  @override
  List<Object?> get props => [email, status, error];

  AuthState copyWith({String? email, AuthStatus? status, String? error}) {
    return AuthState(email: email ?? this.email, status: status ?? this.status, error: error ?? this.error);
  }
}
