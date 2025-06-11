import 'package:bahga_student/screens/topic_screen.dart';
import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import '../models/subject_model.dart';

class LessonScreen extends StatelessWidget {
  final String subjectName;
  final Color appBarColor;
  final List<Lesson> lessons;

  const LessonScreen({
    Key? key,
    required this.subjectName,
    required this.appBarColor,
    required this.lessons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          subjectName,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
        ),
        backgroundColor: appBarColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: lessons.isEmpty
          ? const Center(
        child: Text(
          'No lessons available.',
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(lesson.title),
              subtitle: Text(lesson.description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TopicScreen(
                      lessonTitle: lesson.title,
                      topics: lesson.topics,
                      barColor: appBarColor,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}