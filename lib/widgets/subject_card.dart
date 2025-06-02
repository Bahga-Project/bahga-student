import 'package:flutter/material.dart';
import 'package:bahga_student/screens/material_screen.dart';

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
              builder: (context) => MaterialScreen(
                subjectName: subject['name'],
                appBarColor: Color(int.parse(subject['color'])),
                materials: (subject['materials'] as List?)?.cast<Map<String, dynamic>>() ?? [],
              ),
            ),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                subject['icon'],
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
}