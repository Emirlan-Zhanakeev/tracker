import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///removing all duplicates in the list
extension DuplicateRemoval<T> on List<T> {
  List<T> get removeAllDuplicates =>
      [
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
          (snapshot) =>
          snapshot.docs.forEach(
                (document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            },
          ),
    );
  }

  final CollectionReference users =
  FirebaseFirestore.instance.collection('users');
/*
  _fetch() async {
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then(
              (ds) {
            String myName = ds.data['first name'];
          }).catchError(e) {
        print(e);
      };
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  children: const [
                    Icon(
                      Icons.person,
                      color: Color.fromRGBO(0, 255, 194, 100),
                      size: 80,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 255, 194, 100),
                          fontSize: 20),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.email_outlined,
                  color: Color.fromRGBO(0, 255, 194, 100),
                ),
                title: Text(
                  user.email!,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.person_pin_rounded,
                  color: Color.fromRGBO(0, 255, 194, 100),
                ),
                title: Text(
                  user.uid,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 255, 194, 100),
          centerTitle: true,
          title: const Text(
            "Menu",
            style: TextStyle(fontSize: 16),
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
                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
                  if (documentSnapshot['email'] == user.email) {}
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Text(documentSnapshot['email']),
                      title: Text(documentSnapshot['first name']),
                      subtitle: Text(documentSnapshot['age'].toString()),
                    ),
                  );
                },
              );
            }

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

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
