import 'package:chat_app/helper/consts.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snackbar.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';

  String password = '';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            children: [
              const SizedBox(height: 30.0),
              Image.asset('assets/images/scholar.png',
                  width: 100.0, height: 100.0),
              Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Scholar Chat',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  )),
              const SizedBox(height: 30.0),
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                  hint: 'Email',
                  onChange: (value) {
                    email = value;
                  }),
              const SizedBox(height: 8),
              CustomTextField(
                  hint: 'Password',
                  onChange: (value) {
                    password = value;
                  }),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      showSnackBar(context, 'logged in successfully');
                      Navigator.pushNamed(
                        context,
                        Routes.ChatScreen,
                        arguments: email,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showSnackBar(context, 'wrong email.');
                      } else if (e.code == 'wrong-password') {
                        showSnackBar(context, 'Wrong password');
                      } else {
                        showSnackBar(context, e.message.toString());
                      }
                    } catch (e) {
                      showSnackBar(context, e.toString());
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
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
                      onTap: () {
                        Navigator.pushNamed(context, Routes.SignUpScreen);
                      },
                      child: const Text('Sign Up',
                          style: TextStyle(color: Colors.white)))
                ],
              ),
              const SizedBox(height: 60.0),
            ],
          ),
        ),
      ),
    );
  }
}
