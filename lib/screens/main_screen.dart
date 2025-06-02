
import 'package:flutter/material.dart';
import 'package:bahga_student/screens/home_screen.dart';
import 'package:bahga_student/screens/assignments_screen.dart';
import 'package:bahga_student/screens/exams-screen.dart';
import 'package:bahga_student/screens/result_screen.dart';
import 'package:bahga_student/screens/timetable_screen.dart';
import 'package:bahga_student/screens/attendance_screen.dart';
import 'package:bahga_student/screens/notice_board_screen.dart';
import 'package:bahga_student/screens/settings_screen.dart';
import 'package:bahga_student/widgets/custom_bottom_navigation_bar.dart';


class MainScreen extends StatefulWidget {
  static final GlobalKey<_MainScreenState> globalKey = GlobalKey<_MainScreenState>();

  MainScreen({Key? key}) : super(key: globalKey);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    AssignmentsScreen(),
    ExamsScreen(),
    ResultsScreen(),
    SettingsScreen(),

  ];

  void changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
