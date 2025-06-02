import 'package:flutter/material.dart';
import 'package:bahga_student/screens/splash_screen.dart';
import 'package:bahga_student/screens/login_screen.dart';
import 'package:bahga_student/screens/home_screen.dart';
import 'package:bahga_student/screens/main_screen.dart';
import 'package:bahga_student/screens/notifications_screen.dart';
import 'package:bahga_student/screens/terms_screen.dart';
import 'package:bahga_student/screens/about_us_screen.dart';
import 'package:bahga_student/screens/contact_us_screen.dart';
import 'package:bahga_student/screens/attendance_screen.dart';
import 'package:bahga_student/screens/timetable_screen.dart';
import 'package:bahga_student/screens/notice_board_screen.dart';
import 'package:bahga_student/screens/settings_screen.dart';
import 'package:bahga_student/screens/material_screen.dart';
import 'package:bahga_student/screens/assignment_detail_screen.dart'; // Import new screen
import 'route_names.dart';

class AppRoutesMap {
  static Map<String, WidgetBuilder> routes = {
    RouteNames.splash: (context) => SplashScreen(),
    RouteNames.login: (context) => StudentLoginScreen(),
    RouteNames.home: (context) => HomeScreen(),
    RouteNames.mainScreen: (context) => MainScreen(),
    RouteNames.Notifications: (context) => NotificationsScreen(),
    RouteNames.Terms: (context) => TermsScreen(),
    RouteNames.About_us: (context) => AboutUsScreen(),
    RouteNames.Contact_us: (context) => ContactUsScreen(),
    RouteNames.Attendance: (context) => AttendanceScreen(),
    RouteNames.Timetable: (context) => TimetableScreen(),
    RouteNames.Notice_board: (context) => NoticeBoardScreen(),
    RouteNames.Settings: (context) => SettingsScreen(),
    // RouteNames.Material: (context) => MaterialScreen(),
    RouteNames.AssignmentDetail: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return AssignmentDetailScreen(
        assignment: args['assignment'],
        onSubmit: args['onSubmit'],
      );
    },
  };
}