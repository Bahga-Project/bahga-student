import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/screens/main_screen.dart';
import 'package:bahga_student/routes/route_names.dart';

class MenuSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHandle(),
          SizedBox(height: 20),
          _buildUserProfile(),
          SizedBox(height: 30),
          _buildMenuGrid(context),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          child: Icon(Icons.person, size: 35, color: AppColors.primaryColor),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kauan Sousa",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "Class: 10 A - English",
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              "Roll No: 31",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuGrid(BuildContext context) {
    final menuItems = [
      {'icon': Icons.calendar_today, 'label': 'Attendance'},
      {'icon': Icons.schedule, 'label': 'Timetable'},
      {'icon': Icons.announcement, 'label': 'Notice Board'},
      {'icon': Icons.assignment, 'label': 'Exams'},
      {'icon': Icons.assessment, 'label': 'Result'},
      {'icon': Icons.settings_applications_sharp, 'label': 'Settings'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return _buildMenuItem(
          context: context,
          icon: menuItems[index]['icon'] as IconData,
          label: menuItems[index]['label'] as String,
        );
      },
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => _handleMenuTap(context, label),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 40),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _handleMenuTap(BuildContext context, String label) {
    Navigator.pop(context); // Close menu sheet
    switch (label) {
      case 'Attendance':
        Navigator.of(context, rootNavigator: true).pushNamed(RouteNames.Attendance);
        break;
      case 'Timetable':
        Navigator.of(context, rootNavigator: true).pushNamed(RouteNames.Timetable);
        break;
      case 'Notice Board':
        Navigator.of(context, rootNavigator: true).pushNamed(RouteNames.Notice_board);

        break;
      case 'Exams':
        MainScreen.globalKey.currentState?.changeTab(2);
        break;
      case 'Result':
        MainScreen.globalKey.currentState?.changeTab(3);
        break;

      case 'Settings':
        Navigator.of(context, rootNavigator: true).pushNamed(RouteNames.Settings); // Settings tab index
        break;
      default:
        break;
    }
  }
}