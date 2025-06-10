import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/subject_model.dart';

class SubjectService {
  final CollectionReference _subjectsCollection =
  FirebaseFirestore.instance.collection('subjects');

  // Get all subjects
  Future<List<Subject>> getAllSubjects() async {
    try {
      final querySnapshot = await _subjectsCollection.get();
      return querySnapshot.docs.map((doc) => Subject.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to fetch subjects: $e');
    }
  }

  // Get a subject by code
  Future<Subject?> getSubjectByCode(String code) async {
    try {
      final querySnapshot =
      await _subjectsCollection.where('code', isEqualTo: code).get();
      if (querySnapshot.docs.isNotEmpty) {
        return Subject.fromFirestore(querySnapshot.docs.first);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch subject by code: $e');
    }
  }
}