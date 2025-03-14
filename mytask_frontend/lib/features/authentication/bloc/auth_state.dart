part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// SignUp states
class SignUpInprogressState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class SignUpErrorState extends AuthState {
  final String error;
  SignUpErrorState({required this.error});
}

// SignIn states
class SignInInprogressState extends AuthState {}

class SignInSuccessState extends AuthState {}

class SignInErrorState extends AuthState {
  final String error;
  SignInErrorState({required this.error});
}
