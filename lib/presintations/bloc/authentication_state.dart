part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class Authorized extends AuthenticationState {}

final class UnAuthorized extends AuthenticationState {}

final class AuthLoding extends AuthenticationState {}

final class AuthError extends AuthenticationState {
  final String errorMessage;

  AuthError({required this.errorMessage});
}
