import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {

  final String documentId;

  const GetUserName({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ///get the collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        return Text('First name: ${data['first name']}');
      } else {
        return Text('loading...');
      }
    },
    );
  }
}
