import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/timetable_data.dart';

class TimetableService {
  final CollectionReference _subjectsCollection =
  FirebaseFirestore.instance.collection('subjects');

  Future<List<TimetableEntry>> getTimetableEntries() async {
    final snapshot = await _subjectsCollection.get();
    return snapshot.docs.map((doc) => TimetableEntry.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
  }

}