import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ChatApp());

}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Routes.LoginScreen: (context) => LoginScreen(),
        Routes.SignUpScreen: (context) => RegisterScreen(),
        Routes.ChatScreen: (context) => ChatScreen()
      },
      initialRoute: Routes.ChatScreen,
    );
  }
}

class Routes {
  static const String LoginScreen = 'LoginScreen';
  static const String SignUpScreen = 'SignUpScreen';
  static const String ChatScreen = 'ChatScreen';
}
