part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class SignInEvent extends AuthenticationEvent {
  final String email, password;

  SignInEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthenticationEvent {
  final String email, password, name;

  SignUpEvent(
      {required this.name, required this.email, required this.password});
}

class SignOutEvent extends AuthenticationEvent {}

class SignInWithGoogleEvent extends AuthenticationEvent {}
class signInWithFacebookEvent extends AuthenticationEvent{}
class IsSignedInEvent extends AuthenticationEvent {}

