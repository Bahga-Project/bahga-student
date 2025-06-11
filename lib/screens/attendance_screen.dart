import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/widgets/custom_app_bar.dart';
import 'package:bahga_student/models/attendance_model.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime selectedMonth = DateTime(2025, 6);
  late AttendanceModel attendanceData;

  @override
  void initState() {
    super.initState();
    attendanceData = AttendanceModel(
      presentDays: [
        DateTime(2025, 6, 1),
        DateTime(2025, 6, 2),
        DateTime(2025, 6, 3),
        DateTime(2025, 6, 4),
        DateTime(2025, 6, 7),
        DateTime(2025, 6, 8),
        DateTime(2025, 6, 10),
        DateTime(2025, 6, 11),
        DateTime(2025, 6, 14)
      ],
      absentDays: [DateTime(2025, 6, 9)],
    );
  }

  void _changeMonth(int direction) {
    setState(() {
      selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + direction);
    });
  }

  int getPresentCount() {
    return attendanceData.presentDays
        .where((day) => day.month == selectedMonth.month && day.year == selectedMonth.year)
        .length;
  }

  int getAbsentCount() {
    return attendanceData.absentDays
        .where((day) => day.month == selectedMonth.month && day.year == selectedMonth.year)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    final customAppBar = CustomAppBar(
      title: "Attendance",
      backgroundColor: AppColors.primaryColor,
      showBackButton: true,
      titleWidget: const Text(
        "Attendance",
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
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height:60), // ضبط المسافة عشان كونتينر الأيام ينزل تحت كونتينر الشهر
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text("Sun", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                            Text("Mon", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                            Text("Tue", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                            Text("Wed", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                            Text("Thu", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                            Text("Fri", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                            Text("Sat", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _buildCalendar(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSummaryCard("TOTAL PRESENT", getPresentCount(), Colors.greenAccent),
                      _buildSummaryCard("TOTAL ABSENT", getAbsentCount(), Colors.redAccent),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            top: appBarHeight -80, // ضبط الـ top عشان نص الكونتينر يتداخل مع الـ AppBar
            left: 30,
            right: 30,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _changeMonth(-1),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                      child: const Icon(
                        Icons.arrow_left,
                        color: AppColors.primaryColor,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    "${_getMonthName(selectedMonth.month)} ${selectedMonth.year}",
                    style: const TextStyle(
                      color: AppColors.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () => _changeMonth(1),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                      child: const Icon(
                        Icons.arrow_right,
                        color: AppColors.textColor,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final firstDayOfMonth = DateTime(selectedMonth.year, selectedMonth.month, 1);
    final lastDayOfMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);
    final startingDay = firstDayOfMonth.weekday % 7;
    final daysInMonth = lastDayOfMonth.day;

    List<Widget> dayWidgets = [];

    for (int i = 0; i < startingDay; i++) {
      dayWidgets.add(const SizedBox.shrink());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final currentDay = DateTime(selectedMonth.year, selectedMonth.month, day);
      bool isPresent = attendanceData.presentDays
          .any((d) => d.day == day && d.month == selectedMonth.month && d.year == selectedMonth.year);
      bool isAbsent = attendanceData.absentDays
          .any((d) => d.day == day && d.month == selectedMonth.month && d.year == selectedMonth.year);

      dayWidgets.add(
        Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isPresent ? Colors.greenAccent : (isAbsent ? Colors.redAccent : Colors.transparent),
          ),
          child: Center(
            child: Text(
              day.toString(),
              style: TextStyle(
                color: isPresent || isAbsent ? AppColors.white : AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: dayWidgets,
    );
  }

  Widget _buildSummaryCard(String title, int count, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: AppColors.white, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month - 1];
  }
}