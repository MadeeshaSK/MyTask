part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

// Event to sign up a user
class SignUpEvent extends AuthEvent {
  final UserModel user;

  SignUpEvent({required this.user});
}

// Event to sign in a user
class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  final String fcmToken;

  SignInEvent({
    required this.email,
    required this.password,
    required this.fcmToken,
  });
}
