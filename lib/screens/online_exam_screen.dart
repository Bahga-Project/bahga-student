import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/widgets/custom_app_bar.dart';
import 'package:bahga_student/widgets/empty_state_message.dart';
import 'package:url_launcher/url_launcher.dart';

class OnlineExamScreen extends StatelessWidget {
  final String examName;

  const OnlineExamScreen({Key? key, required this.examName}) : super(key: key);


  final List<Map<String, dynamic>> onlineExams = const [
    {
      'title': 'Math Quiz',
      'description': 'Covers Algebra and Geometry',
      'url': 'https://example.com/math-quiz',
      'date': '2025-06-12',
    },
    {
      'title': 'Science Quiz',
      'description': 'Physics and Chemistry',
      'url': 'https://example.com/science-quiz',
      'date': '2025-06-13',
    },
    {
      'title': 'English Quiz',
      'description': 'Grammar and Vocabulary',
      'url': 'https://example.com/english-quiz',
      'date': '2025-06-12',
    },
  ];


  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {

      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    final filteredExams = onlineExams.where((exam) => exam['title'].toLowerCase().contains(examName.toLowerCase())).toList();

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
      body: filteredExams.isEmpty
          ?  EmptyStateMessage(
        imagePath: 'assets/animations/Work time.gif',
        message: "No online exams found!",
      )
          : ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: filteredExams.length,
        itemBuilder: (context, index) {
          final exam = filteredExams[index];
          return _buildExamCard(context, exam);
        },
      ),
    );
  }

  Widget _buildExamCard(BuildContext context, Map<String, dynamic> exam) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          exam['title'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (exam['description'] != null)
              Text(
                exam['description'],
                style: TextStyle(color: AppColors.textColor),
              ),
            const SizedBox(height: 4),
            Text(
              'Date: ${exam['date']}',
              style: TextStyle(color: AppColors.textColor, fontSize: 12),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _launchURL(exam['url']),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Start Exam'),
            ),
          ],
        ),
      ),
    );
  }
}