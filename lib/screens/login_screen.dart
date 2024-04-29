import 'package:chat_app/main.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2B455F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            Image.asset('assets/images/scholar.png'),
            const Text(
              'Scholar Chat',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            const Spacer(flex: 1),
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Sign In',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(hint: 'Email', onChange: (value) {}),
            const SizedBox(height: 8),
            CustomTextField(hint: 'Password', onChange: (value) {}),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Sign In'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0))),
              ),
            ),
            const SizedBox(height: 8),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('don\'t have an account?',
                    style: TextStyle(color: Colors.white)),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context,Routes.SignUpScreen);
                  },
                    child: Text('Sign Up', style: TextStyle(color: Colors.white)))
              ],
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
