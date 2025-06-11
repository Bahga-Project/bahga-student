// service/subject_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../models/subject_model.dart';

class SubjectService {
  // Mock data - replace with actual API calls or database queries
  static final List<Subject> _mockSubjects = [
    Subject(
      id: 'math',
      name: 'Mathematics',
      icon: Icons.calculate,
      color: '0xFFFF6B6B',
      lessons: [
        Lesson(
          title: "Lesson 1",
          description: "Introduction to Algebra",
          topics: [
            Topic(
              type: 'Documents',
              title: 'Math Chapter 1',
              url: 'https://example.com/math_ch1.pdf',
              content: '',
            ),
            Topic(
              type: 'Notes',
              title: 'Math Handwritten Notes',
              url: 'https://example.com/math_notes.pdf',
              content: 'This is a note about Math Chapter 1.',
            ),
          ],
        ),
        Lesson(
          title: "Lesson 2",
          description: "Linear Equations",
          topics: [
            Topic(
              type: 'Documents',
              title: 'Linear Equations Guide',
              url: 'https://example.com/linear_equations.pdf',
              content: '',
            ),
          ],
        ),
      ],
    ),
    Subject(
      id: 'arab',
      name: 'Arabic',
      icon: Icons.language,
      color: '0xFF4ECDC4',
      lessons: [
        Lesson(
          title: "Lesson 1",
          description: "Arabic Grammar Basics",
          topics: [
            Topic(
              type: 'Documents',
              title: 'Arabic Grammar Chapter 1',
              url: 'https://example.com/arabic_ch1.pdf',
              content: '',
            ),
          ],
        ),
      ],
    ),
    Subject(
      id: 'cs',
      name: 'Computer Science',
      icon: Icons.computer,
      color: '0xFF45B7D1',
      lessons: [
        Lesson(
          title: "Lesson 1",
          description: "Introduction to Programming",
          topics: [
            Topic(
              type: 'Documents',
              title: 'Programming Basics',
              url: 'https://example.com/programming_basics.pdf',
              content: '',
            ),
            Topic(
              type: 'Notes',
              title: 'CS Notes',
              url: 'https://example.com/cs_notes.pdf',
              content: 'Basic programming concepts and syntax.',
            ),
          ],
        ),
      ],
    ),
    Subject(
      id: 'chem',
      name: 'Chemistry',
      icon: Icons.science,
      color: '0xFF96CEB4',
      lessons: [
        Lesson(
          title: "Lesson 1",
          description: "Atomic Structure",
          topics: [
            Topic(
              type: 'Documents',
              title: 'Chemistry Chapter 1',
              url: 'https://example.com/chemistry_ch1.pdf',
              content: '',
            ),
          ],
        ),
      ],
    ),
    Subject(
      id: 'phys',
      name: 'Physics',
      icon: Icons.psychology,
      color: '0xFFFCE38A',
      lessons: [
        Lesson(
          title: "Lesson 1",
          description: "Mechanics and Motion",
          topics: [
            Topic(
              type: 'Documents',
              title: 'Physics Chapter 1',
              url: 'https://example.com/physics_ch1.pdf',
              content: '',
            ),
          ],
        ),
      ],
    ),
    Subject(
      id: 'eng',
      name: 'English',
      icon: Icons.book,
      color: '0xFFF38BA8',
      lessons: [
        Lesson(
          title: "Lesson 1",
          description: "English Literature",
          topics: [
            Topic(
              type: 'Documents',
              title: 'English Literature Guide',
              url: 'https://example.com/english_lit.pdf',
              content: '',
            ),
          ],
        ),
      ],
    ),
    Subject(
      id: 'hist',
      name: 'History',
      icon: Icons.history_edu,
      color: '0xFFA8E6CF',
      lessons: [
        Lesson(
          title: "Lesson 1",
          description: "Ancient Civilizations",
          topics: [
            Topic(
              type: 'Documents',
              title: 'History Chapter 1',
              url: 'https://example.com/history_ch1.pdf',
              content: '',
            ),
          ],
        ),
      ],
    ),
    Subject(
      id: 'geo',
      name: 'Geography1',
      icon: Icons.public,
      color: '0xFFD4A574',
      lessons: [
        Lesson(
          title: "Lesson 1",
          description: "Physical Geography",
          topics: [
            Topic(
              type: 'Documents',
              title: 'Geography Chapter 1',
              url: 'https://example.com/geography_ch1.pdf',
              content: '',
            ),
          ],
        ),
      ],
    ),
  ];

