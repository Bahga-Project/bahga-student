import 'package:cloud_firestore/cloud_firestore.dart';

class Subject {
  final String code;
  final DateTime createdAt;
  final int creditHours;
  final String? description;
  final bool isActive;
  final String name;

  Subject({
    required this.code,
    required this.createdAt,
    required this.creditHours,
    this.description,
    required this.isActive,
    required this.name,
  });

  // Convert Firestore document to Subject object
  factory Subject.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Subject(
      code: data['code'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      creditHours: data['creditHours'] as int,
      description: data['description'] as String?,
      isActive: data['isActive'] as bool,
      name: data['name'] as String,
    );
  }


  // 'id': 'math',
  // 'name': 'Mathematics',
  // 'icon': Icons.calculate,
  // 'color': '0xFFFF6B6B',
  // 'lessons': [
  // {
  // "title": "Lesson 1",
  // "description": "Math Lesson 1 Content",
  // 'topics': [
  // {
  // 'type': 'Documents',
  // 'title': 'Math Chapter 1',
  // 'url': 'https://example.com/physics_ch1.pdf',
  // 'content': ''
  // },
  // {
  // 'type': 'Notes',
  // 'title': 'Math Handwritten Notes',
  // 'url': 'https://example.com/physics_ch1.pdf',
  // 'content': 'This is a note about Math Chapter 1.'
  // },
  // ]
  // }


  // Convert Subject object to JSON for Firestore
  Map<String, dynamic> toJson() => {
    'code': code,
    'createdAt': Timestamp.fromDate(createdAt),
    'creditHours': creditHours,
    'description': description,
    'isActive': isActive,
    'name': name,
  };
}
