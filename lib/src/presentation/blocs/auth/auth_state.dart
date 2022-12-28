part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final String email;

  const AuthState({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthInitial extends AuthState {
  const AuthInitial() : super(email: "");
}

class AuthChecking extends AuthState {
  const AuthChecking(String email) : super(email: email);
}

class AuthDone extends AuthState {
  const AuthDone(String email) : super(email: email);
}

class AuthError extends AuthState {
  final DioError error;

  const AuthError(this.error, String email) : super(email: email);
}
