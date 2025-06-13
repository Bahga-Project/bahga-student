import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/widgets/custom_app_bar.dart';
import 'package:bahga_student/widgets/exam_details_card.dart';

class ExamTimetablePage extends StatelessWidget {
  const ExamTimetablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: "Exam Timetable",
        backgroundColor: AppColors.primaryColor,
        showBackButton: true,
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Exam Timetable",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Mid Year Exam 2023",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          // English Card
          ExamCard(
            subject: "English",
            marks: "100 Marks",
            type: "Theory",
            date: "18-06-2025",
            time: "10:30 AM - 12:30 AM",
          ),
          _buildDivider(),

          // Mathematics
          ExamCard(
            subject: "Mathematics",
            marks: "50 Marks",
            type: "Theory",
            date: "20-06-2025",
            time: "10:30 AM - 12:30 AM",
          ),
          _buildDivider(),

          // Biology
          ExamCard(
            subject: "Biology",
            marks: "100 Marks",
            type: "Practical",
            date: "21-06-2025",
            time: "10:30 AM - 12:30 AM",
          ),
          _buildDivider(),

          // Hindi
          ExamCard(
            subject: "Chemistry",
            marks: "100 Marks",
            type: "Theory",
            date: "23-06-2025",
            time: "10:30 AM - 12:30 AM",
          ),
          _buildDivider(),

          // Environmental Studies
          ExamCard(
            subject: "Computer Science",
            marks: "50 Marks",
            type: "Theory",
            date: "25-06-2025",
            time: "10:30 AM - 12:30 AM",
          ),
          _buildDivider(),

          // Art and Craft
          ExamCard(
            subject: "History",
            marks: "50 Marks",
            type: "Theory",
            date: "27-06-2025",
            time: "10:30 AM - 12:30 AM",
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey.shade50,
      ),
    );
  }
}