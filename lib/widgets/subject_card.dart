import 'package:flutter/material.dart';
import 'package:bahga_student/screens/material_screen.dart';

import '../colors.dart';
import '../screens/lessons_screen.dart';

class SubjectCard extends StatelessWidget {
  final Map<String, dynamic> subject;

  const SubjectCard({required this.subject, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Color(int.parse(subject['color'])),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LessonScreen(
                subjectName: subject['name'],
                appBarColor: Color(int.parse(subject['color'])),
                lessons: subject['lessons'],
              ),
            ),
          );
          // Navigator.push(
          //   context,
          //   LessonScreen(
          //     subjectName: 'Subject Name',
          //     appBarColor: AppColors.white,
          //     lessons: subject['materials'],
          //   ),
          //   // MaterialPageRoute(
          //   //   builder: (context) => MaterialScreen(
          //   //     subjectName: subject['name'],
          //   //     appBarColor: Color(int.parse(subject['color'])),
          //   //     materials: (subject['materials'] as List?)?.cast<Map<String, dynamic>>() ?? [],
          //   //   ),
          //   // ),
          // );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                // Icons.abc,
          // Icons.subject,
                subject['icon'],
                // Icons.computer,
                // ,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                subject['name'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  IconData parseIconFromString(String? iconName) {
    switch (iconName?.toLowerCase()) {
      case 'calculate':
        return Icons.calculate;
      case 'language':
        return Icons.language;
      case 'computer':
        return Icons.computer;
      case 'science':
        return Icons.science;
      case 'lightbulb':
        return Icons.lightbulb;
      case 'local_florist':
        return Icons.local_florist;
      case 'book':
        return Icons.book;
      case 'menu_book':
        return Icons.menu_book;
      case 'map':
        return Icons.map;
      case 'library_books':
        return Icons.library_books;
      default:
        return Icons.subject; // Default icon
    }
  }
}