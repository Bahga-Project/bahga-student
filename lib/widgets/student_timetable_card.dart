import 'package:flutter/material.dart';

class TimetableCard extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String subject;
  final String className;
  final String? teacher;
  final IconData icon;
  final Color iconColor;

  const TimetableCard({
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.className,
    this.teacher,
    required this.icon,
    required this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$startTime - $endTime",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Subject: $subject",
                    style: const TextStyle(fontSize: 14),
                  ),
                  if (teacher != null)
                    Text(
                      "Teacher: $teacher",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}