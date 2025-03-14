import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:mytask_frontend/models/user_model.dart';
import 'package:mytask_frontend/services/auth_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices _authServices = AuthServices();

  AuthBloc() : super(AuthInitial()) {
    on<SignUpEvent>(signUpEvent);
    on<SignInEvent>(signInEvent);
  }

  // Sign Up Event
  Future<void> signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(SignUpInprogressState());
      await AuthServices().signUpUser(event.user);
      emit(SignUpSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpErrorState(error: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(
          SignUpErrorState(error: 'The account already exists for that email.'),
        );
      } else if (e.code == 'invalid-email') {
        emit(SignUpErrorState(error: 'The email address is badly formatted.'));
      } else if (e.code == 'operation-not-allowed') {
        emit(
          SignUpErrorState(error: 'Email & Password accounts are not enabled.'),
        );
      } else {
        emit(SignUpErrorState(error: 'An undefined Error happened.'));
      }
    }
  }

  // Sign In Event
  Future<void> signInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(SignInInprogressState());
      await AuthServices().signInUser(event.email, event.password);
      emit(SignInSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SignInErrorState(error: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(SignInErrorState(error: 'Wrong password provided for that user.'));
      } else if (e.code == 'invalid-email') {
        emit(SignInErrorState(error: 'The email address is badly formatted.'));
      } else if (e.code == 'user-disabled') {
        emit(SignInErrorState(error: 'The user account has been disabled.'));
      } else {
        emit(SignInErrorState(error: 'An undefined Error happened.'));
      }
    }
  }
}
