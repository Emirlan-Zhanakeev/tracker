import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_tracker/read%20data/get_user_name.dart';
import 'package:medicine_tracker/read data/get_user_name.dart';

///removing all duplicates in the list
extension DuplicateRemoval<T> on List<T> {
  List<T> get removeAllDuplicates => [
        ...{...this}
      ];
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final user = FirebaseAuth.instance.currentUser!;

///sign user out method
void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class _HomePageState extends State<HomePage> {
  ///document IDs
  List<String> docIDs = [];

  ///get docIDs
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Signed in as: ${user.email!}",
            style: const TextStyle(fontSize: 16),
          ),
          actions: const [
            IconButton(
              onPressed: signUserOut,
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        ///Crud operation with StreamBuilder
        body: StreamBuilder(
          stream: users.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                  if (documentSnapshot['email'] == user.email) {

                  }
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['first name']),
                      subtitle: Text(documentSnapshot['age'].toString()),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )

        /*
      Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getDocId(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: docIDs.removeAllDuplicates.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: GetUserName(documentId: docIDs[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      */

        );
  }
}
