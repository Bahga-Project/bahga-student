import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/utils.dart';
import 'package:bahga_student/widgets/custom_app_bar.dart';
import 'package:bahga_student/widgets/student_timetable_card.dart';
import 'package:bahga_student/widgets/timetable_empty_state.dart';
import 'package:bahga_student/widgets/subject_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> timetable = [
    {
      'startTime': '07:30 AM',
      'endTime': '09:00 AM',
      'subjectId': 'math',
      'teacher': 'Ali Ahmed',
      'className': '',
    },
    {
      'startTime': '07:30 AM',
      'endTime': '09:00 AM',
      'subjectId': 'arab',
      'teacher': 'Sara Abbas',
      'className': '',
    },
    {
      'startTime': '07:30 AM',
      'endTime': '09:00 AM',
      'subjectId': 'cs',
      'teacher': 'Rohby',
      'className': '',
    },
    {
      'startTime': '07:30 AM',
      'endTime': '09:00 AM',
      'subjectId': 'chem',
      'teacher': 'Rohby',
      'className': '',
    },
    {
      'startTime': '07:30 AM',
      'endTime': '09:00 AM',
      'subjectId': 'phys',
      'teacher': 'Rohby',
      'className': '',
    },
    {
      'startTime': '09:00 AM',
      'endTime': '10:00 AM',
      'subjectId': 'eng',
      'teacher': 'Mona Kareem',
      'className': '',
    },
    {
      'startTime': '09:00 AM',
      'endTime': '10:00 AM',
      'subjectId': 'hist',
      'teacher': 'Mona Kareem',
      'className': '',
    },
    {
      'startTime': '09:00 AM',
      'endTime': '10:00 AM',
      'subjectId': 'geo',
      'teacher': 'Mona Kareem',
      'className': '',
    },

  ];

  final List<Map<String, dynamic>> subjects = [
    {
      'id': 'chem',
      'name': 'Chemistry',
      'icon': Icons.science,
      'color': '0xFFD8B4FE',
      'materials': [
        {'type': 'Links', 'title': 'Chemistry Resource Link', 'url': 'https://example.com/chemistry_resource'},
        {'type': 'Notes', 'title': 'Chemistry Notes', 'content': 'Chemistry notes for the first chapter.'},
      ],
    },
    {
      'id': 'phys',
      'name': 'Physics',
      'icon': Icons.lightbulb,
      'color': '0xFFA3E635',
      'materials': [
        {'type': 'Documents', 'title': 'Physics Chapter 1', 'url': 'https://example.com/physics_ch1.pdf'},
        {'type': 'Videos', 'title': 'Physics Lecture 1', 'url': 'https://example.com/physics_lecture_1.mp4'},
      ],
    },
    {
      'id': 'bio',
      'name': 'Biology',
      'icon': Icons.local_florist,
      'color': '0xFF4ADE80',
      'materials': [
        {'type': 'Videos', 'title': 'Biology Lecture 1', 'url': 'https://example.com/biology_lecture_1.mp4'},
        {'type': 'Notes', 'title': 'Biology Notes', 'content': 'Notes on Biology Chapter 1.'},
      ],
    },
    {
      'id': 'arab',
      'name': 'Arabic',
      'icon': Icons.book,
      'color': '0xFF60A5FA',
      'materials': [],
    },
    {
      'id': 'hist',
      'name': 'History',
      'icon': Icons.menu_book,
      'color': '0xFF9E9E9E',
      'materials': [
        {'type': 'Documents', 'title': 'History Chapter 1', 'url': 'https://example.com/history_ch1.pdf'},
        {'type': 'Links', 'title': 'History Resource Link', 'url': 'https://example.com/history_resource'},
      ],
    },
    {
      'id': 'eng',
      'name': 'English',
      'icon': Icons.language,
      'color': '0xFF607D8B',
      'materials': [
        {'type': 'Videos', 'title': 'English Lecture 1', 'url': 'https://example.com/english_lecture_1.mp4'},
        {'type': 'Links', 'title': 'English Resource Link', 'url': 'https://example.com/english_resource'},
      ],
    },
    {
      'id': 'math',
      'name': 'Mathematics',
      'icon': Icons.calculate,
      'color': '0xFFFF6B6B',
      'materials': [
        {'type': 'Documents', 'title': 'Algebra Basics', 'url': 'https://example.com/algebra_basics.pdf'},
        {'type': 'Notes', 'title': 'Geometry Notes', 'content': 'Key concepts in geometry for grade 10.'},
      ],
    },
    {
      'id': 'geo',
      'name': 'Geography',
      'icon': Icons.map,
      'color': '0xFF4CAF50',
      'materials': [
        {'type': 'Links', 'title': 'World Geography Resources', 'url': 'https://example.com/geography_resource'},
        {'type': 'Videos', 'title': 'Climate Zones Lecture', 'url': 'https://example.com/climate_zones.mp4'},
      ],
    },
    {
      'id': 'cs',
      'name': 'Computer Science',
      'icon': Icons.computer,
      'color': '0xFF00ACC1',
      'materials': [
        {'type': 'Documents', 'title': 'Programming Basics', 'url': 'https://example.com/programming_basics.pdf'},
        {'type': 'Links', 'title': 'Coding Tutorial', 'url': 'https://example.com/coding_tutorial'},
      ],
    },
    {
      'id': 'lit',
      'name': 'Literature',
      'icon': Icons.library_books,
      'color': '0xFFF06292',
      'materials': [],
    },
  ];

  bool showAllTimetable = false;
  bool showAllSubjects = false;

  //bool isHoliday() => true; // for test empty view.
  bool isHoliday() {
    final today = DateTime.now();
    return today.weekday == DateTime.saturday || today.weekday == DateTime.sunday;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: "",
        titleWidget: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/student_avatar.png'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Kauan Sousa",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    "Class: 10 A",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.message,
              color: AppColors.white,
            ),
            onPressed: () {
              print("Chat icon pressed from HomeScreen!");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Today's Timetable Section
            const Text(
              "Today's Timetable",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 15),
            _buildTimetable(),
            const SizedBox(height: 30),

            // My Subjects Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Subjects",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      showAllSubjects = !showAllSubjects;
                    });
                  },
                  child: Text(
                    showAllSubjects ? "View Less" : "View All",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildSubjectsGrid(),
          ],
        ),
      ),

    );
  }

  Widget _buildTimetable() {
    if (isHoliday() || timetable.isEmpty) {
      return const Center(
        child: TimetableEmptyState(
          message: ' No classes today , it is holiday!',
        ),
      );
    }

    final displayTimetable = showAllTimetable ? timetable : timetable.take(3).toList();

    return Column(
      children: [
        ...displayTimetable.map((entry) {
          final subjectDetails = getSubjectDetails(entry['subjectId'], subjects);
          print('HomeScreen: Processing subjectId: ${entry['subjectId']}, Found: ${subjectDetails['name']}');
          return Column(
            children: [
              TimetableCard(
                startTime: entry['startTime'],
                endTime: entry['endTime'],
                subject: subjectDetails['name'],
                className: entry['className'],
                teacher: entry['teacher'],
                icon: subjectDetails['icon'],
                iconColor: subjectDetails['color'],
              ),
              const SizedBox(height: 15),
            ],
          );
        }).toList(),
        if (timetable.length > 2)
          TextButton(
            onPressed: () {
              setState(() {
                showAllTimetable = !showAllTimetable;
              });
            },
            child: Text(
              showAllTimetable ? "View Less" : "View More",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSubjectsGrid() {
    final displaySubjects = showAllSubjects ? subjects : subjects.take(4).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      itemCount: displaySubjects.length,
      itemBuilder: (context, index) => SubjectCard(subject: displaySubjects[index]),
    );
  }



}