import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_tracker/components/button.dart';
import '../components/text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ///text editing controllers
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();

  ///sign user in method
  void signUserIn() async {
    ///show a loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    ///try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmailController.text,
        password: userPasswordController.text,
      );
      /// pop the lading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ///Wrong Email
      if (e.code == 'user-not-found') {
        ///show error to user
        wrongEmailMessage();
      }

      ///Wrong Password
      else if (e.code == 'wrong-password') {
        ///show error to user
        wrongPasswordMessage();
      }
    }
  }
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

  ///wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Password'),
        );
      },
    );
  }

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

              ///Forgot Password?
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  ],
                ),
              ),

              ///Button
              const SizedBox(height: 50),
              Button(
                onTap: signUserIn,
              ),

              ///Don't have an account? Join Us
              const SizedBox(height: 10),
              Text(
                'Don\'t have an account? Join Us',
                style: TextStyle(color: Colors.grey.shade400),
              ),

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
              Image.asset(
                'assets/google.png',
                height: 72,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
