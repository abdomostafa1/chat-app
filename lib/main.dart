import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      routes: {
        Routes.LoginScreen: (context) => LoginScreen(),
        Routes.SignUpScreen: (context) => SignupScreen(),
      },
      initialRoute: 'LoginScreen',
    );
  }
}

class Routes {
  static const String LoginScreen='LoginScreen';
  static const String SignUpScreen='SignUpScreen';
}



