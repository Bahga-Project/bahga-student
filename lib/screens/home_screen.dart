import 'package:bahga_student/service/subject_service.dart';
import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/utils.dart';
import 'package:bahga_student/widgets/custom_app_bar.dart';
import 'package:bahga_student/widgets/student_timetable_card.dart';
import 'package:bahga_student/widgets/timetable_empty_state.dart';
import 'package:bahga_student/widgets/subject_card.dart';

import '../models/subject_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SubjectService _subjectService = SubjectService();

  // State variables
  List<Subject> subjects = [];
  bool isLoadingSubjects = true;
  bool showAllTimetable = false;
  bool showAllSubjects = false;

  // Timetable data
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

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  /// Load subjects from the service
  Future<void> _loadSubjects() async {
    try {
      setState(() {
        isLoadingSubjects = true;
      });

      final loadedSubjects = await _subjectService.getAllSubjects();

      setState(() {
        subjects = loadedSubjects;
        isLoadingSubjects = false;
      });
    } catch (e) {
      setState(() {
        isLoadingSubjects = false;
      });

      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load subjects: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Check if today is a holiday
  bool isHoliday() {
    final today = DateTime.now();
    return today.weekday == DateTime.saturday ||
        today.weekday == DateTime.sunday;
  }

  /// Get subject details for timetable display
  Map<String, dynamic> getSubjectDetails(String subjectId) {
    return _subjectService.getSubjectDetailsMap(subjectId);
  }

  /// Convert Subject to Map for SubjectCard compatibility
  Map<String, dynamic> subjectToMap(Subject subject) {
    return {
      'id': subject.id,
      'name': subject.name,
      'icon': subject.icon,
      'color': subject.color,
      'lessons': subject.lessons
    };
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
      body: RefreshIndicator(
        onRefresh: _loadSubjects,
        child: SingleChildScrollView(
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
                  if (subjects.length > 4)
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
      ),
    );
  }

  Widget _buildTimetable() {
    if (isHoliday() || timetable.isEmpty) {
      return const Center(
        child: TimetableEmptyState(
          message: 'No classes today, it is holiday!',
        ),
      );
    }

    final displayTimetable =
    showAllTimetable ? timetable : timetable.take(3).toList();

    return Column(
      children: [
        ...displayTimetable.map((entry) {
          final subjectDetails = getSubjectDetails(entry['subjectId']);
          print(
              'HomeScreen: Processing subjectId: ${entry['subjectId']}, Found: ${subjectDetails['name']}');
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
        if (timetable.length > 3)
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
    if (isLoadingSubjects) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (subjects.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'No subjects available',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    final displaySubjects =
    showAllSubjects ? subjects : subjects.take(4).toList();

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
      itemBuilder: (context, index) {
        final subject = displaySubjects[index];
        return SubjectCard(
          subject: subjectToMap(subject),
        );
      },
    );
  }
}