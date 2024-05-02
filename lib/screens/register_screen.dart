import 'package:chat_app/helper/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../main.dart';
import '../helper/show_snackbar.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = '';

  String password = '';

  bool isLoading=false;

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
                ),
              ),
              const SizedBox(height: 30.0),
              const Text(
                'Register',
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
                        isLoading=true;
                      });
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      showSnackBar(context, 'account created successfully');
                      Navigator.pushNamed(context, Routes.ChatScreen);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showSnackBar(
                            context, 'The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        showSnackBar(context,
                            'The account already exists for that email.');

                      }
                    } catch (e) {
                      showSnackBar(context, e.toString());
                    }
                    setState(() {
                      isLoading=false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  child: const Text('Register'),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already has an account ',
                      style: TextStyle(color: Colors.white)),
                  const SizedBox(width: 4),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Login',
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
