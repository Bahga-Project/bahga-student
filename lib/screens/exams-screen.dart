import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/widgets/custom_app_bar.dart';
import 'package:bahga_student/widgets/empty_state_message.dart';
import 'package:bahga_student/widgets/subject_chip.dart';
import 'package:bahga_student/screens/exam_timetable_screen.dart';
import 'package:bahga_student/screens/online_exam_screen.dart';

class ExamsScreen extends StatefulWidget {
  @override
  _ExamsScreenState createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  String selectedFilter = "All";

  final List<Map<String, dynamic>> exams = [
    {"name": " Midterm", "date": "2025-06-15", "type": "Offline"},
    {"name": "Science Quiz", "date": "2025-04-10", "type": "Offline"},
    {"name": "English Quiz", "date": "2025-06-12", "type": "Online"},
    {"name": " Final", "date": "2025-06-18", "type": "Offline"},
  ];

  @override
  void initState() {
    super.initState();
    _updateExamStatuses();
  }

  void _updateExamStatuses() {
    final now = DateTime.now();
    for (var exam in exams) {
      final examDate = DateTime.parse(exam["date"]);
      exam["status"] = examDate.isAfter(now) || examDate.isAtSameMomentAs(now) ? "Upcoming" : "Completed";
      // Ensure Midterm or Final exams are Offline
      if (exam["name"].toString().toLowerCase().contains('midterm') ||
          exam["name"].toString().toLowerCase().contains('final')) {
        exam["type"] = "Offline";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredExams = _filterExams();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: "Exams",
        backgroundColor: AppColors.primaryColor,
        showBackButton: true,
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Exams",
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
          // Filters
          _buildFilters(),
          // Exam cards
          Expanded(
            child: filteredExams.isEmpty
                ? EmptyStateMessage(
              imagePath: 'assets/animations/Work time.gif',
              message: "Yee... No Exam found!",
            )
                : ListView.builder(
              itemCount: filteredExams.length,
              itemBuilder: (context, index) =>
                  _buildExamCard(filteredExams[index]),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _filterExams() {
    if (selectedFilter == "All") return exams;
    return exams.where((exam) => exam["status"] == selectedFilter).toList();
  }

  Widget _buildFilters() {
    final filters = ["All", "Upcoming", "Completed"];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: filters.map((filter) {
          return SubjectChip(
            subject: filter,
            isSelected: selectedFilter == filter,
            onTap: () => setState(() => selectedFilter = filter),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExamCard(Map<String, dynamic> exam) {
    final isOnline = exam["type"] == "Online";
    final isMidtermOrFinal = exam["name"].toString().toLowerCase().contains('midterm') ||
        exam["name"].toString().toLowerCase().contains('final');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Text(
          exam["name"],
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Date: ${exam["date"]} • Status: ${exam["status"]}"),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isOnline ? Colors.blue.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                exam["type"],
                style: TextStyle(
                  color: isOnline ? Colors.blue : Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          if (isOnline) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OnlineExamScreen(examName: exam["name"]),
              ),
            );
          } else if (isMidtermOrFinal) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExamTimetablePage()),
            );
          }
        },
      ),
    );
  }
}