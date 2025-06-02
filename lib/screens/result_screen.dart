import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/widgets/custom_app_bar.dart';
import 'package:bahga_student/widgets/empty_state_message.dart';
import 'package:bahga_student/widgets/subject_chip.dart';
import 'package:bahga_student/widgets/result_card.dart';
import 'package:bahga_student/screens/result_details_screen.dart';
import 'package:bahga_student/models/result_model.dart';

class ResultsScreen extends StatefulWidget {
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool isOfflineSelected = true;
  String selectedSubject = "All Subjects";

  final List<String> subjects = [
    "English - Theory",
    "Mathematics - Theory",
    "Science - Theory",
  ];

  final List<ResultModel> allResults = [
    ResultModel(
      examName: "Mid Year Exam 2023",
      date: "01-11-2023",
      grade: "A",
      percentage: "93.56",
      subject: "English - Theory",
      isOffline: true,
      totalObtained: 45.0,
      totalMarks: 50.0,
      subjects: [
        {"name": "Math", "obtained": 95, "total": 100},
        {"name": "Science", "obtained": 93, "total": 100},
        {"name": "English", "obtained": 94, "total": 100},
      ],
    ),
    ResultModel(
      examName: "Final Exam 2023",
      date: "15-12-2023",
      grade: "B+",
      percentage: "85.00",
      subject: "Mathematics - Theory",
      isOffline: false,
      totalObtained: 45.0,
      totalMarks: 50.0,
      subjects: [
        {"name": "Math", "obtained": 95, "total": 100},
        {"name": "Science", "obtained": 93, "total": 100},
        {"name": "English", "obtained": 94, "total": 100},
      ],
    ),
    ResultModel(
      examName: "Science Quiz",
      date: "05-12-2023",
      grade: "A",
      percentage: "90.00",
      subject: "Science - Theory",
      isOffline: true,
      totalObtained: 45.0,
      totalMarks: 50.0,
      subjects: [
        {"name": "Math", "obtained": 95, "total": 100},
        {"name": "Science", "obtained": 93, "total": 100},
        {"name": "English", "obtained": 94, "total": 100},
      ],
    ),
  ];

  List<ResultModel> get filteredResults {
    return allResults.where((result) {
      final matchesSubject = selectedSubject == "All Subjects" ||
          result.subject == selectedSubject;
      return  matchesSubject;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: "Results",
        backgroundColor: AppColors.primaryColor,
        showBackButton: true,
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Results",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: _buildSubjectFilter(),
          ),
          _buildResultsList(),
        ],
      ),
    );
  }

  Widget _buildSubjectFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SubjectChip(
            subject: "All Subjects",
            isSelected: selectedSubject == "All Subjects",
            onTap: () => setState(() => selectedSubject = "All Subjects"),
          ),
          ...subjects.map((subject) {
            return SubjectChip(
              subject: subject,
              isSelected: selectedSubject == subject,
              onTap: () => setState(() => selectedSubject = subject),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildResultsList() {
    final results = filteredResults;

    return Expanded(
      child: results.isEmpty
          ? EmptyStateMessage(
        imagePath: 'assets/animations/Work time.gif',
        message: "No Results Available!",
      )
          : ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];
          return ResultCard(
            examName: result.examName,
            date: result.date,
            grade: result.grade,
            percentage: result.percentage,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultDetailsPage(result: result),
                ),
              );
            },
          );
        },
      ),
    );
  }
}