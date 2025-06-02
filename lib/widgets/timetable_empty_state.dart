import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';

class TimetableEmptyState extends StatelessWidget {
  final String message;

  const TimetableEmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.event_busy,
          size: 50,
          color: AppColors.textColor.withOpacity(0.6),
        ),
        const SizedBox(height: 10),
        Text(
          message,
          style: TextStyle(
            color: AppColors.textColor.withOpacity(0.6),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}