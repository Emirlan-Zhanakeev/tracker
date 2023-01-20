import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name = '';
  String? surname = '';
  String? email = '';
  String? age = '';

  Future _getDataFromFirebase() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (snapshot) async {
        if (snapshot.exists) {
          setState(
            () {
              name = snapshot.data()!['first name'];
              surname = snapshot.data()!['last name'];
              email = snapshot.data()!['email'];
              age = snapshot.data()!['age'];
            },
          );
        }
      },
    );
  }
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


          ],
        ),
      ),
    );
  }
}

class UserManagement {

}
