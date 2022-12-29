part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends AuthEvent {
  final String email;

  const EmailChanged(this.email);
}

class SendSignInEmail extends AuthEvent {
  const SendSignInEmail();
}
