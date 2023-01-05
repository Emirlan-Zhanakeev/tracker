import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_tracker/components/button.dart';
import 'package:medicine_tracker/components/square_tile.dart';
import 'package:medicine_tracker/services/auth_service.dart';
import '../components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({Key? key, required this.onTap})
      : super(key: key); // changed to super key

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  ///text editing controllers
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();
  final userConfirmPasswordController = TextEditingController();

  ///sign user up method
  void signUserUp() async {
    ///show a loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    ///try cresting user
    try {
      ///check is password is confirmed
      if (userPasswordController.text == userConfirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmailController.text,
          password: userPasswordController.text,
        );
      } else {
        ///show error message if password don't match
        showErrorMessage("Password don't match");
      }

      /// pop the lading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      /// pop the lading circle
      Navigator.pop(context);

      ///show error message
      showErrorMessage(e.code);

      /*///Wrong Email
      if (e.code == 'user-not-found') {
        ///show error to user
        wrongEmailMessage();
      }

      ///Wrong Password
      else if (e.code == 'wrong-password') {
        ///show error to user
        wrongPasswordMessage();
      }*/
    }
  }

  ///show error message popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  /*
  ///wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Email'),
        );
      },
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        //убирает свободное пространстко при открытии клавиатуры
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///Head text
              const SizedBox(height: 100),
              const Text(
                'WELCOME',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 255, 194, 100)),
              ),
              const SizedBox(height: 10),
              const Text(
                'Join us and use Medicine Tracker\n         and Notification System',
                style: TextStyle(
                    fontSize: 15, color: Color.fromRGBO(0, 255, 194, 100)),
              ),

              ///Name TextField
              const SizedBox(height: 80),
              MyTextField(
                controller: userEmailController,
                hintText: 'Email',
                obscureText: false,
              ),

              ///Password TextField
              const SizedBox(height: 20),
              MyTextField(
                controller: userPasswordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 20),
              MyTextField(
                controller: userConfirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),

              ///Button
              const SizedBox(height: 50),
              Button(
                onTap: signUserUp,
                text: 'Sign Up',
              ),

              ///Don't have an account? Join Us
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login Now',
                      style: TextStyle(color: Color.fromRGBO(0, 255, 194, 100)),
                    ),
                  ),
                ],
              ),
/*
              ///or continue with...
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ///Google Sign in
              const SizedBox(height: 20),
              SquareTile(
                imagePath: 'assets/google.png',
                onTap: () => AuthService().signInWithGoogle(),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
