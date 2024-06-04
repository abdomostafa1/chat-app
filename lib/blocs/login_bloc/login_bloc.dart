import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit)  async {
       await login(event.email, event.password, emit);
    });

  }

  Future<void> login(String email, String password, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure('wrong email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure('Wrong password'));
      } else {
        emit(LoginFailure(e.message.toString()));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition);
    if (kDebugMode) {
      print(transition);
    }
  }
}