  final CollectionReference _subjectsCollection =
  FirebaseFirestore.instance.collection('subjects');

  /// Get all available subjects from Firebase
  Future<List<Subject>> getAllSubjects() async {
    try {
      final querySnapshot = await _subjectsCollection.get();

      if (querySnapshot.docs.isEmpty) {
        // If no data in Firebase, use mock data as fallback
        print('No subjects found in Firebase, using mock data');
        return _mockSubjects;
      }

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Add document ID to the data
        return Subject.fromJson(data);
      }).toList();

    } catch (e) {
      print('Error fetching subjects from Firebase: $e');
      // Return mock data as fallback
      return _mockSubjects;
    }
  }

  /// Get a specific subject by ID
  Future<Subject?> getSubjectById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));

    try {
      return _mockSubjects.firstWhere((subject) => subject.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get subjects by IDs (useful for timetable)
  Future<List<Subject>> getSubjectsByIds(List<String> ids) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _mockSubjects.where((subject) => ids.contains(subject.id)).toList();
  }

  /// Search subjects by name
  Future<List<Subject>> searchSubjects(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (query.isEmpty) return _mockSubjects;

    return _mockSubjects
        .where((subject) =>
    subject.name.toLowerCase().contains(query.toLowerCase()) ||
        subject.id.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Get subject details for timetable (returns Map for backward compatibility)
  Map<String, dynamic> getSubjectDetailsMap(String subjectId) {
    try {
      final subject = _mockSubjects.firstWhere((s) => s.id == subjectId);
      return {
        'id': subject.id,
        'name': subject.name,
        'icon': subject.icon,
        'color': Color(int.parse(subject.color)),
        // subject.color,
      };
    } catch (e) {
      // Return default values if subject not found
      return {
        'id': subjectId,
        'name': 'Unknown Subject',
        'icon': Icons.help_outline,
        'color':  Color(int.parse('0xFF9E9E9E')) ,
      };
    }
  }

  /// Add a new subject to Firebase
  Future<String?> addSubject(Subject subject) async {
    try {
      final docRef = await _subjectsCollection.add(subject.toJson());
      return docRef.id;
    } catch (e) {
      print('Error adding subject to Firebase: $e');
      return null;
    }
  }

  /// Update an existing subject in Firebase
  Future<bool> updateSubject(String id, Subject subject) async {
    try {
      await _subjectsCollection.doc(id).update(subject.toJson());
      return true;
    } catch (e) {
      print('Error updating subject in Firebase: $e');
      return false;
    }
  }

  /// Delete a subject from Firebase
  Future<bool> deleteSubject(String id) async {
    try {
      await _subjectsCollection.doc(id).delete();
      return true;
    } catch (e) {
      print('Error deleting subject from Firebase: $e');
      return false;
    }
  }

  /// Initialize Firebase with mock data (call this once to populate Firebase)
  Future<void> initializeFirebaseWithMockData() async {
    try {
      final querySnapshot = await _subjectsCollection.get();

      if (querySnapshot.docs.isEmpty) {
        print('Initializing Firebase with mock data...');

        for (Subject subject in _mockSubjects) {
          await _subjectsCollection.doc(subject.id).set(subject.toJson());
        }

        print('Firebase initialized with mock data successfully');
      } else {
        print('Firebase already contains data, skipping initialization');
      }
    } catch (e) {
      print('Error initializing Firebase with mock data: $e');
    }
  }

  /// Listen to real-time updates for all subjects
  Stream<List<Subject>> getSubjectsStream() {
    return _subjectsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Subject.fromJson(data);
      }).toList();
    });
  }

  /// Listen to real-time updates for a specific subject
  Stream<Subject?> getSubjectStream(String id) {
    return _subjectsCollection.doc(id).snapshots().map((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        data['id'] = snapshot.id;
        return Subject.fromJson(data);
      }
      return null;
    });
  }
}