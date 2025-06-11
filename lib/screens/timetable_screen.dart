import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/utils.dart' hide getCurrentDay;
import 'package:bahga_student/widgets/custom_app_bar.dart';
import 'package:bahga_student/models/timetable_data.dart';
import 'package:bahga_student/widgets/student_timetable_card.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  late String selectedDay;


  final List<Map<String, dynamic>> subjects = [
    {
      'id': 'chem',
      'name': 'Chemistry',
      'icon': Icons.science,
      'color': '0xFFD8B4FE',
      'materials': [],
    },
    {
      'id': 'phys',
      'name': 'Physics',
      'icon': Icons.lightbulb,
      'color': '0xFFA3E635',
      'materials': [],
    },
    {
      'id': 'bio',
      'name': 'Biology',
      'icon': Icons.local_florist,
      'color': '0xFF4ADE80',
      'materials': [],
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
      'materials': [],
    },
    {
      'id': 'eng',
      'name': 'English',
      'icon': Icons.language,
      'color': '0xFF607D8B',
      'materials': [],
    },
    {
      'id': 'math',
      'name': 'Mathematics',
      'icon': Icons.calculate,
      'color': '0xFFFF6B6B',
      'materials': [],
    },
    {
      'id': 'geo',
      'name': 'Geography',
      'icon': Icons.map,
      'color': '0xFF4CAF50',
      'materials': [],
    },
    {
      'id': 'cs',
      'name': 'Computer Science',
      'icon': Icons.computer,
      'color': '0xFF00ACC1',
      'materials': [],
    },
    {
      'id': 'lit',
      'name': 'Literature',
      'icon': Icons.library_books,
      'color': '0xFFF06292',
      'materials': [],
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedDay = getCurrentDay(); // Use getCurrentDay from timetable_data.dart
    print('Selected day initialized: $selectedDay');
  }

  @override
  Widget build(BuildContext context) {
    final customAppBar = CustomAppBar(
      title: "Timetable",
      backgroundColor: AppColors.primaryColor,
      showBackButton: true,
      titleWidget: const Text(
        "Timetable",
        style: TextStyle(
          color: AppColors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    final appBarHeight = customAppBar.preferredSize.height + MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: customAppBar,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 60),
              Container(
                height: 80,
                color: AppColors.backgroundColor,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildDayTab("Sun"),
                      _buildDayTab("Mon"),
                      _buildDayTab("Tue"),
                      _buildDayTab("Wed"),
                      _buildDayTab("Thu"),
                      _buildDayTab("Fri"),
                      _buildDayTab("Sat"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: timetableData[selectedDay]?.isEmpty ?? true
                    ? Center(
                  child: Text(
                    (selectedDay == "Fri" || selectedDay == "Sat")
                        ? "Holiday"
                        : "No classes for this day",
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textColor_2,
                    ),
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: timetableData[selectedDay]!.length,
                  itemBuilder: (context, index) {
                    final entry = timetableData[selectedDay]![index];
                    print('Processing entry with subjectId: ${entry.subjectId}');
                    final subjectDetails = getSubjectDetails(entry.subjectId, subjects);
                    return Column(
                      children: [
                        TimetableCard(
                          startTime: entry.startTime,
                          endTime: entry.endTime,
                          subject: subjectDetails['name'],
                          className: entry.className,
                          teacher: entry.teacher,
                          icon: subjectDetails['icon'],
                          iconColor: subjectDetails['color'],
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: appBarHeight - 70,
            left: 30,
            right: 30,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "Class - 2 A",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayTab(String day) {
    bool isSelected = selectedDay == day;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDay = day;
          print('Day selected: $day');
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            day,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: isSelected ? 16 : 14,
            ),
          ),
        ),
      ),
    );
  }
}