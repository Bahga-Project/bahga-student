import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';

class ExamCard extends StatelessWidget {
  final String subject;
  final String marks;
  final String type;
  final String date;
  final String time;

  const ExamCard({
    required this.subject,
    required this.marks,
    required this.type,
    required this.date,
    required this.time,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject and Marks row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subject,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor, // Using primaryColor
                  ),
                ),
                Text(
                  marks,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.formTextColor, // Using a color from AppColors
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Type (Theory/Practical)
            Text(
              type,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textColor, // Using textColor
              ),
            ),

            const SizedBox(height: 16),

            // Date and Time
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.formTextColor, // Using formTextColor
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.formTextColor, // Using formTextColor
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
