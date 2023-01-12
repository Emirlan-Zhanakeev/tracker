import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_tracker/read%20data/user_model.dart';

final _db = FirebaseFirestore.instance;


///Fetch All Users Or User Details
Future<UserModel> getUserDetails(String email) async {
  final snapshot = await _db.collection('users').where('email', isEqualTo: email).get();
  final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
  return userData;
}

Future<List<UserModel>> allUsers(String email) async {
  final snapshot = await _db.collection('users').get();
  final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
  return userData;
}