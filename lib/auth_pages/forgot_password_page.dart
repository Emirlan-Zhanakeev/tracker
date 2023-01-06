import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/text_field.dart';

class ForgotPasswordRage extends StatefulWidget {
  const ForgotPasswordRage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordRage> createState() => _ForgotPasswordRageState();
}

class _ForgotPasswordRageState extends State<ForgotPasswordRage> {
  /// forgot pw controller created
  final forgotEmailController = TextEditingController();

  /// Pw reset method
  Future passwordReset() async {
    try {
      ///send link to your email
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: forgotEmailController.text.trim());
      ///shows alert that password changed
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Check an Email'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      ///shows alert that password wrong
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///come back to login
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter your Email and we will send you a password reset link',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 20),

          ///TextField to enter initial email
          MyTextField(
            hintText: 'Email',
            obscureText: false,
            controller: forgotEmailController,
          ),
          const SizedBox(height: 20),

          ///Button to reset pw
          MaterialButton(
            onPressed: () async {
              await passwordReset();
            },
            color: Colors.white,
            child: const Text('Reset Password'),
          )
        ],
      ),
    );
  }
}
