import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_tracker/auth_pages/home_page.dart';

  final _db = FirebaseFirestore.instance;
class UserModel {

  final String firstName;
  final String lastName;
  final String age;
  final String email;

  UserModel({required this.firstName, required this.lastName, required this.age, required this.email});

  toJson() {
    return {
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'age': age,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return UserModel(
      firstName: data['first name'],
      lastName: data['last name'],
      age: data['age'],
      email: data['email'],
    );
  }
}
