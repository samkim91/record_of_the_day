part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SendSignInEmail extends AuthEvent {
  final String email;

  const SendSignInEmail(this.email);
}
