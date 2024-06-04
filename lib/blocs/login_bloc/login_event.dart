part of 'login_bloc.dart';

class LoginEvent {
  LoginEvent({required this.email, required this.password});

  final String email, password;
}
