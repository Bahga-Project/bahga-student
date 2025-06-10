import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final CollectionReference students =
  FirebaseFirestore.instance.collection('students');

  Future<bool> login(String email, String password) async {
    try {
      // Query Firestore for a document with matching email
      QuerySnapshot query = await students.where('Email', isEqualTo: email).get();

      if (query.docs.isEmpty) {
        return false;
      }

      // Assuming email is unique, take the first matching document
      DocumentSnapshot doc = query.docs.first;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // Check if password matches
      if (data['Password'] == password) {
       return true;
      }
    } catch (e) {
      print('Error during login: $e');
      return false;

    }
    return false;
  }
}