import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/helper/consts.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snackbar.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: LoginScreenContent(),
    );
  }
}

class LoginScreenContent extends StatelessWidget {
  LoginScreenContent({super.key});

  String email = '';

  String password = '';


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          showSnackBar(context, 'logged in successfully');
          Navigator.pushNamed(
            context,
            Routes.ChatScreen,
            arguments: email,
          );
        }
        if (state is LoginFailure) {
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: primaryColor,
          body: ModalProgressHUD(
            inAsyncCall: state is LoginLoading ? true : false ,
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
                      obscureText: true,
                      onChange: (value) {
                        password = value;
                      }),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        BlocProvider.of<LoginCubit>(context).login(
                            email, password);
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
      },
    );
  }
}
