import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login(String email, String password) async {
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
}
