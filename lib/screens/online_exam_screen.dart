import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/widgets/custom_app_bar.dart';

class OnlineExamScreen extends StatelessWidget {
  final String examName;

  const OnlineExamScreen({Key? key, required this.examName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: examName,
        backgroundColor: AppColors.primaryColor,
        showBackButton: true,
        titleWidget: Text(
          examName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "Online Exam: $examName\n(To be implemented)",
          style: TextStyle(fontSize: 18, color: AppColors.textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}